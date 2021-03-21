pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract SaleItem is ERC1155 {
    constructor() public ERC1155("https://item.example/api/item/{id}.json") {
        _mint(msg.sender, 0, 1000, "");
    }
}
