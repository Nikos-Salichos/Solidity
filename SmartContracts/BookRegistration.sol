contract BookRegistration {

    struct Book{
        uint id;
        string name;
        uint year;
        string author;
        bool finished;
    }

    Book[] private bookList;
    
    mapping(uint256 => address) bookToOwner;
        
}
