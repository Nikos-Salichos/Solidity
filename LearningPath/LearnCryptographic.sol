pragma solidity >= 0.7.0 < 0.9.0;

/*
Solidity provies the following inbuilt cryptographic functions

keccak256 (bytes memory) returns (bytes32) - leading hashing functions
sha256  (bytes memory) returns (bytes32)
ripemd160 (bytes memory) returns (bytes20)
*/

contract GenerateRandomNumber{
    
    Oracle oracle;
    
    constructor(address oracleAddress){
        oracle = Oracle(oracleAddress);
    }
    
    function randMod(uint range) external view returns(uint){
        //abi.encodePacked concatenate arguments nicely
        //modulus operator % - generate a number within a range
        return uint(keccak256(abi.encodePacked(block.timestamp ,  oracle.rand , block.difficulty, msg.sender ))) & range ;
    }
}

contract Oracle{
    address public admin;
    uint public rand;
    
    constructor() public {
        admin = msg.sender;
    }
    
    function setRand(uint number) public {
        require(msg.sender == admin, 'You are not admin of the contract');
        rand = number;
    }

}






