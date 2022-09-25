// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.17;


contract Ownable  {
  address public owner;
  event OwnershipRenounced(address indexed previousOwner);
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
  
  constructor() {
    owner = msg.sender;
  }
  
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
  
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
  
  function renounceOwnership() public onlyOwner {
    emit OwnershipRenounced(owner);
    owner = address(0);
  }
  
}


contract Authorizable is Ownable {

    mapping(address => bool) public authorized;

    event AuthorizableAddressAdded(address addr);
    event AuthorizableAddressRemoved(address addr);

    modifier onlyAuthorized() {
        require(authorized[msg.sender] || owner == msg.sender);
        _;
    }
    
    function addAuthorizedAddress(address addr) onlyOwner public returns(bool success) {
        if (!authorized[addr]) {
            authorized[addr] = true;
            emit AuthorizableAddressAdded(addr);
            success = true; 
        }
    }
}

contract CRUD {
  
  
}
