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
        
    event AddBook(address recipient, uint bookId);
    event SetFinished(uint bookId, bool finished);
}
