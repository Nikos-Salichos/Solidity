pragma solidity >= 0.7.0 < 0.9.0;

//Interfaces are similar to abstract contract and are created using interface keyword

//Characteristics of an interface
// 1.Interface cannot have any function with implementation
// 2.Interface functions can be only external
// 3.Interface cannot have a constructor
// 4.Interface cannot have state variables
// 5.Interface can have enum, structs which can be accesses using interface name dot notation.

contract Counter {
    uint public count;

    function increment() external {
        count += 1;
    }
}

interface ICounter{
    function count() external view returns(uint);
    function increment() external;
}

contract MyContract {
    function incrementCounter(address counter) external {
        ICounter(counter).increment();
    }

    function getCount(address counter) external view returns(uint){
        return ICounter(counter).count();
    }
}

