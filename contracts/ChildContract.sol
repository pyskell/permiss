pragma solidity >=0.5.1 <0.6.0;
import "./PermissAbstract.sol";

// This is an example contract, you would alter it for the permission management you want.
// Below is the simplest of contracts, checks for a transaction from a single authorized party.
contract ChildContract is PermissAbstract{
    address _owner;
    constructor(address owner) public PermissAbstract(){
        _owner = owner;
    }

    modifier isOwner{
        require(msg.sender == _owner, "Permission denied. Not an owner.");
        _;
    }

    function permitted(bytes32[] calldata _permission) external view isOwner enabledContract returns(bool){
        return true;
    }
    function upgrade(bytes32[] calldata _permission) external isOwner enabledContract notUpgraded uniqueUpgradeAddress returns(bool){
        return false;
        // upgrade_address = address(_permission[0]);
    }
    function enable(bytes32[] calldata _permission) external returns(bool){
        revert("Not implemented");
    }
    function disable(bytes32[] calldata _permission) external enabledContract returns(bool){
        revert("Not implemented");
    }
}