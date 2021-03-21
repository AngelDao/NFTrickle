Shop = [
    {
      "inputs": [
        {
          "internalType": "contract ISuperfluid",
          "name": "_host",
          "type": "address"
        },
        {
          "internalType": "contract IConstantFlowAgreementV1",
          "name": "_cfa",
          "type": "address"
        },
        {
          "internalType": "contract IERC1155",
          "name": "_NFT",
          "type": "address"
        },
        {
          "internalType": "address",
          "name": "_owner",
          "type": "address"
        },
        {
          "internalType": "uint256",
          "name": "_endBlockBuffer",
          "type": "uint256"
        },
        {
          "internalType": "contract IERC20",
          "name": "_tokenToPayIn",
          "type": "address"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_amount",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_pid",
          "type": "uint256"
        }
      ],
      "name": "stop",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "claim",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address[]",
          "name": "_buyers",
          "type": "address[]"
        }
      ],
      "name": "setBuyers",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    }
  ]