pragma solidity >= 0.7.0 < 0.9.0;

//Nested Mapping (maps within maps)
//Store movies that belong to a certain person, thing or address (it is very important)
// mapping(key => mapping (key2 => value2)) mapName;

contract LearnNestedMapping{
    
    struct Movie{
        string title;
        string direction;
    }
    
    mapping (uint => Movie) movie;
    mapping (address => mapping(uint => Movie)) public myMovie;
    
    function addMyMovie (uint id , string memory title, string memory director) public {
        myMovie[msg.sender][id] = Movie(title,director);
        //msg.sender is a global variable accessible throughout solidity which captures the address
        //that is calling the contract
    }
    
}
