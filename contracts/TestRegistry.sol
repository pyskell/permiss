pragma solidity ^0.5.1;

// This contract is only used for testing purposes.
contract TestRegistry {

  mapping(address => uint) public registry;

  function register(uint x) public payable {
    registry[msg.sender] = x;
  }

}
