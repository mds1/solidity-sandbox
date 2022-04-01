// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

import "ds-test/test.sol";
import './console.sol';

contract Target {


}

contract Test4 {
  function test_ext() external { // 3033
    _foo();
  }

  function _foo() internal {
    console.log();
  }

  function test_pub() public { // 3035
    console.log();
  }
}
