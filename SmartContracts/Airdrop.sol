// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract Airdrop {
    
    address owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    receive() external payable{}
    
    function airdropToken(address _tokenAddress, address[] memory _recipients, uint256 _amount) public {
        require(IERC20(_tokenAddress).allowance(msg.sender,address(this))>0, "contract is not allowed to spend that token");
        
        for (uint i=0;i<_recipients.length;i++){
           IERC20(_tokenAddress).transferFrom(msg.sender, _recipients[i], _amount);
        }
    }

}
