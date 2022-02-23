pragma solidity ^0.8.0;

contract DepositAndWithdraw{

    address private _owner;

    constructor ()  {
       _owner = msg.sender;
   }

    mapping(address => uint) public balances;
 
    function deposit() external payable {
        balances[msg.sender] +=msg.value;
    }
    
    function withdraw() public {
        require(balances[msg.sender] > 0, "Not enough funds");
        require(msg.sender == _owner);
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send funds");
    }
    
}
