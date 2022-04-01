# Solidity-Smart-Contracts

LearningPath folder contains my learning path in solidity while i was doing the following course:
https://www.udemy.com/course/the-complete-solidity-course-blockchain-zero-to-expert/

In SmartContracts folder you can find all smart contracts that i have develop on my own.

You can test all smart contracts functionality at: https://remix.ethereum.org/

**Calculator**
- A calculator with all classic calculator functions (not using SafeMath).

**Get Reserves in Solidity(Example Uniswap V2)**
- An example with interface of UniswapV2Factory , function getReserves from Uniswap for Weth and Dai.
 
**Shared Wallet**
- It is a wallet that you can deposit any ERC20 token and you can give authorization to other addresses to spend your ERC20 tokens.

**TimelockCrypto**
- Deposit crypto and lock them for a specific duration.

**Escrow**
- Deploy smart contract with both buyer and seller addresses. Buyer can use deposit function, to deposit an amount and then confirm delivery to receive the product.
Buyer cannot confirm delivery before he deposits an amount.

**Poll Contract**
- Create polls and register voters (age required). Each voter can vote only once in each poll. Get selected poll results. Object Oriented Programming (OOP) approach in code.

**Lottery Contract**
- Everyone can join lottery (minimum amount 0.01 ether). Oracle contract increase the difficulty of getRandomNumber function. You have the ability to see past winners based on lotteryId.

**Reactor**
- It is a game that everyone can deposit and there a chance to send a specific amount to totalBalanceToClaim. 
In addition each deposit has a chance to cause meltdown (10% amount burn, 25% send back to each player based on player's total amount, 65% send to player who caused meltdown). Finally each deposit has a chance to add amount to a public balance that the fastest player can withdraw!


