pragma solidity >=0.4.22 <0.9.0;
import "@openzeppelin/contracts/math/SafeMath.sol";

import {
    ISuperfluid,
    ISuperToken,
    ISuperApp,
    ISuperAgreement,
    SuperAppDefinitions
} from "https://github.com/superfluid-finance/protocol-monorepo/blob/remix-support/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";

import {
    IConstantFlowAgreementV1
} from "https://github.com/superfluid-finance/protocol-monorepo/blob/remix-support/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol";

contract Shop {
    using SafeMath for uint256;

    address NFT;
    address owner;
    uint256 endBlock;
    address tokenToPayIn;
    address[] buyers;
    ISuperfluid host;
    IConstanFlowAgreementV1 cfa;

    constructor(
        ISuperfluid _host,
        IConstanFlowAgreementV1 _cfa,
        address _NFT,
        address _owner,
        uint256 _endBlockBuffer,
        address _tokenToPayIn
    ) {
        cfa = _cfa;
        host = _host;
        NFT = _NFT;
        owner = _owner;
        price = _price;
        endBlock = block.number.add(_endBlockBuffer);
        tokenToPayIn = _tokenToPayIn;
    }

    function claim(uint256 _amount, uint256 _pid) public {
        require(block.number >= endblock, "Not yet :)");
        uint256 i = 0;
        uint256 len = buyers.length;
        for (i = 0; i < len; ++i) {
            _host.callAgreement(
                _cfa,
                abi.encodeWithSelector(
                    _cfa.deleteFlow.selector,
                    _acceptedToken,
                    buyers[i],
                    owner,
                    new bytes(0)
                ),
                "0x"
            );
        }
    }

    function setBuyers(address[] _buyers) public {
        require(owner == msg.sender, "Only owner can call");
        buyers = _buyers;
    }

    function buy() public {}
}
