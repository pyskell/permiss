pragma solidity >=0.5.1 <0.6.0;
import "./ChildContract.sol";

// In general these contracts are designed to be low on state usage.
// This means that the Abstract contract is the only one intended to
// have the stateful variables declared below (and rarely changed).
// While any ChildContract that inherits this contract should not change
// any state after it is deployed.
// We're largely using the blockchain to trustlessly share agreements *and* have
// an easily accessible and consistent execution environment.
// We want to avoid using it in prohibitively costly ways that sacrifice privacy.

contract PermissAbstract{
    bool enabled = true;
    address upgrade_address = address(0x0);
    address previous_address = address(0x0);
    ChildContract child;

    constructor(address _childContractAddress) public{
        child = ChildContract(_childContractAddress);
    }

    // _permissions for each contract function can be the same or different.
    // For example, maybe a minimum of 2 employees are required to call permitted().
    // But a manager has sole control over whether or not the contract is enabled.
    // Most of the modifiers below handle times when permissions for each function are different.
    modifier notUpgraded {
        require(upgrade_address == address(0x0), "Contract already upgraded");
        _;
    }
    modifier enabledContract{
        // Prevents someone pointing a disabled contract to a new address under their control.
        require(enabled == true, "Contract must be enabled");
        _;
    }
    modifier uniqueUpgradeAddress{
        // Prevent the contract referencing itself. Would likely create an infinite loop in client software.
        _;
        require(upgrade_address != previous_address);
    }

    function _permitted(bytes32[] memory _permission) internal returns(bool);
    function _upgrade(bytes32[] memory _permission) internal;
    // _enable should return true if permission to enable the contract is valid.
    function _enable(bytes32[] memory _permission) internal returns(bool);
    // _disable should return true if permission to disable the contract is valid.
    function _disable(bytes32[] memory _permission) internal returns(bool);

    function permitted(bytes32[] calldata _permission) external enabledContract returns(bool){
        _permitted(_permission);
    }
    function upgrade(bytes32[] calldata _permission) external enabledContract notUpgraded uniqueUpgradeAddress {
        _upgrade(_permission);
    }
    function enable(bytes32[] calldata _permission) external{
        if(_enable(_permission) && !enabled){
            enabled = true;
        }
    }
    function disable(bytes32[] calldata _permission) external enabledContract{
        if(_disable(_permission) && enabled){
            enabled = false;
        }
    }
}