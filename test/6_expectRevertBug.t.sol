// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";

contract Foo {
  function mightRevert(bool shouldRevert) external pure {
    if (shouldRevert) revert();
  }
}

contract Test6 is Test {
  function mightRevert(bool shouldRevert) internal pure {
    if (shouldRevert) revert();
  }

  function test_expectRevertBug() external {
    vm.expectRevert();
    mightRevert(true); // Execution halts here.

    console2.log("this never executes");
  }

  function test_expectRevertNormal() external {
    Foo foo = new Foo();
    vm.expectRevert();
    foo.mightRevert(true);
    console2.log("this executes");
  }
}
