pragma solidity ^0.4.25;

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";


contract ExerciseC6B {
    using SafeMath for uint256; // Allow SafeMath functions to be called for all uint256 types (similar to "prototype" in Javascript)

    address private contractOwner;
    uint salesThreshold = 100;

    mapping (address => uint256) sellerSales;


    constructor () public
    {
        contractOwner = msg.sender;
    }

    /**
    * Chequear si el el caller es un usuario, NO un contrato
    * Si el sender es el mismo que que originó la transaccion (tx.origin), no puede ser un contrato
    */
    modifier isExternalAccount()
    {
        require(msg.sender == tx.origin, "Contracts not allowed");
    }

    /**
    * Chequear si el vendedor tiene suficientes ventas
    */
    modifier enoughFunds()
    {
        require(sellerSales[msg.sender] > salesThreshold, "Insufficient funds")
        _;
    }

    /********************************************************************************************/
    /*                                     SMART CONTRACT FUNCTIONS                             */
    /********************************************************************************************/

    function safeWithdraw(uint256) external
    // Checks
    enoughFunds()
    isExternalAccount()
    {
        // Efects
        uint256 amount = sellerSales[msg.sender];
        sellerSales[msg.sender].sub(amount);

        // Interaction (Transfers)
        msg.sender.transfer(amount);
    }
}

