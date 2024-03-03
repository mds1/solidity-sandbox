// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";

contract Test11 is Test {
  uint256 public gas;

  bytes32 public immutable MANAGER_ROLE_IMMUT;
  bytes32 public constant MANAGER_ROLE_CONST = keccak256("MANAGER_ROLE");

  mapping(bytes32 => mapping(address => bool)) public roles;

  constructor() {
    MANAGER_ROLE_IMMUT = keccak256("MANAGER_ROLE");
    roles[MANAGER_ROLE_IMMUT][msg.sender] = true;
    roles[MANAGER_ROLE_CONST][msg.sender] = true;
  }

  function hasRole(bytes32 role, address account) public view returns (bool) {
    return roles[role][account];
  }

  function test_immutableCheck() external {
    gas = gasleft();
    require(hasRole(MANAGER_ROLE_IMMUT, msg.sender), "Caller is not in manager role"); // 24408 gas
    console2.log(gas -= gasleft());
  }

  function test_constantCheck() external {
    gas = gasleft();
    require(hasRole(MANAGER_ROLE_CONST, msg.sender), "Caller is not in manager role"); // 24419 gas
    console2.log(gas -= gasleft());
  }
}
