//SPDX-License-Identifier: Unlicensed
pragma solidity >=0.8.10;

contract CarRental{
    address owner;
    uint public rentalCostPerDay;
    
    constructor(uint amount){
        owner = msg.sender;
        rentalCostPerDay = amount; //in Wei
    }

   modifier onlyOwner(){
      require(msg.sender == owner);
      _;
   }

   struct Renter{
       address payable walletAddress;
       string firstName;
       string lastName;
       bool canRent;
       bool active;
       uint balance;
       uint due;
       uint start;
       uint end;
   }

   mapping(address => Renter) public renters;

   function changeRentalCostPerDay(uint value) public onlyOwner {
       rentalCostPerDay = value;
   }

    function addRenter( address payable walletAddress,string memory firstName,string memory lastName,
                        bool canRent,bool active,uint balance,uint due,uint start,uint end)public {
        renters[walletAddress] = Renter(walletAddress,firstName,lastName,canRent,active,balance,due,start,end);
    }

    function rentCar(address walletAddress) public {
        require(renters[walletAddress].due == 0, "You have a pending balance");
        require(renters[walletAddress].canRent == true, "You cannot rent a car");
        renters[walletAddress].active = true;
        renters[walletAddress].start = block.timestamp;
        renters[walletAddress].canRent = false;
    }

    function returnCar(address walletAddress)public{
        require(renters[walletAddress].active == true, "You have not rent the car yet");
        renters[walletAddress].active = false;
        renters[walletAddress].end = block.timestamp;
        setDue(walletAddress);
    }

    function renterTimespan(uint start, uint end)internal pure returns(uint){
        return end-start;
    }

    function getTotalRentalDuration(address walletAddress) public view returns(uint){
        require(renters[walletAddress].active == false,"You have not return the car yet");
        uint timespan = renterTimespan(renters[walletAddress].start, renters[walletAddress].end);
        uint timeSpanInMinutes = timespan/60;
        return timeSpanInMinutes;
    }

    function balanceOf() view public returns(uint){
        return address(this).balance;
    }

    function balanceOfRenter(address walletAddress) public view returns(uint){
        return renters[walletAddress].balance;
    }

    function setDue(address walletAddress) internal {
        uint timespanInMinutes = getTotalRentalDuration(walletAddress);
        uint oneDayIncrement = timespanInMinutes / 1440;
        renters[walletAddress].due = oneDayIncrement * rentalCostPerDay ;
    }

    function canRentCar(address walletAddress)public view returns(bool){
        return renters[walletAddress].canRent;
    }

    function deposit(address walletAddress) payable public{
        renters[walletAddress].balance += msg.value; 
    }

    function makePayment(address walletAddress) payable public{
        require(renters[walletAddress].due > 0,"You do not owe anything");
        require(renters[walletAddress].balance > msg.value,"You have enough funds to complete the payment, please make a deposit");
        renters[walletAddress].balance -= msg.value;
        renters[walletAddress].canRent = true;
        renters[walletAddress].due = 0;
        renters[walletAddress].start = 0;
        renters[walletAddress].end = 0;
    }

}
