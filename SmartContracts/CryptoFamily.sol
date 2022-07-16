// SPDX-License-Identifier: UNLICENSED
pragma solidity ^ 0.8.10;

contract CryptoFamily{

    address owner;

    event LogChildDepositToWallet(address addr, uint amount, uint totalSmBalance);

    constructor(){
        owner = msg.sender;
    }

   struct Child{
      address WalletAddress;
      string FirstName;
      string LastName;
      uint ReleaseTime;
      uint Amount;
      bool CanWithdraw;
   }

   Child[] public Children;

   modifier onlyOwner(){
      require(msg.sender == owner);
      _;
   }

    function addChild(address walletAddress, string  memory firstName, string  memory lastName, uint releaseTime, uint amount, bool withdraw) public onlyOwner {
        Child memory child;
        child.WalletAddress = walletAddress;
        child.FirstName = firstName;
        child.LastName = lastName;
        child.ReleaseTime = releaseTime;
        child.Amount = amount;
        child.CanWithdraw = withdraw;

        Children.push(child);
    }

    function deposit(address walletAddress) payable public{
    }

    function balanceOf() public view returns(uint){
        return address(this).balance;
    }

    function addMoneyToChildren(address walletAddress) private onlyOwner {
        for(uint i =0; i< Children.length; i++){
            if(Children[i].WalletAddress == walletAddress){
                Children[i].Amount += msg.value;
                emit LogChildDepositToWallet(walletAddress,msg.value,balanceOf());
            }
        }
    }

    function getChildrenWalletBalance(address walletAddress) view private returns(uint) {
        for(uint i =0; i< Children.length; i++){
            if(Children[i].WalletAddress == walletAddress){
               return i;
            }
        }
        return 9999999999999;
    }

    function ableToWithdraw(address walletAddress) public returns(bool){
        uint index = getChildrenWalletBalance(walletAddress);
        if(block.timestamp > Children[index].ReleaseTime){
            Children[index].CanWithdraw = true;
            return true;
        }else{
            return false;
        }
    }

    function withdrawToChildWallet(address payable walletAddress) payable public{
        uint index = getChildrenWalletBalance(walletAddress);
        require(msg.sender == Children[index].WalletAddress, "You cannot withdraw");
        require(Children[index].CanWithdraw == true, "You are not able to withdraw");
    }
    

}
