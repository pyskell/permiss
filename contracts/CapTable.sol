pragma solidity ^0.5.1;

interface CapInterface {
}

contract Grantee {
  address public pubAddress;
  VestingSchedule vestingSchedule;
}

contract CapTable is CapInterface{
  mapping (address=>VestingSchedule) vestingSchedules;
  Grantee[] grantees;

  function getVestedPercent(Grantee grantee) public returns (uint8) {
    VestingSchedule vestingSchedule = vestingSchedules[address(grantee.pubAddress)];
    uint8 vested = vestingSchedule.vestedPercent();

    return vested;
  }
}

contract Schedule {
  Grantee grantee;
  constructor (Grantee _grantee) public {
    grantee = _grantee;
  }

  function vestedPercent() external returns (uint8); // 0 -> 100
  function equity() external returns (uint256);
}

contract VestingSchedule is Schedule {
  constructor (Grantee _grantee) Schedule(_grantee) public {

  }
}