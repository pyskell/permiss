pragma solidity >=0.5.1 <0.6.0;
// import "./SingleOwner.sol";

// In general these contracts are designed to be low on state usage.
// This means that the Abstract contract is the only one intended to
// have the stateful variables declared below (and rarely changed).
// While any ChildContract that inherits this contract should not change
// any state after it is deployed.
// We're largely using the blockchain to trustlessly share agreements *and* have
// an easily accessible and consistent execution environment.
// We want to avoid using it in prohibitively costly ways that sacrifice privacy.

contract PermissAbstract{
    bool public enabled;
    address public upgrade_address;
    address public previous_address;

    constructor() public{
        enabled = true;
        upgrade_address = address(0x0);
        previous_address = address(0x0);
    }

    // _permissions for each contract function can be the same or different.
    // For example, maybe a minimum of 2 employees are required to call permitted().
    // But a manager has sole control over whether or not the contract is enabled.
    // Most of the modifiers below handle times when permissions for each function are different.
    // modifier notUpgraded {
    //     require(upgrade_address == address(0x0), "Contract already upgraded");
    //     _;
    // }
    // modifier enabledContract{
    //     // Prevents someone pointing a disabled contract to a new address under their control.
    //     require(enabled == true, "Contract must be enabled");
    //     _;
    // }
    // modifier uniqueUpgradeAddress{
    //     // Prevent the contract referencing itself. Would likely create an infinite loop in client software.
    //     _;
    //     require(upgrade_address != previous_address, "upgrade_address cannot match previous_address");
    //     require(address(this) != upgrade_address, "upgrade_address cannot match the current contract address");
    // }

    // function notUpgraded() internal view returns(bool){
    //     if (upgrade_address != address(0x0)){return false;}
    // }

    // function enabledContract() internal view returns(bool){
    //     // Prevents someone pointing a disabled contract to a new address under their control.
    //     // Yes this is what we want, no we do not want to return enabled.
    //     // If we returned enabled then any function that used this would return true
    //     // immediately after checking to see if the contract was enabled.
    //     // Skipping any other logic in the function.
    //     if (!enabled){return false;}
    // }

    // function uniqueUpgradeAddress() internal view returns(bool){
    //     if (upgrade_address == previous_address){return false;}
    //     if (address(this) == upgrade_address){return false;}
    // }

    // TODO: Consider switching from returning bool to more informative messages.
    // TODO: Whatever we return must be agnostic to the user interface.
    // TODO: Perhaps a simple tuple of pass/fail (bool) and msg (string).
    // TODO: permitted() is currently a view (doesn't write data). This may not be what we want longterm.
    function permitted() external view returns(bool){revert("Not implemented");}
    function upgrade() external returns (bool){revert("Not implemented");}
    // _enable should return true if permission to enable the contract is valid.
    function enable() external returns(bool){revert("Not implemented");}
    // _disable should return true if permission to disable the contract is valid.
    function disable() external returns(bool){revert("Not implemented");}


    // function permitted(bytes32[] calldata _permission) external enabledContract returns(bool){
    //     return _permitted(_permission);
    // }
    // function upgrade(bytes32[] calldata _permission) external enabledContract notUpgraded uniqueUpgradeAddress returns(bool){
    //     return _upgrade(_permission);
    // }
    // function enable(bytes32[] calldata _permission) external returns(bool){
    //     if(_enable(_permission) && !enabled){
    //         enabled = true;
    //         return true;
    //     }
    //     return false;
    // }
    // function disable(bytes32[] calldata _permission) external enabledContract returns(bool){
    //     if(_disable(_permission) && enabled){ //Restating ourselves for clarity
    //         enabled = false;
    //         return true;
    //     }
    //     return false;
    // }
}