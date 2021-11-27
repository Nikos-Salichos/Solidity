pragma solidity >= 0.7.0 < 0.9.0;

// onlyBy - only the mentioned caller can call this function
// onlyAfter - called after certain time period
// costs - call this function only if certain value is provided

contract RestrictedAccess{

    address public owner = msg.sender;
    uint public creationTime = block.timestamp;

    modifier onlyBy(address _account){
        require(msg.sender == _account,"Sender not authgorized");
        _;
    }

    modifier onlyAfter(uint time){
        require(block.timestamp >= time,"Function called too early");
        _;
    }

    modifier costs(uint amount){
        require (msg.value >= amount,"Not enough Ether provided");
        _;
    }

    function changeOwnerAddress(address newAddress) public{
        owner = newAddress;
    }

    //change owner if you pay bigger amount
    function forceOwnerChange(address newOwner) public payable costs(1 ether){
        owner = newOwner;
    }

    //write function that disown the current owner
    function disownCurrentOwner() public{
        delete owner;
    }

    //write function that disown the current owner after specific time
    function disownCurrentOwnerOnlyAfter() onlyBy(owner) onlyAfter(creationTime + 1 days) public{
        delete owner;
    }

}
