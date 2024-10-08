/// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.6;

import "forge-std/Test.sol";

import { Boost, treasury } from "../src/Boost.sol";

uint256 constant SECONDS_PER_DAY = 86400;
contract BoostTest is Test {
  Boost b;
  receive() external payable {}

  function setUp() public {
    b = new Boost();
  }

  function testPrice1() public {
    vm.warp(block.timestamp+SECONDS_PER_DAY/2); // equals 2 uses
    assertEq(b.price(), 0.003108 ether);
  }
  function testPrice2() public {
    vm.warp(block.timestamp+SECONDS_PER_DAY/3); // equals 3 uses
    assertEq(b.price(), 0.006993 ether);
  }
  function testPrice3() public {
    vm.warp(block.timestamp+SECONDS_PER_DAY);
    assertEq(b.price(), 0.000777 ether);
  }
  function testPriceFewDays() public {
    vm.warp(block.timestamp+SECONDS_PER_DAY*3);
    assertEq(b.price(), 0.000777 ether);
  }
  function testBoostFewDays() public {
    vm.warp(block.timestamp+SECONDS_PER_DAY*3);
    b.boost{value: 0.000777 ether}("https://example.com");
  }
  function testBoostMultipleUseADay() public {
    vm.warp(block.timestamp+SECONDS_PER_DAY/2);
    b.boost{value: 0.003108 ether}("https://example.com");
  }
  function testBoostUnderpay() public {
    vm.warp(block.timestamp+SECONDS_PER_DAY);
    vm.expectRevert(Boost.ErrValue.selector);
    b.boost{value: 0.000776 ether}("https://example.com");
  }
}
