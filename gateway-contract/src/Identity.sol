// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract IdentityGateway {
    address public _contractOwner;

    struct Citizen {
        bool citizenStatus; // true if alive, false if dead
        string firstName;
        string birthCertificateNo;
        string middleName;
        string lastName;
        string citizenId;
        string gender;
        string dateofBirth;
        string healthInsuarance;
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
        string dateofDeath;
        address registerBY;
        string citizenID;
    }

    struct Institution {
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
    mapping(string => Citizen) public citizenMapping;
    mapping(string => DeathCertificate) public deathcertificateMapping;
    mapping(string => Institution) public institutionMapping;
    mapping(address => Users) public userMapping;
    mapping(address => Operator) public operatorMapping;
    mapping(string => address) private fingerprintToUser; // A mapping from a Fingerprint to its corresponding Address
    mapping(string => uint256) private citizenIndexMapping;
    mapping(address => Institution) public institutionAddressMapping;

    constructor() {
        _contractOwner = msg.sender;
    }

    //ADDING INSTITUTION
    function addInstitution(
        string memory _instutionName,
        address _orgAddress,
        string memory _orgType,
        string memory _abbreviation
    ) public onlyOwner {
        Institution memory newOrg = Institution({
            instutionName: _instutionName,
            abbreviation: _abbreviation,
            orgType: _orgType,
            orgAddress: _orgAddress
        });

        institutionArray.push(newOrg);
        institutionMapping[_abbreviation] = newOrg;
        institutionAddressMapping[_orgAddress] = newOrg;

        addTransaction("Added Institution", msg.sender);
    }

    function issueCitizenId(
        string memory _birthCertificateNo,
        string memory _citizenId
    ) public onlyNIDA {
        // Update in mapping
        citizenMapping[_birthCertificateNo].citizenId = _citizenId;

        // Efficient update in array using index mapping
        uint256 index = citizenIndexMapping[_birthCertificateNo];
        citizenArray[index].citizenId = _citizenId;

        addTransaction("Issued Citizen ID", msg.sender);
    }

    //ADDING OPERATORS TO OPERATOR ARRAY
    function addOperator(
        string memory _firstName,
        string memory _lastName,
        address _operatorAddress,
        string memory _position,
        string memory _organisation
    ) public onlyOwner{
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
        string memory _birthCertificateNo,
        string memory _lastName,
        string memory _gender,
        string memory _dateofBirth
    ) public  onlyRITA{
        Citizen memory newCitizen = Citizen({
            firstName: _firstName, //citizen name
            middleName: _middleName,
            birthCertificateNo: _birthCertificateNo,
            lastName: _lastName,
            gender: _gender,
            dateofBirth: _dateofBirth,
            citizenId: "",
            citizenStatus: true,
            healthInsuarance: ""
        });

        citizenMapping[_birthCertificateNo] = newCitizen;
        citizenArray.push(newCitizen);
        citizenIndexMapping[_birthCertificateNo] = citizenArray.length - 1; // Save index
        addTransaction("Added citizen", msg.sender);
    }

    function issueDeathCertificate(
        string memory _causeOfDeath,
        string memory _dateofDeath,
        address _registerBY,
        string memory _citizenID
    ) public onlyRITA {
        DeathCertificate memory newDeath = DeathCertificate({
            causeOfDeath: _causeOfDeath,
            dateofDeath: _dateofDeath,
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

    function issueBima(
        string memory _birthCertificateNo,
        string memory _healthInsuarance
    ) public onlyNHIF {
        // Update in mapping
        citizenMapping[_birthCertificateNo]
            .healthInsuarance = _healthInsuarance;

        // Efficient update in array using index mapping
        uint256 index = citizenIndexMapping[_birthCertificateNo];
        citizenArray[index].healthInsuarance = _healthInsuarance;

        addTransaction("Issued Bima", msg.sender);
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

    function checkHealthInsuranceStatusByNumber(
        string memory _healthInsuranceNumber
    )  public onlyNHIF view returns (bool)  {
        for (uint256 i = 0; i < citizenArray.length; i++) {
            if (
                keccak256(bytes(citizenArray[i].healthInsuarance)) ==
                keccak256(bytes(_healthInsuranceNumber))
            ) {
                if (citizenArray[i].citizenStatus) {
                    return true;
                } else {
                    return false;
                }
            }
        }
        revert("Health insurance number not found");
    }

    function revokeHealthInsurance(string memory _healthInsuranceNumber)
        public onlyNHIF
    {
        bool found = false;

        for (uint256 i = 0; i < citizenArray.length; i++) {
            if (
                keccak256(bytes(citizenArray[i].healthInsuarance)) ==
                keccak256(bytes(_healthInsuranceNumber))
            ) {
                // Clear health insurance
                citizenArray[i].healthInsuarance = "";

                // Also clear in mapping using birthCertificateNo
                string memory birthCert = citizenArray[i].birthCertificateNo;
                citizenMapping[birthCert].healthInsuarance = "";

                addTransaction("Revoked Health Insurance", msg.sender);
                found = true;
                break;
            }
        }

        require(found, "Health insurance number not found");
    }

    // Announce the death of a citizen (set their status to false)
    function announceDeath(string memory _citizenId) public onlyRITA {
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

    function getAllInstitution() public view returns (Institution[] memory) {
        return institutionArray;
    }

    //get institution name
    function getInstitutionNameByAddress(address _orgAddress)
        public
        view
        returns (string memory)
    {
        require(
            bytes(institutionAddressMapping[_orgAddress].instutionName).length >
                0,
            "Institution not found"
        );
        return institutionAddressMapping[_orgAddress].instutionName;
    }

    //get particular citizen data
    function getCitizenData(string memory _birthCertificateNo)
        public
        view
        returns (Citizen memory)
    {
        return citizenMapping[_birthCertificateNo];
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

    modifier onlyNIDA() {
        require(
            keccak256(bytes(operatorMapping[msg.sender].organisation)) ==
                keccak256("NIDA"),
            "Only NIDA operators can call this function"
        );
        _;
    }

    modifier onlyRITA() {
        require(
            keccak256(bytes(operatorMapping[msg.sender].organisation)) ==
                keccak256("RITA"),
            "Only RITA operators can call this function"
        );
        _;
    }

    modifier onlyNHIF() {
        require(
            keccak256(bytes(operatorMapping[msg.sender].organisation)) ==
                keccak256("NHIF"),
            "Only NHIF operators can call this function"
        );
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == _contractOwner, "Only contract owner");
        _;
    }
}
