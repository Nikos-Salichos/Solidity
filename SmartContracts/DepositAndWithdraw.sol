// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract DepositAndWithdraw{

    address payable private _owner;

    constructor ()  {
       _owner = payable(msg.sender) ;
   }

    mapping(address => uint) public balances;
 
    function deposit() external payable {
        balances[msg.sender] +=msg.value;
    }

      // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
    
    function withdraw(uint256 amount) public payable {
        require(balances[msg.sender] > 0, "Not enough funds");
        require(msg.sender == _owner);
        balances[msg.sender] -= amount;
        _owner.transfer(amount);
    }
    
}
