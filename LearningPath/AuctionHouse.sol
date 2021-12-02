pragma solidity >= 0.7.0 < 0.9.0;

contract Auction{

    address payable private beneficiary;
    uint public auctionEndTime;

    address private highestBidder;
    uint public highestBid;

    bool public ended = false;

    mapping (address => uint) bids;

    constructor(uint _biddingTime, address payable _beneficiary) payable{
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }
    
    event highestBidIncrease(address bidder, uint amount);
    event auctionEnding(address winner, uint amount);

    function bid() public payable {

        require(block.timestamp < auctionEndTime , "Auction has finish" );

        if(msg.value <= highestBid ){
            revert("Bid is lowest than the current highest bid");
        }

        if(highestBid != 0){
            bids[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
        emit highestBidIncrease(highestBidder, highestBid);
    }

    function withdraw() public payable returns(bool){

        uint amount = bids[msg.sender];

        if(amount > 0){ //Make bidder amount equal to 0
            bids[msg.sender] = 0;
        }

        if(!payable(msg.sender).send(amount)){ 
            bids[msg.sender] = amount;
        }

        return true;
    }

    function auctionEnd() public{

        if(block.timestamp < auctionEndTime) 
        {
        revert("The auction has not ended yet!");
        }

        if(ended) 
        {
        revert("Auction has ended");
        }

        ended = true;
        emit auctionEnding(highestBidder,highestBid);
        beneficiary.transfer(highestBid); 
    }

}
