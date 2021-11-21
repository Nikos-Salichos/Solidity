pragma solidity >= 0.7.0. < 0.9.0. ;

contract EtherUnitsAndAssert{
    
    //function will fail if any assert fail
    function testAssert() public {
        
        //wei is the smallest denomination of EtherUnits
        assert (1000000000000000000 wei == 1 ether); //10^18 wei = 1eth
        assert(1 wei == 1);
        assert(1 ether == 1e18);
        assert(2 ether == 2e18);
        
        //Time assert
        assert(1 minutes == 60 seconds);
        assert(1 hours == 60 minutes);
        assert(1 days == 24 hours);
        assert(1 weeks == 7 days);
    }
}
