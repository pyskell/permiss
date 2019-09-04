pragma solidity ^0.5.1;
import "./VestingSchedule.sol";

contract CapTable{
  mapping (address=>VestingSchedule) public vestingSchedules;

  function addSchedule(address schedule) external {
    VestingSchedule vs = VestingSchedule(address(schedule));
    address grantee = address(vs.grantee());
    vestingSchedules[grantee] = vs;
  }

  // function modifySchedule(address grantee, address newSchedule) public {
  //   VestingSchedule vs = vestingSchedules[address(grantee)];
  //   vs.grantee = address(newGrantee); // Expression has to be an lvalue

  //   delete vestingSchedules[address(grantee)];
  //   vestingSchedules[address(newGrantee)] = vs;
  // }
  // Grantee[] grantees;

  // function getVestedPercent(Grantee grantee) public returns (uint8) {
  //   VestingSchedule vestingSchedule = grantee.vestingSchedule;
  //   uint8 vested = vestingSchedule.vestedPercent();

  //   return vested;
  // }

  // function getMaxEquity(Grantee grantee) public returns (uint256) {

  // }
}