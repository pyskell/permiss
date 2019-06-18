pragma solidity >=0.5.1 <0.6.0;
import "./PermissAbstract.sol";

// This is an example contract, you would alter it for the permission management you want.
// Below is the simplest of contracts, checks for a transaction from a single authorized party.
contract SingleOwner is PermissAbstract{
    address owner;
    uint blockDepthLimit; // Total number of blocks a signed message is valid for.

    constructor(address owner_, uint blockDepthLimit_) public PermissAbstract(){
        owner = owner_;
        blockDepthLimit = blockDepthLimit_;
        require(blockDepthLimit < 256, "blockDepthLimit must be less than 256"); // Solidity (or the EVM?) only lets a function look back a max of 256 blocks
    }

    // modifier isOwner{
    //     require(msg.sender == owner, "Permission denied. Not an owner");
    //     _;
    // }

    // We cannot use modifiers because they do not allow return values.
    // Unfortunately when solidity reverts it creates exceptions.
    // This creates more complicated logic for handling success/failure.
    // TODO: Double check all of these and that the right gates are implemented.
    // TODO: Some sort of templating/preprocessing
    function isOwner() internal view returns(bool){
        if (msg.sender != owner){return false;}
    }

    function permitted(bytes32 nonce) external view returns(bool){
        if (msg.sender != owner){return false;}
        if (!enabled){return false;}

        bool recentNonce = false;
        for(uint i = 0; i < blockDepthLimit; i++){
            if(nonce == blockhash(block.number - i)){
                recentNonce = true;
                break;
            }
        }
        if(!recentNonce){return false;}

        return true;
    }
    function upgrade(bytes32[] calldata _permission) external returns(bool){
        if (msg.sender != owner){return false;}
        if (!enabled){return false;}
        if (upgrade_address != address(0x0)){return false;}
        if (upgrade_address == previous_address){return false;}
        if (address(this) == upgrade_address){return false;}

        return false;
        // upgrade_address = address(_permission[0]);
    }
    function enable(bytes32[] calldata _permission) external returns(bool){
        revert("Not implemented");
    }
    function disable(bytes32[] calldata _permission) external returns(bool){
        if (!enabled){return false;}
        revert("Not implemented");
    }
}