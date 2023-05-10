// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";

contract Test5 is Test {
  function test_forkId() external {
    uint256 forkId1 = vm.createSelectFork(getChain(1).rpcUrl);
    uint256 forkId2 = vm.createSelectFork(getChain(1).rpcUrl);
    uint256 forkId3 = vm.createSelectFork(getChain(10).rpcUrl);

    assertEq(forkId1, 0, "forkId1");
    assertEq(forkId2, 1, "forkId2");
    assertEq(forkId3, 2, "forkId3");
  }
}
