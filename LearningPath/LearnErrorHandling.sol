pragma solidity >= 0.7.0 < 0.9.0;

/*
Solidity has functions that help with error handling

assert(bool condition) - In case condition is not met, this method  call causes an invalid opcode 
and any changes done to state got reverted. This method is to be used for internal errors.

require(bool condition, string memory message) - In case condition is not met this method call revertes to original state.
This method is to be used for errors in inputs or external components. It provides options for custom message.

revert(string memory reason) - This method aborts the execution and revert and changes to the state.
It provides an option for custom message
*/

contract LearnErrorHandling{

    bool private sunny = true;
    bool private umbrella = false;
    uint private finalCalc = 0;

    //require example
    function solarCalc() public {
        require(sunny, "It is not sunny today!");
        finalCalc += 3;
        assert(finalCalc != 6);
    }

    function weatherChanger() public{
        sunny = !sunny;
    }

    function getCalc() public view returns(uint){
        return finalCalc;
    }

    function internalTestUnits() public{
        assert(finalCalc != 6);
    }

    //revert example
    function bringUmbrella() public {
        if(!sunny){
            umbrella = true;
        } else{
            revert('No need to bring an umbrella today!');
        }
    }

    

}

contract Vendor{

    address seller;

    modifier onlySeller(){                                                  
        require(seller == msg.sender , "Only seller can sell this");       
        _;
    }

    function becomeSeller() public {
        seller = msg.sender;
    }

    function sell(uint amount) payable public onlySeller{
        if(amount > msg.value)
        {
          revert( "You need to pay more"); 
        } 

    }

}
