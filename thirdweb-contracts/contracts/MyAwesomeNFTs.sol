// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC721Base.sol";
import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";

contract MyAwesomeNFTs is ERC721Base, PermissionsEnumerable {

    // Mapping from token ID to the power level of that NFT
    mapping(uint256 => uint256) public powerLevel;

      constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    )
        ERC721Base(
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps
        )
    {

        // Set up the DEFAULT ADMIN ROLE and provide that role to the wallet deployer
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    // Add a func to set the power level, this function is only callable by the admin members
    function setPowerLevel(uint256 tokenId, uint256 _powerLevel) public onlyRole(DEFAULT_ADMIN_ROLE) {
        powerLevel[tokenId] = _powerLevel;
    }

    // Override the mintTo function of the base contract to set the power level of the NFT
    function mintTo(address _to, string memory _tokenURI) public virtual override {
        // Grab the next available token ID
        uint256 tokenId = nextTokenIdToMint();

        // Actually mint the NFT
        super.mintTo(_to, _tokenURI);

        // Set the power level of that NFT
        powerLevel[tokenId] = tokenId;
    }

}

// Open this link to deploy your contracts: https://thirdweb.com/contracts/deploy/QmVYGPrwMx8cdffoGP985mkDsX3iC2WTcwhvedUcgVBVRu
// 0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848

// https://thirdweb.com/goerli/0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848/explorer > Set Owner (setOwner) (_newOwner) 0x798989678DfF778D6e6957761f0d9A4ccc36E559

// {
//   "to": "0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848",
//   "from": "0x798989678DfF778D6e6957761f0d9A4ccc36E559",
//   "transactionHash": "0x81293cab93f56f9b9e888536418a6ec7400e88f5f77e41fa46f028b690b77ce6",
//   "events": [
//     {
//       "transactionIndex": 101,
//       "blockNumber": 8667793,
//       "transactionHash": "0x81293cab93f56f9b9e888536418a6ec7400e88f5f77e41fa46f028b690b77ce6",
//       "address": "0x4c9AA8F1970f3dF3E0316D3171E86c5F906EC848",
//       "topics": [
//         "0x8292fce18fa69edf4db7b94ea2e58241df0ae57f97e0a6c9b29067028bf92d76",
//         "0x000000000000000000000000798989678dff778d6e6957761f0d9a4ccc36e559",
//         "0x000000000000000000000000798989678dff778d6e6957761f0d9a4ccc36e559"
//       ],
//       "data": "0x",
//       "logIndex": 97,
//       "blockHash": "0xb662b6b19efde8e3b46494fb60570def969b36c86c7c9c48c2f380389df18438",
//       "args": [
//         "0x798989678DfF778D6e6957761f0d9A4ccc36E559",
//         "0x798989678DfF778D6e6957761f0d9A4ccc36E559"
//       ],
//       "event": "OwnerUpdated",
//       "eventSignature": "OwnerUpdated(address,address)"
//     }
//   ]
// }