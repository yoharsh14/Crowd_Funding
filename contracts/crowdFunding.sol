// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract crowdFunding {
    event projectFunded(
        string indexed project_Name,
        address indexed funder,
        uint256 amountFunded
    );
    // 1. Projects
    // 2. Fund particular project
    // 3. Just fund
    struct Projects {
        address lead;
        string name;
        string about;
        uint256 projectId;
        uint256 raisedMoney;
    }
    struct Funders {
        string name;
        uint256 amount;
    }
    mapping(uint256 => Projects) idToProject;
    mapping(address => Funders) fundersDetail;
    address private immutable _owner;
    mapping(uint256 => string) private projectIdsWithName;
    uint256 currProjectId;

    constructor() {
        _owner = msg.sender;
        currProjectId = 0;
    }

    function getProjectsDetails(uint256 projectId) public view  returns (Projects memory) {
        return idToProject[projectId];
    }

    function fundProject(uint256 projectId) public payable {
        address payable projectLead = payable(idToProject[projectId].lead);
        (bool sent,) = projectLead.call{value: msg.value}("");
        idToProject[projectId].raisedMoney = uint256(msg.value);
        require(sent, "Failed to send Ether");
        emit projectFunded(idToProject[projectId].name, msg.sender, msg.value);
    }

    function fundPool() public payable {}

    function addProject(
        string memory name,
        string memory about,
        uint256 raisedMoney,
        address _lead
    ) public {
        require(
            msg.sender == _owner,
            "You are not the owner you cannot add your team"
        );
        Projects memory project = Projects(
            _lead,
            name,
            about,
            currProjectId,
            raisedMoney
        );
        idToProject[currProjectId] = project;
        projectIdsWithName[currProjectId] = name;
        currProjectId++;
    }

    function PoolFundProject(uint256 projectId, uint256 amount) public payable {
        require(
            msg.sender == _owner,
            "You are not the owner you cannot fund the team from pool funds"
        );
        address payable projectLead = payable(idToProject[projectId].lead);
        projectLead.transfer(amount);
        idToProject[projectId].raisedMoney = uint256(amount);
        emit projectFunded(idToProject[projectId].name, _owner, amount);
    }
}
