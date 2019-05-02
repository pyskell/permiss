pragma solidity >=0.4.21 <0.6.0;

contract PermissInterface{
    bool enabled = true;
    address upgrade_address = address(0x0);
    address previous_address = address(0x0);

    function permitted(bytes32[] memory _permission) public;
    function upgrade(bytes32[] memory _permission) public;
    function enable(bytes32[] memory _permission) public;
    function disable(bytes32[] memory _permission) public;
}