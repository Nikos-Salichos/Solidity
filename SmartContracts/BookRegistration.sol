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
    
    function addBook(string memory name, uint year, string memory author, bool finished) external{
        uint bookId = bookList.length;
        bookList.push(Book(bookId,name,year,author,finished));
        bookToOwner[bookId] = msg.sender;
        emit AddBook(msg.sender, bookId);
    }
}
