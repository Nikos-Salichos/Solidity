// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
 
contract TimelockCrypto {
    
    mapping(address => uint) public balances;
  
    mapping(address => uint) public lockTime;
   
    function deposit() external payable {
        balances[msg.sender] +=msg.value;
        lockTime[msg.sender] = block.timestamp + 1 minutes;
    }

    function increaseLockTime(uint _secondsToIncrease) public {
         lockTime[msg.sender] = lockTime[msg.sender]+_secondsToIncrease;
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "Not enough funds");
        require(block.timestamp > lockTime[msg.sender], "Your crypto are locked");
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send funds");
    }
}
