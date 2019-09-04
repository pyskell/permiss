pragma solidity ^0.5.1;
import "./VestingSchedule.sol";

contract CapTable{
  mapping (address=>VestingSchedule) public vestingSchedules;

  function addSchedule(address schedule) external {
    VestingSchedule vs = VestingSchedule(address(schedule));
    address grantee = address(vs.grantee());
    vestingSchedules[grantee] = vs;
  }

  function replaceSchedule(address grantee, address newSchedule) public {
    deleteSchedule(grantee);

    VestingSchedule vs = VestingSchedule(address(newSchedule));
    address newGrantee = address(vs.grantee());
    vestingSchedules[newGrantee] = vs;
  }

  function deleteSchedule(address grantee) public {
    VestingSchedule oldSchedule = vestingSchedules[address(grantee)];
    oldSchedule.disable(true);
    delete vestingSchedules[address(grantee)];
  }
  // Grantee[] grantees;

  // function getVestedPercent(Grantee grantee) public returns (uint8) {
  //   VestingSchedule vestingSchedule = grantee.vestingSchedule;
  //   uint8 vested = vestingSchedule.vestedPercent();

  //   return vested;
  // }

  // function getMaxEquity(Grantee grantee) public returns (uint256) {

  // }
}