// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import
  "openzeppelin-contracts-upgradeable/contracts/governance/extensions/GovernorCountingSimpleUpgradeable.sol";
import
  "openzeppelin-contracts-upgradeable/contracts/governance/TimelockControllerUpgradeable.sol";

contract OzGovernorCountingSimpleUpgradeable is
  GovernorCountingSimpleUpgradeable
{
  function _getVotes(address, uint, bytes memory)
    internal
    pure
    override
    returns (uint)
  {
    return 0;
  }

  function quorum(uint) public pure override returns (uint) {
    return 0;
  }

  function votingDelay() public pure override returns (uint) {
    return 0;
  }

  function votingPeriod() public pure override returns (uint) {
    return 0;
  }
}

contract OzTimelockControllerUpgradeable is TimelockControllerUpgradeable {}

contract Test2 is Test {
  function test_OzGovernorStorageLayout() external {}
}
