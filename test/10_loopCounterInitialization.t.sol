// SPDX-License-Identifier: MIT
// Does not initializing the loop counter save gas? It does not.
pragma solidity ^0.8.15;

import "forge-std/Test.sol";

contract Foo1 {
  function bar(uint256 x, uint256 y) public view returns (uint256) {
    uint256 startGas = gasleft();
    for (uint256 i = 0; i < y; i++) {
      x += i;
    }
    console2.log("Foo1", startGas - gasleft());
    return x;
  }
}

contract Foo2 {
  function bar(uint256 x, uint256 y) public view returns (uint256) {
    uint256 startGas = gasleft();
    for (uint256 i; i < y; i++) {
      x += i;
    }
    console2.log("Foo2", startGas - gasleft());
    return x;
  }
}

contract Test10 is Test {
  Foo1 foo1;
  Foo2 foo2;

  function setUp() public {
    foo1 = new Foo1();
    foo2 = new Foo2();
  }

  function test_Gas(uint8 x, uint8 y) public view {
    foo1.bar(x, y);
    foo2.bar(x, y);
  }
}
