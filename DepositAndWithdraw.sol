pragma solidity ^0.8.0;

contract DepositAndWithdraw{

    mapping(address => uint) public balances;
 
    function deposit() external payable {
        balances[msg.sender] +=msg.value;
    }
    
    function withdraw() public {
        require(balances[msg.sender] > 0, "Not enough funds");
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send funds");
    }
    
}
