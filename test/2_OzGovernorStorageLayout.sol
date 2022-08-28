// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;
import "forge-std/Test.sol";
import "openzeppelin-contracts-upgradeable/contracts/governance/extensions/GovernorCountingSimpleUpgradeable.sol";
import "openzeppelin-contracts-upgradeable/contracts/governance/TimelockControllerUpgradeable.sol";


contract OzGovernorCountingSimpleUpgradeable is GovernorCountingSimpleUpgradeable {
  function _getVotes(address account, uint256 blockNumber, bytes memory params ) internal pure override returns (uint256) {
    return 0;
  }

  function quorum(uint256 blockNumber) public pure override returns (uint256) {
    return 0;
  }

  function votingDelay() public pure override returns (uint256) {
    return 0;
  }

  function votingPeriod() public pure override returns (uint256) {
    return 0;
  }
}

contract OzTimelockControllerUpgradeable is TimelockControllerUpgradeable {}

contract Test2 is Test {
  function test_OzGovernorStorageLayout() external {

  }
}
