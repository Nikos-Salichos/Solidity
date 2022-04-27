// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.0;

import "./CryptoCoin.sol";

contract CryptoTokenSale{

    address admin;
    CryptoCoin public TokenContract;
    uint256 public TokenPrice;
    uint256 public TotalTokensSold;

    event Sell(address buyer, uint256 amount);

    constructor( CryptoCoin tokenContract, uint256 tokenPrice){
        admin = msg.sender;
        TokenContract = tokenContract;
        TokenPrice = tokenPrice;
    }

    //In order to work you need to transfer tokens from CryptoCoin to this smart contract's address.
    function buyTokens(uint256 numberOfTokens)public payable{
        require(msg.value == numberOfTokens * TokenPrice , "msg.value must be equal number of tokens in wei");
        require(TokenContract.balanceOf(address(this)) >= numberOfTokens , "Cannot purchase more tokens than available");
        require(TokenContract.transfer(msg.sender,  numberOfTokens));

        TotalTokensSold += numberOfTokens;
        emit Sell(msg.sender, numberOfTokens);
    }

    function endSale() public {
        require(msg.sender == admin);
        selfdestruct(payable(admin));
    }

}
