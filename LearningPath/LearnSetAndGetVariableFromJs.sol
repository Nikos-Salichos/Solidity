pragma solidity >= 0.7.0 < 0.9.0;

contract SetAndCallVarFromJs {
    
    string public name;
    
    
    function setName(string memory newName) public
    {
        name = newName;
    }
    
    function getName() public view returns (string memory)
    {
        return name;
    }

//Set variable and Call from Web3
//NameContract.methods.getName().call();
//NameContract.methods.setName("bitsofcode").send();

}
