// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract IdentityGateway {
    //State variables
    address public i_owner;

    struct Institution {
        address institutionAdress;
        string abbreviation;
        string institutionType;
        string institutionName;
    }

    struct Citizen {
        string firstName;
        string middleName;
        string lastName;
        address citizenId;
        string gender;
        string dateofBirth;
        string[] identities;
        bool citizenStatus;
    }

    //struct of institution operators
    struct Operators {
        string name;
        address operatorAddress;
        string organization;
        string position;
    }

    struct Identites {
        string idType;
        string documentCid;
    }

    struct Users {
        address userAddress;
        string userType;
    }
    //Arrays
    Identites[] public arrayofIdentities;
    Operators[] public operatorsArray;
    Institution[] institutionArray;
    Citizen[] citizenArray;

    //checking if the organization is available
    function isAvailable(address _institutionAdress)
        public
        view
        returns (bool)
    {
        bool results = false;
        for (uint256 i; i < institutionArray.length; i++) {
            if (institutionArray[i].institutionAdress == _institutionAdress) {
                results = true;
            }
        }
        return results;
    }

    //mappings
    mapping(address => Institution) public organizationAvailable;
    mapping(address => Operators) public operators;
    mapping(address => Citizen) public citizensMapping;
    mapping(string => Identites) public identityMapping;
    //map to store users and their type of user
    mapping(address => Users) public userMapping;

    constructor() {
        i_owner = msg.sender;
    }

    //ADDING OPERATORS TO OPERATOR ARRAY
    function addOperator(
        string memory _name,
        address _operatorAddress,
        string memory _organization,
        string memory _position
    ) public {
        // Operators memory newUser = Operators({

        operators[_operatorAddress].name = _name;
        operators[_operatorAddress].operatorAddress = _operatorAddress;
        operators[_operatorAddress].organization = _organization;
        operators[_operatorAddress].position = _position;

        operatorsArray.push(operators[_operatorAddress]);
    }

    //GETTING THE LIST OF OPERATORS

    function getAllOperators() public view returns (Operators[] memory) {
        return operatorsArray;
    }

    //ADDING ORGANIZATION
    function addOrganiztion(
        string memory _institutionName,
        address _institutionAddress,
        string memory _abbreviation,
        string memory _institutionType
    ) public {
        Institution memory newUser = Institution({
            institutionName: _institutionName,
            institutionAdress: _institutionAddress,
            institutionType: _institutionType,
            abbreviation: _abbreviation
        });
        institutionArray.push(newUser);
    }

    //Getting Institution
    function getAllInstitution() public view returns (Institution[] memory) {
        return institutionArray;
    }

    //adding citizens to citizens array
    function addCitizen(
        string memory _firstName,
        string memory _middleName,
        string memory _lastName,
        address _citizenId,
        string memory _gender,
        string memory _dateofBirth // string memory documentCID
    ) public {
        Citizen memory newUser = Citizen({
            firstName: _firstName,
            middleName: _middleName,
            lastName: _lastName,
            citizenId: _citizenId,
            gender: _gender,
            dateofBirth: _dateofBirth,
            citizenStatus: true,
            identities: new string[](0)
        });
        citizenArray.push(newUser);
        // addIdentity(_userAddress, documentCID);
    }

    // Find the index of the user in the usersArray
    function findUserIndex(address _citizenId) internal view returns (uint256) {
        for (uint256 i = 0; i < citizenArray.length; i++) {
            if (citizenArray[i].citizenId == _citizenId) {
                return i;
            }
        }
        revert("User not found");
    }

    // Announce the death of a citizen (set their status to false)
    function announceDeath(address _citizenId) public {
        uint256 index = findUserIndex(_citizenId);
        citizenArray[index].citizenStatus = false;
    }

    // Check if a citizen is alive (true) or dead (false)
    function isCitizenAlive(address _citizenId) public view returns (bool) {
        uint256 index = findUserIndex(_citizenId);
        return citizenArray[index].citizenStatus;
    }

    modifier onlyAuthorized() {
        require(isAvailable(msg.sender), "Not authorized institution");
        _;
    }

    address public loggedInUser;

    function Login(address userAddress) public view returns (string memory) {
        return userMapping[userAddress].userType;
    }

    function logout() external {
        loggedInUser = address(0);
    }
}
