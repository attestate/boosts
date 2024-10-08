/// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.13;

import { FixedPointMathLib } from "./FixedPointMathLib.sol";

address constant treasury = 0x1337E2624ffEC537087c6774e9A18031CFEAf0a9;
uint256 constant basePrice = 0.000777 ether;
uint256 constant SECONDS_PER_DAY = 86400;
contract Boost {
  event BoostHref(string href);

  error ErrValue();

  uint256 public lastBoost;

  constructor() {
    lastBoost = block.timestamp;
  }

  function price() public view returns (uint256 nextPrice) {
    uint256 diff = block.timestamp - lastBoost;
    uint256 usagesPerDay = SECONDS_PER_DAY / diff;

    if (usagesPerDay < 1) {
      usagesPerDay = 1;
    }

    nextPrice = usagesPerDay**2 * basePrice;
  }

  function boost(string calldata _href) external payable {
    uint256 nextPrice = price();
    if (msg.value < nextPrice) {
      revert ErrValue();
    }

    lastBoost = block.timestamp;
    emit BoostHref(_href);

    treasury.call{value: msg.value}("");
  }
}
