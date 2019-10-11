pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

import "./CapTable.sol";

contract LLC {
  CapTable capTable;
  Address registeredOffice;
  Address registeredAgent;
  Address incorporator;

  constructor (address _capTable, Address memory _registeredOffice, Address memory _registeredAgent, Address memory _incorporator) public {
    capTable = CapTable(_capTable);
    registeredOffice = _registeredOffice;
    registeredAgent = _registeredAgent;
    incorporator = _incorporator;
  }

  struct Address {
    string name;
    string street;
    string city;
    string county;
    string state;
    string country;
  }

}