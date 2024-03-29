// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

contract Ownable  {
  address public owner;


  event OwnershipRenounced(address indexed previousOwner);
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipRenounced(owner);
    owner = address(0);
  }
}

contract CrowdFunding is Ownable{

    string public name;
    string public url;
    string public imageURL;
    string public description; 
    address payable public beneficiary;
    address private custodian;
    struct Donation {
        uint256 value;
        uint256 date; 
    }
    mapping (address => Donation[]) private _donations;
    uint256 public totalDonations;
    uint256 public donationsCount;

    event DonationReceived (address indexed donator, uint256 value);
    event Withdraw(uint256 amount);

    constructor (string memory _name, string memory _url, string memory _imageURL, string memory _description, address payable _beneficiary, address _custodian)  {
        name = _name;
        url = _url;
        imageURL = _imageURL;
        description = _description;
        beneficiary = _beneficiary;
        transferOwnership(_custodian);
    }
    
     function setBeneficiary (address payable _beneficiary) public onlyOwner {
        beneficiary = _beneficiary;
    }
    
     function myDonationsCount () public view returns (uint256) {
        return _donations[msg.sender].length;
    }
    
    function donate () public payable {
        Donation memory donation = Donation({
            value: msg.value,
            date: block.timestamp
        });
        _donations[msg.sender].push(donation);
        totalDonations = totalDonations + msg.value;
        donationsCount++;
        emit DonationReceived (msg.sender, msg.value);
     }
     
    function myDonations () public view returns (uint256[] memory values, uint256[] memory dates) {
        uint256 count = myDonationsCount();
        values = new uint256[](count);
        dates = new uint256[](count);
        for (uint256 i = 0; i < count; i++) {
            Donation storage donation = _donations[msg.sender][i];
            values[i] = donation.value;
            dates[i] = donation.date;
        }
        return (values, dates);
    }
    
    function withdraw () public onlyOwner {
        uint256 balance = address(this).balance;
        beneficiary.transfer(balance);
        emit Withdraw(balance);
    }
    
     fallback () external payable {
        totalDonations = totalDonations + msg.value;
        donationsCount++;
    }
    
     receive() external payable {
    }
    
}
