pragma solidity ^0.5.16;

pragma experimental ABIEncoderV2;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
}

contract Voting {
    IERC20 public wfoToken;
    address public admin;
    uint public voteFee = 10 * 10**18;

    struct Proposal {
        string name;
        uint voteCount;
    }

    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;

    constructor(address _token, string[] memory proposalNames) public {
        wfoToken = IERC20(_token);
        admin = msg.sender;

        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    function vote(uint proposalIndex) public {
        require(!hasVoted[msg.sender], "Already voted");
        require(wfoToken.transferFrom(msg.sender, admin, voteFee), "Transfer failed");

        proposals[proposalIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getProposalsCount() public view returns (uint) {
        return proposals.length;
    }

    function getProposal(uint index) public view returns (string memory, uint) {
        Proposal memory p = proposals[index];
        return (p.name, p.voteCount);
    }
}
