ShopFactory = [
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
          "internalType": "address",
          "name": "_owner",
          "type": "address"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "inputs": [
        {
          "internalType": "contract IERC1155",
          "name": "_NFT",
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
      "name": "mintShop",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    }
  ]