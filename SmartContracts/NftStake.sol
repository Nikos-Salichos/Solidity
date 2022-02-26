// SPDX-LICENSE-IDENTIFIER: UNLICENSED
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Receiver.sol";

contract NftStaker{

    IERC1155 public parentNFT;

    struct Stake{
        uint256 tokenId;
        uint256 amount;
        uint256 timestamp;
    }

    // map staker address to stake
    mapping(address => stake) public stakes;

    // mapstaker address to total staking time;
    mapping(address => uint256) public stakingTime;

    constructor(){
        parentNFT = IERC1155(0xd9145CCE52D386f254917e481eB44e9943F39138); // Change it to your NFT contract address
    }


    function stake(uint256 tokenId, uint256 amount) public{
        stakes[msg.sender]= Stake[tokenId, amount, block.timestamp];
        
    }



}