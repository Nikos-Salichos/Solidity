pragma solidity >= 0.7.0 < 0.9.0;

contract learnFunctions  {
   
   function AddValues(uint a, uint b) public view returns (uint) {
       uint result = a + b;
       return result;
    }   
   
   function SubtractValues(uint a, uint b) public view returns (uint) {
       uint result = a - b;
       return result;
    }  
  
    function MultiplyValues(uint a, uint b) public view returns (uint) {
        uint result = a * b;
        return result;
    }
    
    function DivideValues(uint a, uint b) public view returns (uint) {
        uint result = a /b; //do not return fraction, only part before comma
        return result;
    }
    
}
