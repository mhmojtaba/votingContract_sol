// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Voting{

    // counting votes of any condidates
    uint condidateCount;
    // the owner wallet address to deployer
    address owner;

    // storing datas of condidates only by deployer
    struct condidates{
        uint id;
        string name;
        uint voteCount;
    }

    // storing new condidates
    mapping (uint => condidates) public condidate;
    // checking if a client have voted or not
    mapping(address => bool) client;

    // storing msg.sender as a owner
    constructor ()public {
        owner = msg.sender;
    }

    // adding condidates only by OWNER
    function addCondidate (string memory name_) public returns(string memory){
        require(msg.sender==owner,"only the owner can add condidates");
        
        condidateCount++;
        condidate[condidateCount] = condidates(condidateCount , name_, 0);
        return "Added successfully";
    }

    // voting to condidates by clients
    // must be a valide condidate
    // any client can vote once
    function toVote(uint id_) public returns(string memory){
        require(id_<=condidateCount,"id is invalid and condidate not found");
        require(client[msg.sender]==false , "client has alresdy voted");
        condidate[id_].voteCount++;
        client[msg.sender]= true;
         return "client voted successfully";
    }

    // showing the result of vote and the one who has been selected as a winner
    function selected () public view returns(string memory){
        uint winnerID= 0;
        uint winnerVote = 0;

        for(uint i = 1; i<=condidateCount; i++){
            if(condidate[i].voteCount > winnerVote){
                winnerID = i;
                winnerVote = condidate[i].voteCount;
            }
        }
        return condidate[winnerID].name;
    }
}