pragma solidity >=0.5.1 <0.6.0;
import "./PermissAbstract.sol";

contract MultiSig is PermissAbstract{
    mapping (address => bool) _owners;

    constructor() public PermissAbstract(){

    }

    function permitted(bytes32[] calldata _permission) external enabledContract returns(bool){
        // TODO: Decide if it's proper for the smart contract to track the nonce or the client software.
        // TODO: We can also get a nonce indirectly by requiring some proximity to block height.
        // TODO: But this comes with its own issues, need a minimum depth to deter reorg issues.
        // TODO: and to essentially naturally limit the window of time when a signature is valid (ie. within x -> y blocks).
        // TODO: Reorgs are low risk in this situation as cost of attack is high
        // TODO: and only those who created or received the message in the first place have the data.
        // TODO: So anyone doing a reorg to exploit this is trivially discovered.
        uint nonce = uint256(_permission[0]);

        for (uint i = 1; i < _permission.length; i++){
            
        }
    }

    function upgrade(bytes32[] calldata _permission) external enabledContract notUpgraded uniqueUpgradeAddress returns(bool){
        revert("Not implemented");
    }
    function enable(bytes32[] calldata _permission) external returns(bool){
        revert("Not implemented");
    }
    function disable(bytes32[] calldata _permission) external enabledContract returns(bool){
        revert("Not implemented");
    }

}