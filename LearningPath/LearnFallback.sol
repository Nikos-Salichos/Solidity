pragma solidity >= 0.7.0 < 0.9.0;

/*Fallback functions
- Cannot have a name (anonymous)
- Never take inputs
- Never return any outputs
- Must be declared as external
Why use it?
When you call functions that does not exist or send ether to a contract by send , transfer or call
Statement: send and transfer method receives 2300 gas but call method receives all of the gas
*/

contract LearnFallBack{
    
    event Log(uint gas);
    
    fallback () external payable{
        //not recommended to write much code here , function will fail if it uses too much gas
    
        //invoke send method: we get 2300 gas which is enough to emit a log
        //invoke the call method: we get all the gas
        
        //special solidity function gasleft returns how much gas is left
        emit Log(gasleft());
    }
    
    
    function getBalance() public view returns(uint){
        //return the stored balance of the contract
        return address(this).balance;
    }
    
}


//new contract will send ether to fallback contract which will trigger fallback functions
contract SendToFallback{
    
    function transferToFallback(address payable to) public payable{
        //send ether with the transfer method
        //automatically transfer will transfer 2300 gas amount
        to.transfer(msg.value);
    }
    
    function callFallback(address payable to) public payable{
        (bool sent,) = to.call{value: msg.value}('');
        require(sent, 'Failed to send!');
    }
}
