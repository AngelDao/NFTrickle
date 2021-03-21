pragma solidity >=0.4.22 <0.9.0;

import "./Shop.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract ShopFactory {
    address owner;

    mapping(IERC1155 => address) deployedClones;

    constructor(address _owner) {
        owner = _owner;
    }

    function mintShop(
        IERC1155 _NFT,
        uint256 _endBlockBuffer,
        IERC20 _tokenToPayIn
    ) public {
        require(
            deployedClones[_NFT] == address(0),
            "Clone has already been deployed"
        );
        Shop clone =
            new Shop(_NFT, address(msg.sender), _endBlockBuffer, _tokenToPayIn);

        deployedClones[_NFT] = clone;
    }
}
