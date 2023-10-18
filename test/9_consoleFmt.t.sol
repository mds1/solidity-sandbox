// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";

contract Test9 is Test {
  function test_consoleFmt() external view {
    uint256 x = 1e18;
    console2.log("x is %s", x);
    console2.log("x is %i", x);
    console2.log("x is %x", x);
    console2.log("x is %e", x);
  }
}
