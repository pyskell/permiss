pragma solidity ^0.5.1;
contract VestingSchedule {
  address public grantee;
  address public capTable;
  string public name;
  uint256 public shares;
  // uint8 vestingRate; // 0 -> 100
  uint16 public vestingPeriod; // in years
  uint16 public year; // just for the demo, long term this needs to be generalized to a DateTime

  constructor (address _grantee, address _capTable, string memory _name, uint256 _shares, uint16 _year, uint16 _vestingPeriod) public {
    grantee = _grantee;
    capTable = _capTable;
    name = _name;
    shares = _shares;
    // vestingRate = _vestingRate;
    vestingPeriod = _vestingPeriod;
    year = _year; // normally 1, as in starts the year this contract is initiated
  }

  function vestedPercent() external view returns (uint16) {
    if (year >= vestingPeriod) {
      return 100;
    }
    else {
      return year * 100 / vestingPeriod;
    }
  } // 0 -> 100

  function testDivLiteral() external pure returns (uint16) {
    return 1 / 5 * 100;
  }
  // Expected: 20 | Result: 20

  function testDivCast() external pure returns (uint16) {
    return uint16(1) * uint16(100) / uint16(5);
  }
  // Expected: 20 | Result: 20

  function vested() external view returns (uint256) {
    return shares * this.vestedPercent() / 100;
  }

  function increaseYear(uint16 amount) external returns(uint16) {
    if (year + amount <= vestingPeriod) {
      year = year + amount;
    }

    return year;
  }

  // function equity() external returns (uint256);
}