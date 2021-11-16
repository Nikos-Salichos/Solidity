pragma solidity >= 0.7.0 < 0.9.0;

// Function modifiers are used to modify the behaviour of a function

contract Owner{
    
    address owner; //when we deploy the contract we want to send msg.sender to be the owner
    
    constructor() public {
        owner = msg.sender;
        
    }
    
    modifier onlyOwner{
    require(msg.sender == owner,"You are not the owner"); //custom logic to modify functions
    _; //underscore continues with the function, else it throws error
    }
    
    modifier costs(uint price){
        require(msg.value >= price, "Price should be same or higher than message value");
        _;
    }
}


//is keyword is for grabbing inheritance from another contract
contract Register is Owner{
    
    mapping(address => bool) registeredAddresses;
    uint price;
    
    constructor(uint initialPrice) public {
        price = initialPrice;
    }
    
    function register() public payable costs(price){ //running modifiers in function is cheaper than running logic inside function
        registeredAddresses[msg.sender] = true;
    }
    
    
    //onlyOwner is able to change the price
    function changePrice(uint _price) public onlyOwner{
        price = _price;
    }
    
}
