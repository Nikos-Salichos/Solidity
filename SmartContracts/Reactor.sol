// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
}


//https://jeancvllr.medium.com/solidity-tutorial-all-about-structs-b3e7ca398b1e
//https://solidity-by-example.org/structs/
//https://ethereum.stackexchange.com/questions/100008/solidity-loop-through-array-of-struct-only-looping-to-first-array-member
//https://medium.com/robhitchens/solidity-crud-part-1-824ffa69509a

//Wrapped token
//https://programtheblockchain.com/posts/2018/05/26/wrapping-ether-in-an-erc20-token/

contract Reactor {

    IERC20 public myToken;
    uint public meltDownAmount; //total balance, everyone can claim
    uint public balanceToClaim;
    uint private nonce = 0;
    struct Player{
        address playerAddress;
        uint playerAmount;
        bool playerExists;
    }

    address payable private immutable burnAddress = payable(0x000000000000000000000000000000000000dEaD);

    //Player public player;
    Player[] private playersArray; //Array of structs
    mapping(address => Player) private playersMap; //Mapping addresses to structs

    //constructor token address
    // constructor(address tokenAddress, address burnAddress) public {
    //     myToken = IERC20(tokenAddress); 
    //      burnAddress = _burnAddress; 
    // }

    function isUser() private view returns(bool isPlayer)  {
        for (uint i; i< playersArray.length;i++){
          if (playersArray[i].playerAddress == msg.sender)
          return true;
       }
    }

    function deposit() public payable {

        uint256 winPercentage = 100;
        uint256 winnerNumber = claimSpillage();
        bool addressExists = isUser();

        if (addressExists == true && winnerNumber <= winPercentage){ //player exists and we have 5% chance for spillage 
            balanceToClaim += msg.value/100; //1%
            meltDownAmount += (msg.value*99)/100; //99%
            playersMap[msg.sender].playerAmount += (msg.value*99)/100; //99%
        } else if(addressExists == true && winnerNumber > winPercentage){ //player exists and no spillage
            meltDownAmount += msg.value;
            playersMap[msg.sender].playerAmount += msg.value;
        } else if(addressExists == false && winnerNumber <= winPercentage){ //player DO NOT exists and we have spillage
            balanceToClaim += msg.value/100; //1%
            meltDownAmount += (msg.value*99)/100; //99%
            Player memory player;
            player.playerAddress = msg.sender;
            player.playerAmount += (msg.value*99)/100; //99%
            player.playerExists = true;
            playersArray.push(player);
        } else if(addressExists == false && winnerNumber > winPercentage){ //player DO NOT exists and no spillage
            meltDownAmount += msg.value;
            Player memory player;
            player.playerAddress = msg.sender;
            player.playerAmount += msg.value;
            player.playerExists = true;
            playersArray.push(player);
        }

        if(winnerNumber <= 1)  //1% chance for meltdown
        {
            meltDown();
        }
    }

    //get user details
    function getUserDetails() public view returns (uint playerAmount) { 
        for (uint i; i< playersArray.length;i++){
          if (playersArray[i].playerAddress == msg.sender)
          return playersArray[i].playerAmount;
       }
    }

    //function produce a random number between 1-100
    function claimSpillage() private returns (uint spillageNumber){
        nonce++;
        uint claimSpillageRandomNumber = uint(keccak256(abi.encodePacked(msg.sender,nonce))) % 100;
        return claimSpillageRandomNumber; //between 1-100
    }

    function getTotalBalance() private view returns(uint){
        return address(this).balance;
    }

    function sendPlayerAmount(uint amount) public payable {
        for(uint i = 0; i < playersArray.length ; i++){
            payable(playersArray[i].playerAddress).transfer(amount);
            playersArray[i].playerAmount -= amount;
        }
    }

    function withdrawAmount() public payable{
        address payable clicker = payable(msg.sender);
        clicker.transfer(balanceToClaim);
    }

    function sendAmountToWinner(uint amount) public payable{
        for(uint i = 0; i < playersArray.length ; i++){
            if(playersArray[i].playerAddress == msg.sender )
            {
            payable(playersArray[i].playerAddress).transfer(amount);
            }
        }
    }

    function sendBurnAmount(uint amount) public payable {
        burnAddress.transfer(amount); 
    }

    function meltDown() public payable{ 

        uint totalPlayersAmountToSend = (meltDownAmount / 100)*25; //calculation for player's balance 25%
        uint totalWinnerAmount = (meltDownAmount / 100)*65;  //calculation for winner's amount 65%
        uint totalBurnAmount = (meltDownAmount / 100)*10;  //calculation for burn 10%

        sendBurnAmount(totalBurnAmount);
        sendAmountToWinner(totalWinnerAmount);
        sendPlayerAmount(totalPlayersAmountToSend);
        meltDownAmount = 0;
    }
}
