// SPDX-License-Identifier: UNLICENSED

pragma solidity ^ 0.8.0;

contract Oracle{
    address Owner;
    uint256 public Random;

    constructor() {
        Owner = msg.sender;
    }

    function feedRandomNumbers(uint256 random) external{
        require(msg.sender == Owner);
        Random = random;
    }
}
