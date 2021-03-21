pragma solidity >=0.4.22 <0.9.0;

import "./Shop.sol";

contract ShopFactory {
    address owner;

    mapping(address => address) deployedClones;

    constructor(address _owner) {
        owner = _owner;
    }

    function mintShop(
        address _NFT,
        uint256 _endBlockBuffer,
        address _tokenToPayIn
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
