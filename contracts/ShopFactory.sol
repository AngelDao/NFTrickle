pragma solidity >=0.4.22 <0.9.0;

import "./Shop.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "./IConstantFlowAgreementV1.sol";

import "./ISuperfluid.sol";

contract ShopFactory {
    address owner;

    mapping(IERC1155 => Shop) deployedClones;
    mapping(IERC1155 => bool) registeredClones;
    ISuperfluid host;
    IConstantFlowAgreementV1 cfa;

    constructor(
        ISuperfluid _host,
        IConstantFlowAgreementV1 _cfa,
        address _owner
    ) {
        cfa = _cfa;
        host = _host;
        owner = _owner;
    }

    function mintShop(
        IERC1155 _NFT,
        uint256 _endBlockBuffer,
        IERC20 _tokenToPayIn
    ) public {
        require(
            registeredClones[_NFT] == true,
            "Clone has already been deployed"
        );
        uint256 nftbal = _NFT.balanceOf(address(this), 0);
        require(nftbal > 0, "Need an NFT balance to open up a shop");
        Shop clone =
            new Shop(
                host,
                cfa,
                _NFT,
                address(msg.sender),
                _endBlockBuffer,
                _tokenToPayIn
            );
        _NFT.safeTransferFrom(msg.sender, address(clone), 0, nftbal, "0x0");
        deployedClones[_NFT] = clone;
        registeredClones[_NFT] = true;
    }
}
