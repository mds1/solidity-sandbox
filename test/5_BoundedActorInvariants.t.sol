// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";

contract SampleContract {

    uint256 value;

    function setValue(uint256 value_) external {
        value = value_;
    }

}

contract Actor {

    function callContract(uint256 value_) external {
        // This is a no-op, but it's important to have a function that can be
        // called by an external actor.
    }

}

contract InvariantTest {

    address[] private _excludedContracts;
    address[] private _targetContracts;

    function addTargetContract(address newTargetContract_) internal {
        _targetContracts.push(newTargetContract_);
    }

    function targetContracts() public view returns (address[] memory targetContracts_) {
        require(_targetContracts.length != uint256(0), "NO_TARGET_CONTRACTS");
        return _targetContracts;
    }

    function excludeContract(address newExcludedContract_) internal {
        _excludedContracts.push(newExcludedContract_);
    }

    function excludeContracts() public view returns (address[] memory excludedContracts_) {
        require(_excludedContracts.length != uint256(0), "NO_TARGET_CONTRACTS");
        return _excludedContracts;
    }

}

contract Test5 is Test, InvariantTest {

    Actor          actor;
    SampleContract sampleContract;

    function setUp() public {
        actor          = new Actor();
        sampleContract = new SampleContract();

        excludeContract(address(sampleContract));
    }

    function invariant_placeholder() external {
        assertTrue(true);
    }

}
