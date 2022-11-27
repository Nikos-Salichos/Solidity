
contract CryptoCoinFactory{ 

   CryptoCoin[] public CryptoCoins;
   
   function createCryptoCoin(uint256 initialSupply, string memory tokenName, string memory tokenSymbol, uint256 tokenCap) public {
        CryptoCoin cryptoCoin = new CryptoCoin(initialSupply,tokenName,tokenSymbol,tokenCap);
        CryptoCoins.push(cryptoCoin);
    }
    
   function getAllCryptoCoins() public pure returns (CryptoCoin[] memory allCryptoCoins){
        return allCryptoCoins;
    }
}
