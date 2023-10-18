// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {console2, Script} from "forge-std/Script.sol";

contract Hello {
  constructor(uint256 x, uint256 y) {
    // do nothing
  }
}

contract Script1 is Script {
  function run() public noGasMetering {
    bytes memory constructorArgs = abi.encode(uint256(100), address(5));
    bytes32 bytecodeHash = keccak256(abi.encodePacked(type(Hello).creationCode, constructorArgs));

    bytes32 salt = mineSalt(bytecodeHash);
    Hello hello = new Hello{salt: salt}(100, 5);
    console2.log("hello: ", address(hello));
  }

  function mineSalt(bytes32 bytecodeHash) internal pure returns (bytes32 salt) {
    uint256 targetStart = uint16(bytes2(hex"1234"));
    uint256 targetEnd = uint16(bytes2(hex"5678"));

    uint256 i;
    address addr;

    while (uint16(uint160(addr) >> 144) != targetStart || uint16(uint160(addr)) != targetEnd) {
      salt = bytes32(i);
      addr = computeCreate2Address(salt, bytecodeHash, CREATE2_FACTORY);
      i += 1;
    }
  }
}
