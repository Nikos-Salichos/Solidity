pragma solidity ^ 0.6.0;

//define interface
interface UniswapV2Factory{
    //this function returns the pair address based on 2 token addresses
    function getPair(address tokenA, address TokenB) external view returns (address pair);
}

//define interface
interface UniswapV2Pair{
    //this function returns how much DAI and WETH is locked in uniswap
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

contract UniswapExample {
    address private factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f ; 
    address private dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    
    function getTokenReserves() external view returns (uint , uint){
        
        address pair = UniswapV2Factory(factory).getPair(dai, weth);
        
        (uint reserve0, uint reserve1,) = UniswapV2Pair(pair).getReserves();
        
        return (reserve0,reserve1);
    }
}

//Next Step Injected with Web3
//How to use interface directly to communicate with Uniswap without wasting ether to deploy contract

//Select UniswapV2Factory contract from CONTRACT Tab in DEPLOY & RUN TRANSACTIONS
//Copy factory address 
//Paste factory address in "At Address" field
//Click "At Address" button
//Open Contract and can get the pair by copying the 2 addresses in the field "getPair"
//Click "getPair" button
//result, address:pair 


//Select UniswapV2Pair contract from the CONTRACT Tab in DEPLOY and Transactions
//Paste adress of the pair , in the field "At Address"
//Click "At Address" button
//Open Contract and click "getReserves"


