// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";

/**
 * @dev WARNING: While this example technically "works" it's not actually
 * correct because state is not yet committed between calls in an invariant
 * test. This is being tracked here: https://github.com/foundry-rs/foundry/issues/3005.
 * Additional invariant test issues that will improve the examples in this file
 * once implemented are:
 *   - https://github.com/foundry-rs/foundry/issues/2962
 *   - https://github.com/foundry-rs/foundry/issues/2963
 *   - https://github.com/foundry-rs/foundry/issues/2985
 *   - https://github.com/foundry-rs/foundry/issues/2986
 * Reading through the above will give context on what currently is and is not
 * supported.
 *
 * @dev Invariant testing works as follows:
 *   1. Run `setUp()` and save off resulting state.
 *   2. for (i = 0; i < numberOfInvariantRuns; i++) {
 *        0. Set global state to post `setUp()` state.
 *        1. Check that the invariant holds.
 *        2. Choose random contract + random non-view calldata to call on that
 *           contract. (More info below on how to control what "random" means).
 *        3. If `fail_on_revert = true` and call reverts, invariant failed.
 *        4. If `fail_on_revert = false` and call reverts, continue.
 *        5. Check invariant.
 *        6. Repeat steps 2-5 `depth` number of times.
 *      }
 *
 * @dev This file demonstrates a simple invariant test of making sure a
 * contract's nonce always increases and how you can customize the invariant
 * testing behavior. For more complex invariant testing you'll likely want to
 * use "Actor-Based Invariant Testing". More info on this pattern and examples
 * can be found here: https://github.com/foundry-rs/book/issues/497#issuecomment-1208473205
 *
 * @dev There are `[profile.default.fuzz]` and `[profile.default.invariant]`
 * sections of the `foundry.toml` file you can use to customize behavior. The
 * defaults are shown below. More info here:
 *   - https://book.getfoundry.sh/config/
 *   - https://book.getfoundry.sh/reference/config/testing#fuzz
 *   - https://book.getfoundry.sh/reference/config/testing#invariant
 *
 * [profile.default.fuzz]
 * runs = 256                  # The number of test cases ran for each property test.
 * max_global_rejects = 65536  # When using `vm.assume`, each failed check is a reject. A test fails
 * when it exceeds this number of rejections.
 * dictionary_weight = 40      # Use values collected from your contracts 40% of the time, random
 * 60% of the time.
 * include_storage = true      # Collect values from contract storage and add them to the
 * dictionary.
 * include_push_bytes = true   # Collect PUSH bytes from the contract code and add them to the
 * dictionary.
 *
 * [profile.default.invariant]
 * runs = 256                 # The number of runs for each invariant test.
 * depth = 15                 # The number of calls executed to attempt to break invariants in one
 * run.
 * fail_on_revert = false     # Fails the invariant test if a revert occurs.
 * call_override = false      # Allows overriding an unsafe external call when running invariant
 * tests, e.g. reentrancy checks (this feature is still a WIP).
 * dictionary_weight = 80     # Use values collected from your contracts 80% of the time, random 20%
 * of the time.
 * include_storage = true     # Collect values from contract storage and add them to the dictionary.
 * include_push_bytes = true  # Collect PUSH bytes from the contract code and add them to the
 * dictionary.
 */
contract NonceCounter {
  // Invariant must hold before any calls are made, so we start this at 1 to ensure `1 > 0` and
  // avoid the need for int256s to start `lastNonce` at -1. Once
  // https://github.com/foundry-rs/foundry/issues/2985
  // is implemented we can start this at zero and conditionally skip the check on the first run.
  uint256 public nonce = 1;

  function increment() public {
    nonce++;
  }

  // Comment out this function and the invariant test will pass.
  function decrement() public {
    nonce--;
  }
}

contract Test4 is Test {
  NonceCounter nonceCounter; // Contract under test.
  uint256 lastNonce; // Last nonce seen, this is what we test against.

  function setUp() public {
    nonceCounter = new NonceCounter();
  }

  // There are lots of ways to customize the sender, target contracts, and
  // function selectors called, which you would do here. In this example we have
  // a simple test and don't need that, so forge automatically uses any non-test
  // contract created during `setUp`. For reference, here are the available
  // methods you can use to customize things.
  //
  // By default, there's a 10% chance a random address is used as the sender or
  // a 90% of using an address from the dictionary. When using the below to
  // customize the senders, there's an 80% chance that one from the list is
  // selected. The remaining 20% will either be a random address (10%) or from
  // the dictionary (90%).
  //
  //   function targetSenders() public returns (address[] memory);
  //   function excludeSenders() public returns (address[] memory);
  //
  // By default, each contract is chosen with an equal probability and from
  // there a random function selector is chosen. To customize the target
  // contracts and function selectors (listed in order of priority if there's
  // clashes) you can use the below methods:
  //
  //   struct FuzzAbiSelector {
  //     string contractAbi; // "Contract1","src/Contract2.sol:Contract2"
  //     bytes4[] selectors;
  //   }
  //   function targetArtifactSelectors() public returns (FuzzAbiSelector1[] memory);
  //
  //   struct FuzzSelector {
  //     address addr;
  //     bytes4[] selectors;
  //   }
  //   function targetSelectors() public returns (FuzzSelector[] memory);
  //
  //   function excludeContracts() public returns (address[] memory);
  //   function excludeArtifacts() public returns (string[] memory); //
  // ["Contract1","src/Contract2.sol:Contract2"]
  //   function targetContracts() public returns (address[] memory);
  //   function targetArtifacts() public returns (string[] memory); //
  // ["Contract1","src/Contract2.sol:Contract2"]

  function invariant_NonceGoUp() external {
    console2.log("lastNonce: ", lastNonce);
    uint256 currentNonce = nonceCounter.nonce();
    console2.log("currentNonce: ", currentNonce);
    require(currentNonce > lastNonce, "Invariant violated: Nonce did not increase");
    lastNonce = currentNonce;
  }
}
