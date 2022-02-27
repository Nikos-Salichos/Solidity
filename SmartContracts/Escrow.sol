// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

contract Escrow{

    enum State { 
        AWAITING_PAYMENT, 
        AWAITING_DELIVERY, 
        COMPLETE 
    }

    
    State public currentState;
    
    address public buyerAddress;
    address payable public sellerAddress;
    
    modifier onlyBuyer() {
        require(msg.sender == buyerAddress, "Only buyer can call this method");
        _;
    }
    
    constructor(address _buyer, address payable _seller)  {
        buyerAddress = _buyer;
        sellerAddress = _seller;
    }
    
    function deposit() onlyBuyer external payable {
        require(currentState == State.AWAITING_PAYMENT, "Already paid, you cannot pay twice");
        currentState = State.AWAITING_DELIVERY;
    }
    
    function confirmDelivery() onlyBuyer external {
         require(currentState == State.AWAITING_DELIVERY, "Cannot confirm delivery from buyer");
        sellerAddress.transfer(address(this).balance);
        currentState = State.COMPLETE;
    }
}
