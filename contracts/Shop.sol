pragma solidity >=0.4.22 <0.9.0;
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

// import {
//     ISuperfluid,
// } from "https://github.com/superfluid-finance/protocol-monorepo/blob/remix-support/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";

// import {
//     IConstantFlowAgreementV1
// } from "https://github.com/superfluid-finance/protocol-monorepo/blob/remix-support/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";

import "./IConstantFlowAgreementV1.sol";

import "./ISuperfluid.sol";

contract Shop {
    using SafeMath for uint256;

    IERC1155 NFT;
    address owner;
    uint256 endBlock;
    uint256 NFTPerShare;
    IERC20 tokenToPayIn;
    address[] buyers;
    mapping(address => uint256) buyerOwnership;
    ISuperfluid host;
    IConstantFlowAgreementV1 cfa;

    constructor(
        ISuperfluid _host,
        IConstantFlowAgreementV1 _cfa,
        IERC1155 _NFT,
        address _owner,
        uint256 _endBlockBuffer,
        IERC20 _tokenToPayIn
    ) {
        cfa = _cfa;
        host = _host;
        NFT = _NFT;
        owner = _owner;
        endBlock = block.number.add(_endBlockBuffer);
        tokenToPayIn = _tokenToPayIn;
    }

    function stop(uint256 _amount, uint256 _pid) public {
        require(block.number >= endBlock, "Not yet :)");
        uint256 i = 0;
        uint256 len = buyers.length;
        uint256 sum = 0;
        for (i = 0; i < len; ++i) {
            uint256 share = cfa.getFlow(tokenToPayIn, buyers[i], address(this));
            buyerOwnership[buyers[i]] = share;
            sum = sum.add(share);
            host.callAgreement(
                cfa,
                abi.encodeWithSelector(
                    cfa.deleteFlow.selector,
                    tokenToPayIn,
                    buyers[i],
                    owner,
                    new bytes(0)
                ),
                "0x"
            );
        }
        uint256 shares = sum;
        uint256 nftBal = NFT.balanceOf(address(this), 0);
        // need to solve for the nftPerShare
        // nftPerShare = ????

        //= nft per dollar
        //= nft supply / total dollar amount
        NFTPerShare = nftBal.mul(1e12).div(shares);
        uint256 bal = tokenToPayIn.balanceOf(address(this));
        tokenToPayIn.transfer(owner, bal);
    }

    function claim() public {
        require(buyerOwnership[msg.sender] > 0, "nothing to claim");
        uint256 share = buyerOwnership[msg.sender];
        uint256 toSend = share.mul(NFTPerShare).div(1e12);
        NFT.safeTransferFrom(
            address(this),
            address(msg.sender),
            0,
            toSend,
            "0x0"
        );
    }

    function setBuyers(address[] memory _buyers) public {
        require(owner == msg.sender, "Only owner can call");
        buyers = _buyers;
    }
}
