// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./IConstantFlowAgreementV1.sol";

contract ISuperfluid {
    function callAgreement(
        IConstantFlowAgreementV1 c,
        bytes memory a,
        string memory b
    ) public {}
}
