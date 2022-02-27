pragma solidity ^0.4.25;

// It's important to avoid vulnerabilities due to numeric overflow bugs
// OpenZeppelin's SafeMath library, when used correctly, protects agains such bugs
// More info: https://www.nccgroup.trust/us/about-us/newsroom-and-events/blog/2018/november/smart-contract-insecurity-bad-arithmetic/

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";


contract ExerciseC6B {
    using SafeMath for uint256; // Allow SafeMath functions to be called for all uint256 types (similar to "prototype" in Javascript)

    address private contractOwner;
    uint256 private counter = 1;

    constructor () public
    {
        contractOwner = msg.sender;
    }

    modifier entrancyGuard()
    {
        counter = counter.add(1);
        uint guard = counter;
        _;
        require(guard == counter, "That is not allowed");
    }

    /********************************************************************************************/
    /*                                     SMART CONTRACT FUNCTIONS                             */
    /********************************************************************************************/

    function safeWithdraw(uint256 amount) external
    entrancyGuard()
    {
        // Not important to exercise
    }
    
}

