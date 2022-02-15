// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ERC1155ERC20.sol";

contract Mahjong is ERC1155ERC20 {
    string public contractURI = "https://www.mahj.vip/meta";

    uint256[] private _tokens;

    mapping(address => bool) private _adminApprovals;

    event ApprovalAdmin(address indexed admin, address indexed account, bool approved);

    constructor() ERC1155ERC20("Mahjong Tokens", "MAHJ", "https://www.mahj.vip/meta/{id}.json") {
        _adminApprovals[msg.sender] = true;

        _bareMint(msg.sender, 0, 1_000_000_000e18);
        _tokens.push(0);

        for (uint256 id = 0x1f000; id <= 0x1f021; id++) {
            _bareMint(msg.sender, id, 4);
            _tokens.push(id);
        }

        for (uint256 id = 0x1f022; id <= 0x1f029; id++) {
            _bareMint(msg.sender, id, 1);
            _tokens.push(id);
        }

        _bareMint(msg.sender, 0x1f02a, 4);
        _tokens.push(0x1f02a);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC1155ERC20) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function isAdmin(address account) public view returns (bool) {
        return _adminApprovals[account];
    }

    function setAdmin(address account, bool approved) external {
        require(isAdmin(msg.sender), "not admin");
        require(msg.sender != account, "approval for self");
        require(address(0) != account, "approval for 0 address");

        _adminApprovals[account] = approved;
        emit ApprovalAdmin(msg.sender, account, approved);
    }

    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory userData
    ) external {
        require(isAdmin(msg.sender), "not admin");

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

        for (uint256 i = 0; i < _tokens.length; i++) {
            if (_tokens[i] == id) {
                return; // exists and return
            }
        }
        _tokens.push(id);
    }

    function burn(
        address account,
        uint256 id,
        uint256 value
    ) public virtual {
        require(
            account == msg.sender || isApprovedForAll(account, msg.sender),
            "not owner nor approved"
        );

        _burn(account, id, value);
    }

    function tokens() external view returns (uint256[] memory) {
        return _tokens;
    }
}
