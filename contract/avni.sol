// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolarStake {
    address public owner;
    uint256 public panelCount = 0;

    struct Panel {
        address owner;
        uint256 energyGenerated;
        bool active;
    }

    mapping(uint256 => Panel) public panels;
    mapping(address => uint256[]) public ownership;

    constructor() {
        owner = msg.sender;
    }

    function registerPanel(address _owner) public returns (uint256) {
        require(msg.sender == owner, "Only contract owner can register panels");
        panelCount++;
        panels[panelCount] = Panel(_owner, 0, true);
        ownership[_owner].push(panelCount);
        return panelCount;
    }

    function updateEnergy(uint256 panelId, uint256 energyProduced) public {
        require(panels[panelId].active, "Panel not active");
        panels[panelId].energyGenerated += energyProduced;
    }

    function togglePanelStatus(uint256 panelId) public {
        require(msg.sender == owner, "Only contract owner can toggle status");
        panels[panelId].active = !panels[panelId].active;
    }

    function getUserPanels(address _user) public view returns (uint256[] memory) {
        return ownership[_user];
    }
}

