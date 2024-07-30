/// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.6;

import "forge-std/Test.sol";

import { Ad, denominator, treasury, admin } from "../src/Ad.sol";

contract Setter {
  function set(Ad ad, string calldata title, string calldata href) external payable {
    ad.set{value: msg.value}(title, href);
  }
}

contract AdTest is Test {
  Ad ad;
  receive() external payable {}

  function setUp() public {
    ad = new Ad();
  }

  function testSetForFree() public {
    string memory title = "Hello world";
    string memory href = "https://example.com";
    ad.set{value: 0}(title, href);
  }

  function testReSetForFree() public {
    string memory title = "Hello world";
    string memory href = "https://example.com";
    ad.set{value: 0}(title, href);
    assertEq(ad.controller(), address(this));
    assertEq(ad.collateral(), 0);
    assertEq(ad.timestamp(), block.timestamp);

    (uint256 price, uint256 taxes) = ad.price();
    assertEq(price, 0);
    assertEq(taxes, 0);
    Setter setter = new Setter();
    setter.set{value: 1}(ad, title, href);
    assertEq(ad.controller(), address(setter));
    assertEq(ad.collateral(), 1);
    assertEq(ad.timestamp(), block.timestamp);
  }

  function testReSetForTooLowPrice() public {
    string memory title = "Hello world";
    string memory href = "https://example.com";
    uint256 value = 1;
    ad.set{value: value}(title, href);

    (uint256 price, uint256 taxes) = ad.price();
    assertEq(price, 1);
    assertEq(taxes, 0);

    Setter setter = new Setter();
    vm.expectRevert(Ad.ErrValue.selector);
    setter.set{value: 1}(ad, title, href);
  }

  function testSet() public {
    string memory title = "Hello world";
    string memory href = "https://example.com";
    uint256 value = 1;
    ad.set{value: value}(title, href);

    assertEq(ad.controller(), address(this));
    assertEq(ad.collateral(), value);
    assertEq(ad.timestamp(), block.timestamp);
  }

  function testReSetForLowerPrice() public {
    string memory title = "Hello world";
    string memory href = "https://example.com";
    uint256 value = denominator;
    ad.set{value: value}(title, href);

    uint256 collateral0 = ad.collateral();
    assertEq(ad.controller(), address(this));
    assertEq(collateral0, value);
    assertEq(ad.timestamp(), block.timestamp);

    vm.warp(block.timestamp+1);

    (uint256 nextPrice1, uint256 taxes1) = ad.price();
    assertEq(nextPrice1, ad.collateral()-1);
    assertEq(taxes1, 1);

    Setter setter = new Setter();
    vm.expectRevert(Ad.ErrValue.selector);
    setter.set{value: collateral0-2}(ad, title, href);
  }

  function testReSet() public {
    string memory title = "Hello world";
    string memory href = "https://example.com";
    uint256 value = denominator;
    ad.set{value: value}(title, href);

    uint256 collateral0 = ad.collateral();
    assertEq(ad.controller(), address(this));
    assertEq(collateral0, value);
    assertEq(ad.timestamp(), block.timestamp);

    vm.warp(block.timestamp+1);

    (uint256 nextPrice1, uint256 taxes1) = ad.price();
    assertEq(nextPrice1, ad.collateral()-1);
    assertEq(taxes1, 1);

    Setter setter = new Setter();
    uint256 balance0 = address(this).balance;
    setter.set{value: ad.collateral()}(ad, title, href);
    uint256 balance1 = address(this).balance;
    assertEq(balance0 - balance1, 1);


    uint256 collateral1 = ad.collateral();
    assertEq(ad.controller(), address(setter));
    assertEq(collateral1, collateral0);
    assertEq(ad.timestamp(), block.timestamp);
  }

  function testRagequitUnauthorized() public {
    string memory title = "Hello world";
    string memory href = "https://example.com";
    uint256 value = 1;
    ad.set{value: value}(title, href);

    vm.expectRevert(Ad.ErrUnauthorized.selector);
    ad.ragequit();
  }

  function testRagequitAsAdmin() public {
    string memory title = "Hello world";
    string memory href = "https://example.com";
    uint256 value = 1;
    ad.set{value: value}(title, href);

    uint256 balance0 = admin.balance;

    vm.prank(admin);
    ad.ragequit();

    uint256 balance1 = admin.balance;
    assertEq(balance0+value, balance1);
  }
}
