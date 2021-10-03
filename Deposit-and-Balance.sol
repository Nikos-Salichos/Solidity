// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

contract SendEtherToSmartContract {
    
    function invest() external payable{
    }
    
    function balanceOf() external view returns(uint){
        return address(this).balance;
    }
    
}


//Deploy with VALUE = 0 and then send value when you have already deploy smart contract
//Change amount in "VALUE" tab and click invest to send ETHER
