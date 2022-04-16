//SPDX-License-Identifier: Unlicensed

pragma solidity >= 0.8.0;

contract Ticket{
    
    uint256 ticketPrice = 0.01 ether;
    address owner;
    mapping(address => uint256) public ticketHolders;

    constructor(){
        owner = msg.sender;
    }

    function buyTickets(address user, uint256 amount) payable public{
        require(msg.value >= ticketPrice * amount);
        addTickets(user,amount);
    }

    function useTickets(address user, uint256 amount) public{
        subTickets(user,amount);
    }

    function addTickets(address user, uint256 amount) internal{
        ticketHolders[user] = ticketHolders[user] + amount;
    }

    function subTickets(address user, uint256 amount) internal{
        require(ticketHolders[user] >= amount , "You do not have enough tickets");
        ticketHolders[user] = ticketHolders[user] - amount;
    }

    function withdraw()public{
        require(msg.sender == owner, "You are not the owner");
        (bool success,) = payable(owner).call{value: address(this).balance}("");
        require(success);
    }

}