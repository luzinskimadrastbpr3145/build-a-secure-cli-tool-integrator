pragma solidity ^0.8.0;

contract SecureCLIToolIntegrator {
    // Mapping of CLI tools to their corresponding integrations
    mapping (string => Integration) public cliTools;

    // Event emitted when a new CLI tool is integrated
    event NewIntegration(string toolName, address integrationAddress);

    // Event emitted when a CLI tool is removed
    event RemoveIntegration(string toolName);

    // Struct to represent a CLI tool integration
    struct Integration {
        address integrationAddress;
        bytes data;
    }

    // Only allow the owner to add/remove integrations
    address private owner;

    // Modifier to restrict access to the owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Constructor to set the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to add a new CLI tool integration
    function addIntegration(string memory _toolName, address _integrationAddress, bytes memory _data) public onlyOwner {
        cliTools[_toolName] = Integration(_integrationAddress, _data);
        emit NewIntegration(_toolName, _integrationAddress);
    }

    // Function to remove a CLI tool integration
    function removeIntegration(string memory _toolName) public onlyOwner {
        delete cliTools[_toolName];
        emit RemoveIntegration(_toolName);
    }

    // Function to get the integration details for a CLI tool
    function getIntegration(string memory _toolName) public view returns (address, bytes memory) {
        return (cliTools[_toolName].integrationAddress, cliTools[_toolName].data);
    }
}