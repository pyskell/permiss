pragma solidity >=0.5.1 <0.6.0;
import "./PermissAbstract.sol";

// This is an example contract, you would alter it for the permission management you want.
// Below is the simplest of contracts, checks for a transaction from a single authorized party.
contract SingleOwner is PermissAbstract{
    address _owner;
    uint _limit; // Total number of blocks a signed message is valid for.

    constructor(address owner, uint limit) public PermissAbstract(){
        _owner = owner;
        _limit = limit;
        require(_limit < 256, "limit must be less than 256"); // Solidity (or the EVM?) only lets a function look back a max of 256 blocks
    }

    modifier isOwner{
        require(msg.sender == _owner, "Permission denied. Not an owner");
        _;
    }

    function permitted(bytes32 nonce) external view isOwner enabledContract returns(bool){
        bool recentNonce = false;
        for(uint i = 0; i < _limit; i++){
            if(nonce == blockhash(block.number - i)){
                recentNonce = true;
                break;
            }
        }
        if(!recentNonce){return false;}

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