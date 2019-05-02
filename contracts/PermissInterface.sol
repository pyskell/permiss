pragma solidity >=0.4.21 <0.6.0;

contract PermissAbstract{
    bool enabled = true;
    address upgrade_address = address(0x0);
    address previous_address = address(0x0);

    // _permissions for each contract function can be the same or different.
    // For example, maybe a minimum of 2 employees are required to call permitted().
    // But a manager has sole control over whether or not the contract is enabled.
    // Most of the modifiers below handle times when permissions for each function are different.
    modifier notUpgraded {
        require(upgrade_address == address(0x0), "Cannot upgrade a contract more than once");
        _;
    }
    modifier enabledContract{
        // Prevents someone pointing a disabled contract to a new address under their control.
        require(enabled == true, "Can only upgrade a contract that is enabled");
        _;
    }
    modifier uniqueUpgradeAddress{
        // Prevent the contract referencing itself. Would likely create an infinite loop in client software.
        _;
        require(upgrade_address != previous_address);
    }

    function permitted(bytes32[] calldata _permission) external enabledContract{

    }
    function upgrade(bytes32[] calldata _permission) external;
    function enable(bytes32[] calldata _permission) external;
    function disable(bytes32[] calldata _permission) external;
}