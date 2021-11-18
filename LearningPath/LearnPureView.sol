pragma solidity >= 0.7.0 < 0.8.0;


//View functions ensure that they will not mofidy the state (return values)
//Pure functions ensure that they will not read or modify the state (return calculations)

contract MyContract {
    
    uint value;

    //view allow remix to show value in IDE
    function getValue() external view returns(uint){
        // eth call
        return value;
    }
    
    function getNewValue() external pure returns(uint){
        // eth call
        return 1+1;
    }

    function setValue(uint _value) external {
        // eth send transaction
        value = _value;
    }
    
    function multiply() external pure returns(uint){
        return 3*7;
    }
    
    function valuePlusThree() external view returns(uint){
        return value+3;
    }
    
}

