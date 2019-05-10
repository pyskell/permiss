pragma solidity >=0.5.1 <0.6.0;
import "./PermissAbstract.sol";

contract MultiSig is PermissAbstract{
    mapping (address => bool) _owners;

    constructor() public PermissAbstract(){

    }

    // TODO: Code below is largely adapted from MIT-licensed simple-multisig by Christian Lundkvist.
    // TODO: Need to properly attribute.
    // TODO: https://github.com/christianlundkvist/simple-multisig/blob/master/LICENSE.txt
    function permitted(bytes32[] calldata _permission) external enabledContract returns(bool){
        // TODO: Decide if it's proper for the smart contract to track the nonce or the client software.
        // TODO: We can also get a nonce indirectly by requiring some proximity to block height
        // TODO: but this comes with its own issues, need a minimum depth to deter reorg issues.
        // TODO: and to essentially naturally limit the window of time when a signature is valid (ie. within x -> y blocks).
        // TODO: Reorgs are low risk in this situation as cost of attack is high
        // TODO: and only those who created or received the message in the first place have the data.
        // TODO: So anyone doing a reorg to exploit this is trivially discovered.
        uint nonce = uint256(_permission[0]);
        uint8 sigV = uint8(_permission[1]);
        bytes32[] sigR = 

        for (uint i = 1; i < _permission.length; i++){
            
        }
    }

      // Note that address recovered from signatures must be strictly increasing, in order to prevent duplicates
    function execute(uint8[] memory sigV, 
        bytes32[] memory sigR, 
        bytes32[] memory sigS, 
        address destination, 
        uint value, 
        bytes memory data, 
        address executor, 
        uint gasLimit) internal {
    require(sigR.length == threshold);
    require(sigR.length == sigS.length && sigR.length == sigV.length);
    require(executor == msg.sender || executor == address(0));

    // EIP712 scheme: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-712.md
    bytes32 txInputHash = keccak256(abi.encode(TXTYPE_HASH, destination, value, keccak256(data), nonce, executor, gasLimit));
    bytes32 totalHash = keccak256(abi.encodePacked("\x19\x01", DOMAIN_SEPARATOR, txInputHash));

    address lastAdd = address(0); // cannot have address(0) as an owner
    for (uint i = 0; i < threshold; i++) {
      address recovered = ecrecover(totalHash, sigV[i], sigR[i], sigS[i]);
      require(recovered > lastAdd && isOwner[recovered]);
      lastAdd = recovered;
    }

    // If we make it here all signatures are accounted for.
    // The address.call() syntax is no longer recommended, see:
    // https://github.com/ethereum/solidity/issues/2884
    nonce = nonce + 1;
    bool success = false;
    assembly { success := call(gasLimit, destination, value, add(data, 0x20), mload(data), 0, 0) }
    require(success);
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