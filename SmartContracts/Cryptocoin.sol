// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.8.13;


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

    function addAuthorizedAddresses(address[] memory addrs) onlyOwner public returns(bool success) {
        for (uint256 i = 0; i < addrs.length; i++) {
            if (addAuthorizedAddress(addrs[i])) {
                success = true;
            }
        }
    }

    function removeAddressFromAuthorized(address addr) onlyOwner public returns(bool success) {
        if (authorized[addr]) {
            authorized[addr] = false;
            emit AuthorizableAddressRemoved(addr);
            success = true;
        }
    }

     function removeAddressesFromWhitelist(address[] memory addrs) onlyOwner public returns(bool success) {
         for (uint256 i = 0; i < addrs.length; i++) {
             if (removeAddressFromAuthorized(addrs[i])) {
             success = true;
                }
         }
     }

}


contract Pausable is Authorizable{
  event Pause();
  event Unpause();
  event NotPausable();

  bool public paused = false;
  bool public canPause = true;

  /**
   * @dev Modifier to make a function callable only when the contract is not paused.
   */
  modifier whenNotPaused() {
    require(!paused || msg.sender == owner);
    _;
  }

  /**
   * @dev Modifier to make a function callable only when the contract is paused.
   */
  modifier whenPaused() {
    require(paused);
    _;
  }

  /**
     * @dev called by the owner to pause, triggers stopped state
     **/
    function pause() onlyOwner whenNotPaused public {
        require(canPause == true);
        paused = true;
        emit Pause();
    }

  /**
   * @dev called by the owner to unpause, returns to normal state
   */
  function unpause() onlyOwner whenPaused public {
    require(paused == true);
    paused = false;
    emit Unpause();
  }
  
  /**
     * @dev Prevent the token from ever being paused again
     **/
    function notPausable() onlyOwner public{
        paused = false;
        canPause = false;
        emit NotPausable();
    }
}

contract CryptoCoin is Pausable{

    uint256 public immutable cap;
    string public name;
    string public symbol;
    uint256 public decimals = 18;
    uint256 public  totalSupply;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event IncreaseApproval(address indexed owner,address indexed spender,uint256 value);
    event DecreaseApproval(address indexed owner,address indexed spender,uint256 value);
    event Sent(address from, address to, uint amount);
    event Burn(address from,uint256 amount);
    event Locked(address indexed owner, uint256 indexed amount);

    mapping(address => uint256) public  balanceOf;
    mapping(address => mapping(address => uint256)) public allowed;
    mapping(address => uint256) locked;

    constructor(uint256 initialSupply, string memory tokenName, string memory tokenSymbol, uint256 tokenCap )   { 
        require(tokenCap > 0, "Token: cap is 0");
        cap = tokenCap*100** uint256(decimals);
        totalSupply =  initialSupply*10** uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        name = tokenName;
        symbol = tokenSymbol;
        owner = msg.sender;
    }

    modifier onlyTrader(){                   
        require(owner == msg.sender);    
        _;
    }

    function increaseLockedAmount(address _owner, uint256 _amount) onlyOwner public returns (uint256) {
        uint256 lockingAmount = locked[_owner]+_amount;
        require(getBalance(_owner) >= lockingAmount, "Locking amount must not exceed balance");
        locked[_owner] = lockingAmount;
        emit Locked(_owner, lockingAmount);
        return lockingAmount;
    }

    function decreaseLockedAmount(address _owner, uint256 _amount) onlyOwner public returns (uint256) {
        require(locked[_owner] > 0, "Cannot go negative. Already at 0 locked tokens.");
        if (_amount > locked[_owner]) {
            _amount = locked[_owner];
        }
        uint256 lockingAmount = locked[_owner]-_amount;
        locked[_owner] = lockingAmount;
        emit Locked(_owner, lockingAmount);
        return lockingAmount;
    }

    function getLockedAmount(address _owner) view public returns (uint256) {
        return locked[_owner];
    }

    function getUnlockedAmount(address _owner) view public returns (uint256) {
        return balanceOf[_owner]-locked[_owner];
    }

    function getBalance(address tokenOwner) public view returns (uint256) {
        return balanceOf[tokenOwner];
    }

    function mint(address receiver , uint amount)public onlyAuthorized whenNotPaused{
        require(totalSupply + amount <= cap, "Token: cap exceeded");
        balanceOf[receiver] += amount;
        totalSupply += amount;
    }

    function allowance(address owner, address spender)  public whenNotPaused view returns (uint) {
        return allowed[owner][spender];
    }

     function destroySmartContract(address payable _to) public onlyOwner {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }

    function approve(address spender, uint256 amount) public whenNotPaused  returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address receiver, uint256 amount) public whenNotPaused  returns (bool) {
        require(receiver != address(0),"Address is not valid");
        require(amount <= balanceOf[msg.sender] - locked[msg.sender] ,"Funds are not enough" );
        balanceOf[msg.sender] = balanceOf[msg.sender] -amount;
        balanceOf[receiver] = balanceOf[receiver] + amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function increaseApproval(address spender, uint256 addedAmount)public whenNotPaused  returns(bool success){
        allowed[msg.sender][spender] = addedAmount;
        emit IncreaseApproval(msg.sender, spender, addedAmount);
        return true;
    }

    function decreaseApproval(address spender, uint subtractedAmount) public whenNotPaused returns (bool) {
        uint256 oldAmount = allowed[msg.sender][spender];
        
        if (subtractedAmount > oldAmount) {
            allowed[msg.sender][spender] = 0;
        } 
        else 
        {
            allowed[msg.sender][spender] = oldAmount - subtractedAmount;
        }

        emit DecreaseApproval(msg.sender, spender, subtractedAmount);

        return true;
    }


    function transferFrom(address from, address to, uint256 value) public  whenNotPaused returns (bool success){
        require(to != address(0),"Address is not valid");
        require(value <= balanceOf[from] - locked[from],"Funds are not enough" );
        require(value <= allowed[from][msg.sender] - locked[from],"There is no approval" );
        balanceOf[from] -=value;
        balanceOf[to] +=value;
        allowed[from][msg.sender] -= value;
        return true;
    }

    function burn(uint256 amount) public onlyAuthorized whenNotPaused returns(bool success){
        require(balanceOf[msg.sender] >= amount);
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burn(msg.sender,amount);
        return true;
    }

    function burnFrom (address from, uint256 amount) public onlyAuthorized whenNotPaused returns (bool success){
        require(amount <= allowed[from][msg.sender]);
        balanceOf[from] -=amount;
        allowed[from][msg.sender]  -=amount;
        totalSupply -= amount;
        emit Burn(from, amount);
        return true;
    }
}

contract CryptoTokenSale{

   address admin;
   CryptoCoin public TokenContract;
   uint256 public TokenPrice;
   uint256 public TotalTokensSold;
   
   event Sell(address buyer, uint256 amount);
   
   constructor( CryptoCoin tokenContract, uint256 tokenPrice){
    admin = msg.sender;
    TokenContract = tokenContract;
    TokenPrice = tokenPrice;
    }
    
     function buyTokens(uint256 numberOfTokens)public payable{
      require(msg.value == numberOfTokens * TokenPrice , "msg.value must be equal number of tokens in wei");
      require(TokenContract.balanceOf(address(this)) >= numberOfTokens , "Cannot purchase more tokens than available");
      require(TokenContract.transfer(msg.sender,  numberOfTokens));
      
      TotalTokensSold += numberOfTokens;
      emit Sell(msg.sender, numberOfTokens);
    }
    
     function endSale() public {
        require(msg.sender == admin);
        selfdestruct(payable(admin));
    }
    
   
 }

