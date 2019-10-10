pragma solidity ^0.5.1;
contract DelawareLLC {
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