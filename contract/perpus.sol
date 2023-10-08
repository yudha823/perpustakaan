// File: Library.sol

pragma solidity ^0.8.0;

contract Library {
    struct Book {
        string title;
        uint256 year;
        string author;
        bool exists;
    }

    mapping(string => Book) public books; // Menggunakan string sebagai kunci
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function addBook(
        string memory isbn, // Menggunakan string untuk ISBN
        string memory title,
        uint256 year,
        string memory author
    ) public onlyAdmin {
        require(!books[isbn].exists, "Book with this ISBN already exists");

        books[isbn] = Book(title, year, author, true);
    }

    function updateBook(
        string memory isbn, // Menggunakan string untuk ISBN
        string memory title,
        uint256 year,
        string memory author
    ) public onlyAdmin {
        require(books[isbn].exists, "Book with this ISBN does not exist");

        books[isbn] = Book(title, year, author, true);
    }

    function removeBook(string memory isbn) public onlyAdmin {
        require(books[isbn].exists, "Book with this ISBN does not exist");

        delete books[isbn];
    }

    function getBookByISBN(string memory isbn)
        public
        view
        returns (
            string memory title,
            uint256 year,
            string memory author,
            bool exists
        )
    {
        Book memory book = books[isbn];
        require(book.exists, "Book with this ISBN does not exist");

        return (book.title, book.year, book.author, book.exists);
    }
}