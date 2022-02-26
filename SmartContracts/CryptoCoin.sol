// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.7.0 < 0.9.0;

//Allow only coin's owner to create to create new coins.

contract CryptoCoin{

    address public minter;
    mapping(address => uint) public balances;
    
    event Sent(address from, address to, uint amount);
    
    //constructor run only onces
    constructor(){
        minter = msg.sender;
    }
    
    //make new coins and send the to an address
    //only the owner can send these coins
    function mint(address receiver , uint amount) public{
        require(msg.sender == minter);
        balances[receiver] += amount;
    }
    
    error insufficientBalance(uint requested, uint available);
    
    function send(address receiver, uint amount)public {
        if(amount > balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }
}
