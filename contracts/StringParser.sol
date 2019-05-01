pragma solidity >=0.4.20 <0.6.0;

library StringParser {
    function toInt(string memory s) public pure returns (uint256){
        bytes memory b = bytes(s);
        uint256 result = 0;
        for (uint i = 0; i < b.length; i++){
            if (b[i] > hex"30" && b[i] < hex"3A"){
                result = result * 10 + (b[i] - hex"31");
            }
        }
        return result;
    }
    function toAddress(string memory s) public pure returns (address){
        uint256 a = toInt(s);
        return address(uint160(uint256(a)));
    }
}