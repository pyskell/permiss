pragma solidity >=0.5.1 <0.6.0;
import "./PermissAbstract.sol";

// This is an example contract, you would alter it for the permission management you want.
// Below is the simplest of contracts, checks for a transaction from a single authorized party.
contract ChildContract is PermissAbstract{
    address _owner;
    constructor(address owner) public PermissAbstract(address(this)){
        _owner = owner;
    }

    modifier isOwner{
        require(msg.sender == _owner, "Permission denied. Not an owner.");
        _;
    }

    function _permitted(bytes32[] memory _permission) internal isOwner returns(bool){
        return true;
    }
    function _upgrade(bytes32[] memory _permission) internal isOwner returns(bool){
        return false;
        // upgrade_address = address(_permission[0]);
    }
    function _enable(bytes32[] memory _permission) internal returns(bool){
        revert();
    }
    function _disable(bytes32[] memory _permission) internal returns(bool){
        revert();
    }
}