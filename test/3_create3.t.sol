// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;
import "forge-std/Test.sol";
import "solmate/utils/CREATE3.sol";
import "solmate/test/utils/mocks/MockERC20.sol";

contract Test3 is Test {
  function test_create3() public {
    bytes32 salt = keccak256(bytes("A salt!"));

    MockERC20 deployed = MockERC20(
      CREATE3.deploy(
        salt,
        abi.encodePacked(type(MockERC20).creationCode, abi.encode("Mock Token", "MOCK", 18)),
        0
      )
    );

    assertEq(address(deployed), CREATE3.getDeployed(salt));
    assertEq(deployed.name(), "Mock Token");
    assertEq(deployed.symbol(), "MOCK");
    assertEq(deployed.decimals(), 18);
  }

  function run() external {
    test_create3();
  }
}
