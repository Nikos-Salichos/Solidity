pragma solidity >= 0.7.0 < 0.9.0;

contract LearnStrings {
    
    string greetings = 'Hello you \'re!'; 
    
    //  backspace \ is the escape char for strings
    //  \n skips a line
    
    function printString() public view returns(string memory){
        return greetings;
    }
    
    function changeGreeting(string memory _change) public  {
        greetings = _change;
    }
    
    function getChar() public view returns(uint){
       // return greetings.length;   //Too expensive computationally to get length in solidity, so you cannot do it like other languages.
       // Need to convert string to bytes to get the length, we can return the length
        bytes memory stringToBytes = bytes(greetings);
        return stringToBytes.length;
     }
    
   string public favoriteColor = 'blue';
   
   function changeFavoriteColor(string memory color) public {
       favoriteColor = color;
   }

    function getCharsFavoriteColor() public view returns(uint){
        bytes memory stringToBytes = bytes(favoriteColor);
        return stringToBytes.length;
    }
    
    
}






