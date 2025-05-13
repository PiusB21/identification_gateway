// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract IdentityGateway {
    address public _contractOwner;

    struct Citizen {
        
        bool citizenStatus; // true if alive, false if dead
        string firstName;
        string middleName;
        string lastName;
        string citizenId;
        string gender;
        string dateofBirth;
    }

    struct Identity {
        string idType;
        string documentCid;
    }

    struct Operator {
        address operatorAddress;
        string firstName;
        string lastName;
        string position;
        string organisation;
    }

    struct Users {
        address userAddress;
        string userType;
    }

    struct Transaction {
        string action;
        address performedBy;
        uint256 timestamp;
        bool status;
    }

    struct DeathCertificate {
        string causeOfDeath;
        string dOB;
        address registerBY;
        string citizenID;
    }

    struct Institution{
        string instutionName;
        string abbreviation;
        string orgType;
        address orgAddress;
    }

    DeathCertificate[] public deathCertificateArray;
    Citizen[] public citizenArray;
    Institution[] public institutionArray;
    Operator[] public operatorArray;
    Identity[] public identityArray;
    Users[] public userArray;
    Transaction[] public transactionsArray;

    //mappings to store users and their type of user
    mapping(address => Citizen) public citizenMapping;
    mapping(string => DeathCertificate) public deathcertificateMapping;
    mapping (string => Institution) public  institutionMapping;
    mapping(address => Users) public userMapping;
    mapping(address => Operator) public operatorMapping;
    mapping(string => address) private fingerprintToUser; // A mapping from a Fingerprint to its corresponding Address

    constructor() {
        _contractOwner = msg.sender;
    }

    //ADDING INSTITUTION
    function addInstitution (
        string memory _instutionName,
        address _orgAddress,
        string memory _orgType, 
        string memory _abbreviation) public {
        Institution memory newOrg = Institution({
            instutionName:_instutionName,
            abbreviation: _abbreviation,
            orgType: _orgType,
            orgAddress: _orgAddress
        });

        institutionArray.push(newOrg);
        institutionMapping[_abbreviation]=newOrg;
        addTransaction("Added Institution", msg.sender);

    }


    //ADDING OPERATORS TO OPERATOR ARRAY
    function addOperator(
        string memory _firstName,
        string memory _lastName,
        address _operatorAddress,
        string memory _position,
        string memory _organisation
    ) public {
        Operator memory newOperator = Operator({
            firstName: _firstName,
            lastName: _lastName,
            operatorAddress: _operatorAddress,
            position: _position,
            organisation: _organisation
        });

        Users memory newUser = Users({
            userAddress: _operatorAddress,
            userType: "operator"
        });
        userMapping[_operatorAddress].userType = "operator";
        userArray.push(newUser);
        operatorMapping[_operatorAddress] = newOperator;
        operatorArray.push(newOperator);
        addTransaction("Added Operator", msg.sender);
    }

    function addCitizen(
        string memory _firstName,
        string memory _middleName,
        string memory _lastName,
        address _citizenAddress,
        string memory _gender,
        string memory _dateofBirth,
        string memory _citizenId
    ) public {
        Citizen memory newCitizen = Citizen({
            firstName: _firstName, //citizen name
            middleName: _middleName,
            lastName: _lastName,
            gender: _gender,
            dateofBirth: _dateofBirth,
            citizenId: _citizenId,
            citizenStatus: true
        });

        citizenMapping[_citizenAddress] = newCitizen;
        citizenArray.push(newCitizen);
        addTransaction("Added citizen", msg.sender);
    }

    function issueDeathCertificate(
        string memory _causeOfDeath,
        string memory _dOB,
        address _registerBY,
        string memory _citizenID
    ) public {
        DeathCertificate memory newDeath = DeathCertificate({
            causeOfDeath: _causeOfDeath,
            dOB: _dOB,
            registerBY: _registerBY,
            citizenID: _citizenID
        });

        deathCertificateArray.push(newDeath);
        deathcertificateMapping[_citizenID] = newDeath;
        announceDeath(_citizenID);
        addTransaction("Issued DeathCertificate", msg.sender);
    }

    // Function to add a new transaction
    function addTransaction(string memory _action, address _userAddress)
        internal
    {
        Transaction memory newTransaction = Transaction({
            action: _action,
            performedBy: _userAddress,
            timestamp: block.timestamp,
            status: true
        });
        transactionsArray.push(newTransaction);
    }

    // Find the index of the user in the usersArray
    function findUserIndex(string memory _citizenId)
        internal
        view
        returns (uint256)
    {
        for (uint256 i = 0; i < citizenArray.length; i++) {
            if (
                keccak256(bytes(citizenArray[i].citizenId)) ==
                keccak256(bytes(_citizenId))
            ) {
                return i;
            }
        }
        revert("User not found");
    }

    // Announce the death of a citizen (set their status to false)
    function announceDeath(string memory _citizenId) public {
        uint256 index = findUserIndex(_citizenId);
        citizenArray[index].citizenStatus = false;
    }

    // Check if a citizen is alive (true) or dead (false)
    function isCitizenAlive(string memory _citizenId)
        public
        view
        returns (bool)
    {
        uint256 index = findUserIndex(_citizenId);
        return citizenArray[index].citizenStatus;
    }

    function getAllInstitution() public  view returns (Institution[] memory){
        return institutionArray;
    }

    function getAllOperators() public view returns (Operator[] memory) {
        return operatorArray;
    }

    function getAllCitizens() public view returns (Citizen[] memory) {
        return citizenArray;
    }

    function getAllTransactions() public view returns (Transaction[] memory) {
        return transactionsArray;
    }

    function Login(address _userAddress) public view returns (string memory) {
        return operatorMapping[_userAddress].organisation;
    }
}
