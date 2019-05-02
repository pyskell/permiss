import "./PermissAbstract.sol";

contract ChildContract is PermissAbstract{
    function permitted(bytes32[] calldata _permission) external returns(bool){
        revert();
    }
    function upgrade(bytes32[] calldata _permission) external{
        revert();
    }
    function enable(bytes32[] calldata _permission) external{
        revert();
    }
    function disable(bytes32[] calldata _permission) external{
        revert();
    }
}