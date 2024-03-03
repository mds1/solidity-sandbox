// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";

contract Setter {
  uint public x;

  function set(uint _x) public {
    x = _x;
  }

}

interface ISetter1 {
  // Intentionally incorrectly marked as view
  function set(uint _x) external view;
}

interface ISetter2 {
  // Intentionally incorrectly marked as payable
  function set(uint _x) external payable;
}

interface ISetter3 {
  // Intentionally adds non-existent function
  function foo() external;
}

contract Test12 is Test {
  // Good
  function test_EthBalanceTooLow() external {
    address alice = makeAddr("alice");
    vm.prank(alice);
    payable(address(123)).transfer(1 ether);
  }

  // Good
  function test_StateChangeWileStatic() external {
    ISetter1 setter = ISetter1(address(new Setter()));
    setter.set(1);
  }

  // Bad
  function test_FunctionNotPayable() external {
    ISetter2 setter = ISetter2(address(new Setter()));
    setter.set{value: 1 ether}(1);
  }

  // Bad
  function test_ContractCannotReceive() external {
    Setter setter = Setter(payable(address(new Setter())));
    // Test passes, but trace does not show revert reason
    (bool ok, ) = address(setter).call{value: 1 ether}("");
    assertEq(ok, false);
  }

  // Bad
  function test_AddressHasNoCode() external {
    address setter = makeAddr("setter");
    Setter(setter).set(1);
  }

  // Bad
  function test_FunctionDoesNotExist() external {
    ISetter3 setter = ISetter3(address(new Setter()));
    setter.foo();
  }

  // Bad
  function test_AddressAlreadyHasCode() external {
    new Setter{salt: bytes32(0)}();
    new Setter{salt: bytes32(0)}();
  }
}

