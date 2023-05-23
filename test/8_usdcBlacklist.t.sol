// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

// Apparently in https://github.com/foundry-rs/forge-std/issues/380, the fuzzer was able to
// generate blacklisted addresses for USDC. This test attempts to reproduce that.
contract Test8 is Test {
  IERC20 usdc = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);

  function setUp() public {
    vm.createSelectFork(vm.envString("MAINNET_RPC_URL"), 17_330_951);
  }

  function test_usdcBlacklist(address holder, address spender) external {
    vm.assume(holder != address(0) && spender != address(0));
    vm.prank(holder);
    usdc.approve(spender, 1);
  }
}
