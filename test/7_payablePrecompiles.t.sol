// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";

contract Test7 is Test {
  function test_payablePrecompiles() external {
    (bool success,) = payable(address(8)).call{value: 1 ether}("");
    require(success, "call failed");

    payable(address(8)).transfer(1 ether);
  }
}
