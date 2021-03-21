pragma solidity >=0.4.22 <0.9.0;

import "./Shop.sol";

contract ShopFactory {
    address owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function mintShop(
        address _NFT,
        uint256 _endBlockBuffer,
        address _tokenToPayIn
    ) public {
        Shop clone =
            new Shop(_NFT, address(msg.sender), _endBlockBuffer, _tokenToPayIn);
    }
}
