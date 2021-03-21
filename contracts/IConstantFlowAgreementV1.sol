// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract IConstantFlowAgreementV1 {
    function deleteFlow() public {}

    function getFlow(
        IERC20 _token,
        address _sender,
        address _reciever
    ) public returns (uint256) {}
}
