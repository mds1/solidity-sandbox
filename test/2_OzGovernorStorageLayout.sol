// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;
import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/governance/Governor.sol";
import "openzeppelin-contracts-upgradeable/contracts/governance/GovernorUpgradeable.sol";

// forge inspect OzGovernor storage --pretty > data/storage-OzGovernor.txt
// forge inspect OzGovernorUpgradeable storage --pretty > data/storage-OzGovernorUpgradeable.txt

contract OzGovernor is Governor {
  constructor(string memory name_) Governor(name_) {}

  function COUNTING_MODE() public pure override returns (string memory) {
    return "";
  }

  function _countVote(uint256 proposalId, address account, uint8 support, uint256 weight, bytes memory params) internal override {}

  function _getVotes(address account, uint256 blockNumber, bytes memory params ) internal pure override returns (uint256) {
    return 0;
  }

  function _quorumReached(uint256 proposalId) internal pure override returns (bool) {
    return true;
  }

  function _voteSucceeded(uint256 proposalId) internal pure override returns (bool) {
    return true;
  }

  function hasVoted(uint256 proposalId, address account) public pure override returns (bool) {
    return true;
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

contract OzGovernorUpgradeable is GovernorUpgradeable {
  function COUNTING_MODE() public pure override returns (string memory) {
    return "";
  }

  function _countVote(uint256 proposalId, address account, uint8 support, uint256 weight, bytes memory params) internal override {}

  function _getVotes(address account, uint256 blockNumber, bytes memory params ) internal pure override returns (uint256) {
    return 0;
  }

  function _quorumReached(uint256 proposalId) internal pure override returns (bool) {
    return true;
  }

  function _voteSucceeded(uint256 proposalId) internal pure override returns (bool) {
    return true;
  }

  function hasVoted(uint256 proposalId, address account) public pure override returns (bool) {
    return true;
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

contract Test2 is Test {
  function test_OzGovernorStorageLayout() external {

  }
}
