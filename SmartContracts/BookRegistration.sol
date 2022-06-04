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
    
    function getBookList(bool finished) private view returns(Book[] memory){
        Book[] memory temporary = new Book[](bookList.length);

        uint count = 0;

        for (uint256 i = 0; i < bookList.length; i++) {
            if (bookToOwner[i] == msg.sender && bookList[i].finished == finished){
                temporary[count] = bookList[i];
                count++;
            }
        }

        Book[] memory result = new Book[](count);
        for (uint256 i = 0; i < count; i++) {
            result[i] = temporary[i];
        }

        return result;
    }
    
    
    function getFinishedBooks() external view returns(Book[] memory){
        return getBookList(true);
    }
    
    function getUnfinishedBooks() external view returns(Book[] memory){
        return getBookList(false);
    }
    
    
    function setFinished(uint bookId, bool finished)external{
        if(bookToOwner[bookId] == msg.sender){
            bookList[bookId].finished = finished;
            emit SetFinished(bookId, finished);
        }
    }
    
}
