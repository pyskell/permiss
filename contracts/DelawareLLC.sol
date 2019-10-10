pragma solidity ^0.5.1;

import "./CapTable.sol";

contract DelawareLLC {
  CapTable capTable;

  constructor (address _capTable) public {
    capTable = CapTable(_capTable);
  }

  struct Address {
    string name;
    string street;
    string city;
    string county;
    string state;
    string country;
  }
  struct Corporation {
    Address registeredOffice;
    Address registeredAgent;
    Address incorporator;
    uint64 maxShares;
    uint64 shareParValue;
  }
}