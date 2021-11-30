pragma solidity >= 0.7.0 < 0.9.0;

/*
Libraries are similar to contract but are mainly intended for reuse.
Library contains functions that a contract can call.

Library functions can be called directly if they do not modify the state.
It means pure or view functions only can be called outside the library.
A library cannot be destroyed.
A library cannot have state variables.
A library cannot inherit any element.
A library cannot be inherited.
*/

library Search{
    function indexOf(uint[] storage self, uint value) public view returns(uint){
        for(uint i=0; i< self.length; i++){
            if(self[i] == value) return i;
        }
    }
}

contract LearnLibrary{

    //using A for B; //A is library , B another element

    uint[] data;
    constructor() public {
        data.push(1);
        data.push(2);
        data.push(3);
        data.push(4);
        data.push(5);
    }

    function isValuePresent(uint val) external view returns(uint){
        uint value = val;
        uint index = Search.indexOf(data,value); //1st way to call library function. LibraryName.FunctionName
        return index; //where value exists in array , start from 0
    }
}

contract LearnLibraryExercise{

    using Search for uint[]; //2nd way to call library function. Use Search1 is library for another element like uint
    uint[] data;
    constructor() public {
        data.push(1);
        data.push(2);
        data.push(3);
        data.push(4);
        data.push(5);
    }

    function isValuePresent(uint val) external view returns(uint){
        uint value = val;
        uint index = data.indexOf(value); //LibraryName.FunctionName
        return index; //where value exists in array , start from 0
    }
}
