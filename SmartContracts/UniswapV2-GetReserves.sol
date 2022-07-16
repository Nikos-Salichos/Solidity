// SPDX-License-Identifier: UNLICENSED
pragma solidity ^ 0.6.0;

interface UniswapV2Factory{
    //this function returns the pair address based on 2 token addresses
    function getPair(address tokenA, address TokenB) external view returns (address pair);
}

interface UniswapV2Pair{
    //this function returns how much DAI and WETH is locked in uniswap
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

contract UniswapExample {
    address private factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f ; 
   // address private dai = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984; example address
   // address private weth = 0xd0A1E359811322d97991E03f863a0C30C2cF029C; example address
    
    function getTokenReserves(address token0, address token1) external view returns (uint , uint){
        
        address pair = UniswapV2Factory(factory).getPair(token0, token1);
        
        (uint reserve0, uint reserve1,) = UniswapV2Pair(pair).getReserves();
        
        return (reserve0,reserve1);
    }
}
