//SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.6.0 <= 0.8.11;
pragma experimental ABIEncoderV2;

contract PollContract{

    struct Poll{
        uint256 id;
        string question;
        string[] choices;
        uint256[] choicesId;
        uint256 votes;
        address[] votersIds;
    }

    Poll[] private polls;

    struct Voter{
        address id;
        string name;
        uint256 age;
        bool hasRegister;
        bool hasVoted;
    }
    
    mapping(address => Voter) private registeredVoters;
    Voter[] private votersArray;

    struct VoterPoll{
        address voterId;
        uint256 pollid;
    }

    VoterPoll[] private voterPollArray;

    function createPoll(string memory question, string[] memory choices, uint256[] memory choicesId ) public{
        require (bytes(question).length > 0, "There is no question");
        require (choices.length > 1 , "Minimum 2 choices required");
        require (choices.length == choicesId.length,"Not all choices matched with Ids" );

        Poll memory newPoll;
        newPoll.id = polls.length;
        newPoll.question = question;
        newPoll.choices = choices;
        newPoll.choicesId = choicesId;

        polls.push(newPoll);
    }


    function VoterRegistered() private view returns(bool voterHasRegister)  {
        for (uint256 i = 0; i < votersArray.length; i++) {
            if(votersArray[i].id == msg.sender){
                 return true;
            }
        }
    }

    function VoterIsOverEighteen() private view returns(bool voterOver18)  {
        for (uint256 i = 0; i < votersArray.length; i++) {
            if(votersArray[i].id == msg.sender && votersArray[i].age > 17){
                 return true;
            }
        }
    }

    function VoterHasAlreadyVoteInPollId(uint256 pollId) private view returns(uint256)  {
        uint counter = 0;
        for (uint256 i = 0; i < voterPollArray.length; i++) {
            if(voterPollArray[i].voterId == msg.sender && voterPollArray[i].pollid == pollId ){
                counter++;
            }
        }
        return counter;
    }

    function registerVoter(string memory name, uint256 age) public returns (string memory){
        
       bool voterExists = VoterRegistered();

        if (voterExists == false) {
            Voter memory newVoter;
            newVoter.id = msg.sender;
            newVoter.name = name;
            newVoter.age = age;
            newVoter.hasRegister = true;
            newVoter.hasVoted = false;
            votersArray.push(newVoter);
            return "Voter registered successfully";
        } else {
            return "Voter already exists";
        }

    }

    function getPoll(uint256 pollId) external view returns(uint256, string memory, string[] memory, uint256[] memory){
        require(pollId < polls.length && pollId >= 0 , "Poll Id does not exist");
        return(
            polls[pollId].id,
            polls[pollId].question,
            polls[pollId].choices,
            polls[pollId].choicesId);
    }

    function voteMethod(uint256 pollId, uint256 voteChoice) external {
        require(pollId < polls.length , "Poll does not exists");
        require(voteChoice < polls[pollId].choicesId.length, "This choice does not exists");

        bool voterRegistered = VoterRegistered();
        require(voterRegistered == true, "User need to register first");

        bool voterIsOverEighteen = VoterIsOverEighteen();
        require(voterIsOverEighteen == true , "User must be over 18 to vote");
    
        uint256 counter = VoterHasAlreadyVoteInPollId(pollId);
        require(counter == 0 , "User has already vote");  

        for (uint256 i = 0; i < polls.length; i++) {
            if(pollId == polls[i].id)
            {
                for (uint256 j = 0; j < polls[i].choicesId.length; j++) {
                    if (voteChoice == j ) {
                        polls[i].votes++;
                    }
                }
            } 
        }

        VoterPoll memory newVoterPoll;
        newVoterPoll.voterId = msg.sender;
        newVoterPoll.pollid = pollId;
        voterPollArray.push(newVoterPoll);
    }

    function getVotes(uint256 pollId) public view returns(string memory, string[] memory, uint256){
        return(
            polls[pollId].question,
            polls[pollId].choices,
            polls[pollId].votes
        );
    }

}
