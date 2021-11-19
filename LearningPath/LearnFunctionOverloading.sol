pragma solidity >= 0.7.0 < 0.9.0;

//Multiple definitions for the same definition.
//Each function definition should have different type/number of arguments
//Cannot use overload for function that change only by return type.

contract functionOverloading{
    
    function x(bool lightSwitch) public{
        
    }
    
    function x(uint wallet)public{
        
    }
    
   
    function exercise(uint a, uint b) public view returns(uint){
        return a+b;
    }
    
    function exercise(uint a, uint b, uint c) public view returns(uint){
        return a+b+c;
    }
    
}
