// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.0;

contract Calculator  {

   function AddValues(uint a, uint b) public pure returns (uint) {
       uint result = a+b;
       return result;
    }   
   
   function SubtractValues(uint a, uint b) public pure returns (uint) {
       uint result = a-b;
       return result;
    }  
  
    function MultiplyValues(uint a, uint b) public pure returns (uint) {
        uint result = a*b;
        return result;
    }
    
    function DivideValues(uint a, uint b) public pure returns (uint) {
        uint result = a/b;
        return result;
    }
    
}
