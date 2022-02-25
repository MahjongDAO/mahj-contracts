// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC1155ERC20.sol";

contract MahjongDAO is Ownable, ERC1155ERC20 {
    string public contractURI = "https://www.mahj.vip/metadata";

    constructor() ERC1155ERC20("Mahjong DAO Tokens", "MAHJ", "https://www.mahj.vip/metadata/{id}.json") {
        _bareMint(msg.sender, 0, 21_000_000_000e18);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC1155ERC20) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory userData
    ) external onlyOwner {
        uint256 total = totalSupply(id) + amount;
        if (id == 0) {
            require(total <= 21_000_000_000e18, "exceed max supply");
        } else if (id >= 0x1f022 && id <= 0x1f029) {
            // 🀢🀣🀤🀥🀦🀧🀨🀩 ×1
            require(total <= 1, "only 1 tile");
        } else if (id >= 0x1f000 && id <= 0x1f02a) {
            // 🀀🀁🀂🀃🀄🀅🀆🀇🀈🀉🀊🀋🀌🀍🀎🀏🀐🀑🀒🀓🀔🀕🀖🀗🀘🀙🀚🀛🀜🀝🀞🀟🀠🀡🀪 ×4
            require(total <= 4, "only 4 tiles");
        } else {
            require(total <= 21_000_000_000, "exceed max supply");
        }
        _mint(to, id, amount, userData);
    }

    function burn(
        address account,
        uint256 id,
        uint256 value
    ) public virtual {
        require(account == msg.sender, "not owner");

        _burn(account, id, value);
    }
}
