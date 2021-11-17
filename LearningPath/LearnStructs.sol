pragma solidity >= 0.7.0 < 0.9.0;

//Struct are types that are used to represent a record.

contract learnStructs {
    
    struct Movie{
        uint movieId;
        string title;
        string director;
    }
    
    Movie movie;
    
    function setMovie() public {
      movie =  Movie(1 ,'Blade Runner' , 'Ridley Scott');
    }
    
    function printMovie() public view returns (uint){
        return movie.movieId;
    }
}

contract learnStructsExercise{
    
    struct Book{
        uint bookId;
        string title;
        string author;
    }
    
    Book book;
    
    function setBook() public {
        book = Book(1, 'Think Grow Rich', 'Napoleon Hill');
    }
    
    function printBookId() public view returns (uint){
        return book.bookId;
    }
    
}



