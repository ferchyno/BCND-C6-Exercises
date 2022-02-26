pragma solidity ^0.4.25;

contract ExerciseC6A {

    /********************************************************************************************/
    /*                                       DATA VARIABLES                                     */
    /********************************************************************************************/

    uint constant M = 2;
    struct UserProfile {
        bool isRegistered;
        bool isAdmin;
    }

    address private contractOwner;                  // Account used to deploy contract
    mapping(address => UserProfile) userProfiles;   // Mapping for storing user profiles

    bool private liveContract = true;

    address[] multiCalls = new address[](0);


    /********************************************************************************************/
    /*                                       EVENT DEFINITIONS                                  */
    /********************************************************************************************/

    // No events

    /**
    * @dev Constructor
    *      The deploying account becomes contractOwner
    */
    constructor () public
    {
        contractOwner = msg.sender;
    }

    /********************************************************************************************/
    /*                                       FUNCTION MODIFIERS                                 */
    /********************************************************************************************/

    // Modifiers help avoid duplication of code. They are typically used to validate something
    // before a function is allowed to be executed.

    /**
    * @dev Modifier that requires the "ContractOwner" account to be the function caller
    */
    modifier requireContractOwner()
    {
        require(msg.sender == contractOwner, "Caller is not contract owner");
        _;
    }

    modifier isLiveContract()
    {
        require(liveContract, "Contract isn't alive");
        _;
    }

    /********************************************************************************************/
    /*                                       UTILITY FUNCTIONS                                  */
    /********************************************************************************************/

   /**
    * @dev Check if a user is registered
    *
    * @return A bool that indicates if the user is registered
    */   
    function isUserRegistered
                            (
                                address account
                            )
                            external
                            view
                            returns(bool)
    {
        require(account != address(0), "'account' must be a valid address.");
        return userProfiles[account].isRegistered;
    }

    function isLive() public view
    returns(bool)
    {
        return liveContract;
    }

    /********************************************************************************************/
    /*                                     SMART CONTRACT FUNCTIONS                             */
    /********************************************************************************************/

    function registerUser ( address account, bool isAdmin) external
    requireContractOwner()
    isLiveContract()
    {
        require(!userProfiles[account].isRegistered, "User is already registered.");

        userProfiles[account] = UserProfile({
                                                isRegistered: true,
                                                isAdmin: isAdmin
                                            });
    }

    function setContractStatus (bool status) external
    // requireContractOwner() Is not necessary cause we have checking if caller is admin into de method
    {
        // Hay que anticiparse  lo mas rápido posible a todos los escenarios de error poniendo restricciones para evitar un consumo de gas excesivo
        require(status != liveContract, "New status must be different from existing status");
        require(userProfiles[msg.sender].isAdmin, "Caller is not an admin");

        // Avoid duplicate callers
        bool isDuplicate = false;
        // Evitar los blucles for, gastan mucho gas! Dependiendo de su tamaño cada vez que los recorras, tardará mas
        // Se ha usado en est practica pero hay que evitarlos lo máximo posible
        // Esto es un escenario potencial de bloqueo. Si alcanzas el límite de gas no vas a poder pausar el contrato
        // La solucion sería sacar el blucle fuera del contrato, que se haga desde node con n llamadas
        for(uint c=0; c<multiCalls.length; c++) {
            if (multiCalls[c] == msg.sender) {
                isDuplicate = true;
                break;
            }
        }
        require(!isDuplicate, "Caller has already called this function.");

        // Check the M of N consensus
        multiCalls.push(msg.sender);
        if (multiCalls.length >= M) {
            liveContract = status;
            // Reinicialize the callers counter
            multiCalls = new address[](0);
        }
    }
}

