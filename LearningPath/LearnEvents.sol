pragma solidity >= 0.7.0 < 0.9.0;

contract LearnEvents {

    //indexes allow the consumer to filter through specific parameters
    //indexes are not mandatory in events, use index only in important parameters you need to filter
    //only 3 indexes allowed in an event
    //indexes use more gas

    //declare the event
    event NewTrade(uint indexed date, address from, address to, uint indexed amount);

    function trade(address to, address from,  uint amount) external{
        //outside consumer can see the event through web3js
        emit NewTrade(block.timestamp, from, to, amount); //call event with keyword emit eventName
    } 

}