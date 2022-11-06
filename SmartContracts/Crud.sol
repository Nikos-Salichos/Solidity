//SPDX-License-Identifier: MIT
pragma solidity >=0.8.7;

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


contract Crud is Ownable{
    uint256 public activeProductCounter = 0;
    uint256 public inactiveProductCounter = 0;
    uint256 private productCounter = 0;

    mapping(uint256 => address) public delProductOf;
    mapping(uint256 => address) public productOwnerOf;
    mapping(address => uint256) public productsOf;

    enum Deactivated { NO, YES }

    struct ProductStruct {
        uint256 productId;
        string title;
        string description;
        address productOwner;
        Deactivated deleted;
        uint256 created;
        uint256 updated;
    }

    ProductStruct[] activeProducts;
    ProductStruct[] inactiveProducts;

    event Action (
        uint256 productId,
        string actionType,
        Deactivated deleted,
        address indexed executor,
        uint256 created
    );

    constructor() {
        owner = msg.sender;
    }
    
        function createProduct(
        string memory title,
        string memory description
    ) external returns (bool) {
        require(bytes(title).length > 0, "Title cannot be empty");
        require(bytes(description).length > 0, "Description cannot be empty");

        productCounter++;
        productOwnerOf[productCounter] = msg.sender;
        productsOf[msg.sender]++;
        activeProductCounter++;

        activeProducts.push(
            ProductStruct(
                productCounter,
                title,
                description,
                msg.sender,
                Deactivated.NO,
                block.timestamp,
                block.timestamp
            )
        );

        emit Action (
            productCounter,
            "PRODUCT CREATED",
            Deactivated.NO,
            msg.sender,
            block.timestamp
        );

        return true;
    }
    
     function updateProduct(
        uint256 productId,
        string memory title,
        string memory description
    ) external returns (bool) {
        require(productOwnerOf[productId] == msg.sender, "UnproductOwnerized entity");
        require(bytes(title).length > 0, "Title cannot be empty");
        require(bytes(description).length > 0, "Description cannot be empty");

        for(uint i = 0; i < activeProducts.length; i++) {
            if(activeProducts[i].productId == productId) {
                activeProducts[i].title = title;
                activeProducts[i].description = description;
                activeProducts[i].updated = block.timestamp;
            }
        }

        emit Action (
            productId,
            "POST UPDATED",
            Deactivated.NO,
            msg.sender,
            block.timestamp
        );

        return true;
    }
    
    
    
    
 }
