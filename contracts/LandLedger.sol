// SPDX-License-Identifier: MIT
pragma solidity ^0.4.25;

contract LandLedger {
    
    address contarctOwner;
    
    
    constructor() public {
        contarctOwner = msg.sender;
    }
    
    
    // * USER SECTION
    struct UserDetail{
        bytes32 fullName;
        bytes32 fathersName;
        bytes32 district;
        bytes32 thana;
        uint24 postCode;
        bytes32 village;
        bool exists;
    }
    
    struct UserOwned{
        uint number;
        bytes32[] khatianList;
    }
    
    
    mapping (uint => UserOwned)  userOwned;
    
    mapping (uint => UserDetail)  users;
    uint[]   userArray;
    
    event UserCreation(uint nid);

        
    function addUserOwned(uint _uid, bytes32 _khatianHash) public{
        userOwned[_uid].number ++;
        userOwned[_uid].khatianList.push(_khatianHash);
    }
    
    function createUser(string _fullName, string _fatheName, string _district, string _thana, uint24 _postCode, string _village, uint _nid) public{
        require(msg.sender == contarctOwner, "You are not authorized");
        _fullName = toUpper(_fullName);
        _fatheName = toUpper(_fatheName);
        _district = toUpper(_district);
        _thana = toUpper(_thana);
        _village = toUpper(_village);
        require(users[_nid].exists == false, "User already exist");
        
        users[_nid].fullName = stringToBytes32(_fullName);
        users[_nid].fathersName = stringToBytes32(_fatheName);
        users[_nid].district = stringToBytes32(_district);
        users[_nid].thana = stringToBytes32(_thana);
        users[_nid].postCode = _postCode;
        users[_nid].village = stringToBytes32(_village);
        users[_nid].exists = true;
        
        userArray.push(_nid);
        emit UserCreation(_nid);
    }
    
    function getUserArrayLen() public view returns(uint len){
        return userArray.length;
    }
    
    function getUserIdById(uint id) public view returns(uint UserId){
        return userArray[id];
    }
    
    function getUserByNid(uint _nid) public view returns(bytes32 fullName, bytes32 fatheName, bytes32 district, bytes32 thana, uint24 postCode, bytes32 village){
        require(users[_nid].exists == true, "User Doesn't exist");
        fullName = users[_nid].fullName;
        fatheName = users[_nid].fathersName;
        district = users[_nid].district;
        thana = users[_nid].thana;
        postCode = users[_nid].postCode;
        village = users[_nid].village;
    }
    
    function getUserOwnedByUid(uint _uid) public view returns(uint number, bytes32[] khatianList){
        number = userOwned[_uid].number;
        khatianList =  userOwned[_uid].khatianList;
    }

    //
    //
    //
    //
    //
    //
    //
    
    // * PLOT SECTION
    struct Plot{
        bytes32 division;
        bytes32 district;
        bytes32 thana;
        uint16 JLNo;
        uint16 plotNo;
        uint8 plotType;
        uint32 plotArea;
        bool exists;
    }
    
    mapping (bytes32 => Plot)  plots;
    bytes32[]   plotArray;
    
    event PlotCreation(bytes32 plotHash);

        function createPlot(string _division, string _district, string _thana, uint16 _JLNo, uint16 _plotNo, uint8 _plotType, uint32 _plotArea) public{
        require(msg.sender == contarctOwner, "You are not authorized");
        _division = toUpper(_division);
        _district = toUpper(_district);
        _thana = toUpper(_thana);
        bytes32 plotHash = keccak256(abi.encodePacked(_division, _district, _thana, _JLNo, _plotNo));
        require(plots[plotHash].exists != true, "Plot already exsits");
        plots[plotHash].division = stringToBytes32(_division);
        plots[plotHash].district = stringToBytes32(_district);
        plots[plotHash].thana = stringToBytes32(_thana);
        plots[plotHash].JLNo = _JLNo;
        plots[plotHash].plotNo = _plotNo;
        plots[plotHash].plotType = _plotType;
        plots[plotHash].plotArea = _plotArea;
        plots[plotHash].exists = true;
        plotArray.push(plotHash);
        emit PlotCreation(plotHash);
    }
    
    
    function getPlotArrayLen() public view returns(uint len){
        return plotArray.length;
    }
    
    function getPlotHashById(uint id) public view returns(bytes32 plotHash){
        return plotArray[id];
    }
    
    function getPlotByHash(bytes32 plotHash) public view returns(bytes32 division, bytes32 district, bytes32 thana, uint16 JLNo, uint16 plotNo, uint8 plotType, uint32 plotArea){
        require(plots[plotHash].exists == true, "Plot doesn't exist");
        division = plots[plotHash].division;
        district = plots[plotHash].district;
        thana = plots[plotHash].thana;
        JLNo = plots[plotHash].JLNo;
        plotNo = plots[plotHash].plotNo;
        plotType = plots[plotHash].plotType;
        plotArea = plots[plotHash].plotArea;
    }

    //
    //
    //
    //
    //
    //
    //
    
    // * KHATIYAN SECTION
    struct Khatian{
        uint64 id;
        bytes32 plotHash;
        uint16 percentOwned;
        bytes32 buyFrom;
        bytes32[] sellTo;
        uint16[] sellPercentage;
        uint[] ownerArray;
        uint16[] percentPerOwner;
        bool exists;
    }

    mapping (bytes32 => Khatian)  khatians;
    bytes32[]   khatianArray;
    
    event KhatiyanCreation(bytes32 khatianHash);

    function createKhatiyan(uint64 _khatianiId, bytes32 _plotHash, uint16 _percentOwn, uint[] _user, uint16[] _percentage) public{
        require(msg.sender == contarctOwner, "Sender is not authorized");
        require(plots[_plotHash].exists == true, "Plot doesn't exist");
        bytes32 khatianHash = keccak256(abi.encodePacked(_khatianiId, _plotHash));
        require(khatians[khatianHash].exists != true, "Khatian already exists");
        for(uint j = 0; j< _user.length; j++){
             require(users[_user[j]].exists == true, "User's NID doesn't exist");
        }
        
        khatians[khatianHash].id = _khatianiId;
        khatians[khatianHash].plotHash = _plotHash;
        khatians[khatianHash].percentOwned = _percentOwn;
        khatians[khatianHash].exists = true;
        khatians[khatianHash].percentPerOwner = _percentage;
        khatians[khatianHash].ownerArray = _user;
        
        for(uint i = 0; i< _user.length; i++){
            addUserOwned(_user[i], khatianHash);
        }
        
        khatianArray.push(khatianHash);
        emit KhatiyanCreation(khatianHash);
    }
    
    function createKhatiyanFromOld(uint64 _khatianiId, bytes32 _plotHash, uint16 _percentOwn, bytes32 _buyFrom, uint[] _user, uint16[] _percentage) public{
        require(msg.sender == contarctOwner, "Sender is not authorized");
        require(plots[_plotHash].exists == true, "Plot doesn't exist");
        
        bytes32 khatianHash = keccak256(abi.encodePacked(_khatianiId, _plotHash));
        
        require(khatians[khatianHash].exists != true, "Khatian already exists");
        require(khatians[_buyFrom].exists, "previous Khatian doesn't exist");
        require(khatians[_buyFrom].percentOwned >= _percentOwn, "Not enough land to sell");
        for(uint j = 0; j< _user.length; j++){
             require(users[_user[j]].exists == true, "User's NID doesn't exist");
        }
        
        khatians[_buyFrom].sellTo.push(khatianHash);
        khatians[_buyFrom].sellPercentage.push(_percentOwn);
        khatians[_buyFrom].percentOwned  -= _percentOwn;
        
        khatians[khatianHash].buyFrom = _buyFrom;
        khatians[khatianHash].id = _khatianiId;
        khatians[khatianHash].plotHash = _plotHash;
        khatians[khatianHash].percentOwned = _percentOwn;
        khatians[khatianHash].exists = true;
        khatians[khatianHash].percentPerOwner = _percentage;
        khatians[khatianHash].ownerArray = _user;
        
        for(uint i = 0; i< _user.length; i++){
            addUserOwned(_user[i], khatianHash);
        }
        
        khatianArray.push(khatianHash);
        
        emit KhatiyanCreation(khatianHash);
    }

    function getKhatianArrayLen() public view returns(uint len){
        return khatianArray.length;
    }
    
    function getKhatianHasById(uint id) public view returns(bytes32 khatianHash){
        return khatianArray[id];
    }
    
    function getKhatianByHash(bytes32 khatianHash) public view returns(uint64 khatianiId, bytes32 plotHash, uint16 percentOwn, bytes32 buyFrom, bytes32[] sellTo, uint16[] sellPercentage, uint[] ownerArray, uint16[] perOwnerPercentage){
        require(khatians[khatianHash].exists == true, "Khatian doesn't exist");
        khatianiId = khatians[khatianHash].id;
        plotHash = khatians[khatianHash].plotHash;
        percentOwn = khatians[khatianHash].percentOwned;
        buyFrom = khatians[khatianHash].buyFrom;
        sellTo = khatians[khatianHash].sellTo;
        sellPercentage = khatians[khatianHash].sellPercentage;
        ownerArray = khatians[khatianHash].ownerArray;
        perOwnerPercentage = khatians[khatianHash].percentPerOwner;
        
    }

    //
    //
    //
    //
    //
    //
    //
    
    // * MISC FUNCTIONS
    function stringToBytes32(string memory source) internal pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }
    
    function toUpper(string str) internal pure returns (string) {
		bytes memory bStr = bytes(str);
		bytes memory bUpper = new bytes(bStr.length);
		for (uint i = 0; i < bStr.length; i++) {
			if ((bStr[i] >= 97) && (bStr[i] <= 122)) {
				bUpper[i] = bytes1(int(bStr[i]) - 32);
			} else {
				bUpper[i] = bStr[i];
			}
		}
		return string(bUpper);
	}
}
