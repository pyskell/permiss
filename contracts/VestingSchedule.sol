pragma solidity ^0.5.1;
contract VestingSchedule {
  address public grantee;
  address public owner;
  string public name;
  uint256 public shares;
  // uint8 vestingRate; // 0 -> 100
  uint16 public vestingPeriod; // in years
  uint16 public year; // just for the demo, long term this needs to be generalized to a DateTime
  bool public disabled;

  constructor (address _grantee, address _owner, string memory _name, uint256 _shares, uint16 _year, uint16 _vestingPeriod) public {
    grantee = _grantee;
    owner = _owner;
    name = _name;
    shares = _shares;
    // vestingRate = _vestingRate;
    vestingPeriod = _vestingPeriod;
    year = _year; // normally 1, as in starts the year this contract is initiated
    disabled = false;
  }

  // TODO: Owner will eventually be generalized to be anything (ex. a multisig, or other agreement)
  modifier isOwner {
    require(msg.sender == owner, "Only the owner of this VestingSchedule may modify it");
    _;
  }

  modifier isEnabled {
    require(!disabled, "Contract is disabled");
    _;
  }

  function disable(bool state) external isOwner {
    disabled = state;
  }

  function vestedPercent() external view isEnabled returns (uint16) {
    if (year >= vestingPeriod) {
      return 100;
    }
    else {
      return year * 100 / vestingPeriod;
    }
  } // 0 -> 100

  function vested() external view isEnabled returns (uint256) {
    return shares * this.vestedPercent() / 100;
  }

  function increaseYear(uint16 amount) external isEnabled returns(uint16) {
    if (year + amount <= vestingPeriod) {
      year = year + amount;
    }

    return year;
  }

  // function equity() external returns (uint256);
}