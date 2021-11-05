pragma solidity >= 0.7.0 < 0.9.0;

contract Array{
    
    uint[]  myArray;
    
    //Push adds one or more elements to the end and returns the new length of the myArray1
    function pushMethod(uint number) public {
        myArray.push(number);
    }
    
    //Pop removes the last element from an array and returns the value to the caller.
    function popMethod() public {
        myArray.pop();
    }
    
    //length is a string property that is used to determine the length of a string
    function lengthMethod() public view returns (uint){
       return myArray.length;
    }
    
    //delete keyword do not change the length of the array, only the delete the value, index from 0 
    function removeMethod(uint i)public{
        delete myArray[i]; 
    }
}
