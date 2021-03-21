pragma solidity >=0.4.22 <0.9.0;
import "@openzeppelin/contracts/math/SafeMath.sol";

contract Shop {
    using SafeMath for uint256;

    address NFT;
    address owner;
    uint256 endBlock;
    address tokenToPayIn;
    address[] buyers;

    constructor(
        address _NFT,
        address _owner,
        uint256 _endBlockBuffer,
        address _tokenToPayIn
    ) {
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
        for (i = 0; i < len; ++i) {}
    }

    function setBuyers(address[] _buyers) public {
        require(owner == msg.sender, "Only owner can call");
        buyers = _buyers;
    }

    function buy() public {}
}
