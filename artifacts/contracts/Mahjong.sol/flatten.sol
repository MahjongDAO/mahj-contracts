// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


// File @openzeppelin/contracts/utils/introspection/ERC165.sol@v4.4.2

/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 *
 * Alternatively, {ERC165Storage} provides an easier to use but more expensive implementation.
 */
abstract contract ERC165 is IERC165 {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}


// File @openzeppelin/contracts/token/ERC20/IERC20.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (token/ERC20/IERC20.sol)


/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


// File @openzeppelin/contracts/token/ERC1155/IERC1155.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (token/ERC1155/IERC1155.sol)


/**
 * @dev Required interface of an ERC1155 compliant contract, as defined in the
 * https://eips.ethereum.org/EIPS/eip-1155[EIP].
 *
 * _Available since v3.1._
 */
interface IERC1155 is IERC165 {
    /**
     * @dev Emitted when `value` tokens of token type `id` are transferred from `from` to `to` by `operator`.
     */
    event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value);

    /**
     * @dev Equivalent to multiple {TransferSingle} events, where `operator`, `from` and `to` are the same for all
     * transfers.
     */
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    /**
     * @dev Emitted when `account` grants or revokes permission to `operator` to transfer their tokens, according to
     * `approved`.
     */
    event ApprovalForAll(address indexed account, address indexed operator, bool approved);

    /**
     * @dev Emitted when the URI for token type `id` changes to `value`, if it is a non-programmatic URI.
     *
     * If an {URI} event was emitted for `id`, the standard
     * https://eips.ethereum.org/EIPS/eip-1155#metadata-extensions[guarantees] that `value` will equal the value
     * returned by {IERC1155MetadataURI-uri}.
     */
    event URI(string value, uint256 indexed id);

    /**
     * @dev Returns the amount of tokens of token type `id` owned by `account`.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(address account, uint256 id) external view returns (uint256);

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {balanceOf}.
     *
     * Requirements:
     *
     * - `accounts` and `ids` must have the same length.
     */
    function balanceOfBatch(address[] calldata accounts, uint256[] calldata ids)
        external
        view
        returns (uint256[] memory);

    /**
     * @dev Grants or revokes permission to `operator` to transfer the caller's tokens, according to `approved`,
     *
     * Emits an {ApprovalForAll} event.
     *
     * Requirements:
     *
     * - `operator` cannot be the caller.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns true if `operator` is approved to transfer ``account``'s tokens.
     *
     * See {setApprovalForAll}.
     */
    function isApprovedForAll(address account, address operator) external view returns (bool);

    /**
     * @dev Transfers `amount` tokens of token type `id` from `from` to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - If the caller is not `from`, it must be have been approved to spend ``from``'s tokens via {setApprovalForAll}.
     * - `from` must have a balance of tokens of type `id` of at least `amount`.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external;

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {safeTransferFrom}.
     *
     * Emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155BatchReceived} and return the
     * acceptance magic value.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;
}


// File @openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (token/ERC1155/IERC1155Receiver.sol)


/**
 * @dev _Available since v3.1._
 */
interface IERC1155Receiver is IERC165 {
    /**
        @dev Handles the receipt of a single ERC1155 token type. This function is
        called at the end of a `safeTransferFrom` after the balance has been updated.
        To accept the transfer, this must return
        `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
        (i.e. 0xf23a6e61, or its own function selector).
        @param operator The address which initiated the transfer (i.e. msg.sender)
        @param from The address which previously owned the token
        @param id The ID of the token being transferred
        @param value The amount of tokens being transferred
        @param data Additional data with no specified format
        @return `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))` if transfer is allowed
    */
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4);

    /**
        @dev Handles the receipt of a multiple ERC1155 token types. This function
        is called at the end of a `safeBatchTransferFrom` after the balances have
        been updated. To accept the transfer(s), this must return
        `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
        (i.e. 0xbc197c81, or its own function selector).
        @param operator The address which initiated the batch transfer (i.e. msg.sender)
        @param from The address which previously owned the token
        @param ids An array containing ids of each token being transferred (order and length must match values array)
        @param values An array containing amounts of each token being transferred (order and length must match ids array)
        @param data Additional data with no specified format
        @return `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))` if transfer is allowed
    */
    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external returns (bytes4);
}


// File @openzeppelin/contracts/token/ERC1155/extensions/IERC1155MetadataURI.sol@v4.4.2

// OpenZeppelin Contracts v4.4.1 (token/ERC1155/extensions/IERC1155MetadataURI.sol)


/**
 * @dev Interface of the optional ERC1155MetadataExtension interface, as defined
 * in the https://eips.ethereum.org/EIPS/eip-1155#metadata-extensions[EIP].
 *
 * _Available since v3.1._
 */
interface IERC1155MetadataURI is IERC1155 {
    /**
     * @dev Returns the URI for token type `id`.
     *
     * If the `\{id\}` substring is present in the URI, it must be replaced by
     * clients with the actual token type ID.
     */
    function uri(uint256 id) external view returns (string memory);
}


// File contracts/ERC1155ERC20.sol






contract ERC1155ERC20 is ERC165, IERC20, IERC1155, IERC1155MetadataURI {
    string private _name;
    string private _symbol;
    string private _uri;

    // ERC20-allowances
    mapping(address => mapping(address => uint256)) private _allowances;

    mapping(uint256 => mapping(address => uint256)) private _balances;

    mapping(address => mapping(address => bool)) private _operatorApprovals;

    mapping(uint256 => uint256) private _totalSupply;

    constructor(
        string memory name_,
        string memory symbol_,
        string memory uri_
    ) {
        _name = name_;
        _symbol = symbol_;
        _uri = uri_;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC1155).interfaceId ||
            interfaceId == type(IERC1155MetadataURI).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function name()  external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function decimals() external pure returns (uint8) {
        return 18;
    }

    function granularity() external pure returns (uint256) {
        return 1;
    }

    function uri(uint256) public view virtual returns (string memory) {
        return _uri;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() external view returns (uint256) {
        return _totalSupply[0];
    }

    function totalSupply(uint256 id) public view returns (uint256) {
        return _totalSupply[id];
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) external view returns (uint256) {
        return balanceOf(account, 0);
    }

    /**
     * @dev See {IERC1155-balanceOf}.
     */
    function balanceOf(address account, uint256 id) public view returns (uint256) {
        return _balances[id][account];
    }

    /**
     * @dev See {IERC1155-balanceOfBatch}.
     */
    function balanceOfBatch(
        address[] memory accounts,
        uint256[] memory ids
    ) external view returns (uint256[] memory) {
        require(accounts.length == ids.length, "length mismatch");

        uint256[] memory batchBalances = new uint256[](accounts.length);
        for (uint256 i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], ids[i]);
        }

        return batchBalances;
    }

    /**
     * @dev See {IERC20-transfer}.
     */
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool) {
        require(recipient != address(0), "0 address");

        _safeTransferFrom(msg.sender, recipient, 0, amount, "");
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     */
    function transferFrom(
        address holder,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        require(recipient != address(0), "0 address");
        require(holder != address(0), "0 address");

        uint256 currentAllowance = _allowances[holder][msg.sender];
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "exceeds allowance");
            unchecked {
                _approve(holder, msg.sender, currentAllowance - amount);
            }
        }

        _safeTransferFrom(holder, recipient, 0, amount, "");
        return true;
    }

    /**
     * @dev See {IERC1155-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) external {
        require(
            from == msg.sender || isApprovedForAll(from, msg.sender),
            "not approved"
        );
        _safeTransferFrom(from, to, id, amount, data);
    }

    /**
     * @dev See {IERC1155-safeBatchTransferFrom}.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) external {
        require(
            from == msg.sender || isApprovedForAll(from, msg.sender),
            "not approved"
        );
        _safeBatchTransferFrom(from, to, ids, amounts, data);
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address holder, address spender) external view returns (uint256) {
        return _allowances[holder][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     */
    function approve(address spender, uint256 value) external returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    /**
     * @dev See {IERC1155-isApprovedForAll}.
     */
    function isApprovedForAll(address account, address operator) public view returns (bool) {
        return _operatorApprovals[account][operator];
    }

    /**
     * @dev See {IERC1155-setApprovalForAll}.
     */
    function setApprovalForAll(address operator, bool approved) external {
        require(msg.sender != operator, "approval for self");
        require(address(0) != operator, "approval for 0");

        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function _approve(
        address holder,
        address spender,
        uint256 value
    ) internal virtual {
        require(holder != address(0), "0 address");
        require(spender != address(0), "0 address");

        _allowances[holder][spender] = value;
        emit Approval(holder, spender, value);
    }

    function _safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "0 address");

        uint256 fromBalance = _balances[id][from];
        require(fromBalance >= amount, "insufficient balance");
        unchecked {
            _balances[id][from] = fromBalance - amount;
        }
        _balances[id][to] += amount;

        emit TransferSingle(msg.sender, from, to, id, amount);
        if (id == 0) {
            emit Transfer(from, to, amount);
        }

        _doSafeTransferAcceptanceCheck(msg.sender, from, to, id, amount, data);
    }

    function _safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {
        require(ids.length == amounts.length, "length mismatch");
        require(to != address(0), "0 address");

        for (uint256 i = 0; i < ids.length; ++i) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            uint256 fromBalance = _balances[id][from];
            require(fromBalance >= amount, "insufficient balance");
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
            _balances[id][to] += amount;
        }

        emit TransferBatch(msg.sender, from, to, ids, amounts);

        _doSafeBatchTransferAcceptanceCheck(msg.sender, from, to, ids, amounts, data);
    }

    function _setURI(string memory newuri) internal virtual {
        _uri = newuri;
    }

    function _mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "0 address");

        _bareMint(to, id, amount);
        emit TransferSingle(msg.sender, address(0), to, id, amount);
        if (id == 0) {
            emit Transfer(address(0), to, amount);
        }

        _doSafeTransferAcceptanceCheck(msg.sender, address(0), to, id, amount, data);
    }

    function _bareMint(
        address to,
        uint256 id,
        uint256 amount
    ) internal virtual {
        _totalSupply[id] += amount;
        _balances[id][to] += amount;
    }

    function _burn(
        address from,
        uint256 id,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "0 address");

        uint256 fromBalance = _balances[id][from];
        require(fromBalance >= amount, "exceeds balance");
        unchecked {
            _totalSupply[id] -= amount;
            _balances[id][from] = fromBalance - amount;
        }

        emit TransferSingle(msg.sender, from, address(0), id, amount);
        if (id == 0) {
            emit Transfer(from, address(0), amount);
        }
    }

    function _doSafeTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) private {
        if (isContract(to)) {
            try IERC1155Receiver(to).onERC1155Received(operator, from, id, amount, data) returns (
                bytes4 response
            ) {
                if (response != IERC1155Receiver.onERC1155Received.selector) {
                    revert("ERC1155Receiver rejected");
                }
            } catch {
                revert("non ERC1155Receiver");
            }
        }
    }

    function _doSafeBatchTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) private {
        if (isContract(to)) {
            try IERC1155Receiver(to).onERC1155BatchReceived(operator, from, ids, amounts, data) returns (
                bytes4 response
            ) {
                if (response != IERC1155Receiver.onERC1155BatchReceived.selector) {
                    revert("ERC1155Receiver rejected");
                }
            } catch {
                revert("non ERC1155Receiver");
            }
        }
    }

    function isContract(address account) private view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}


// File contracts/Mahjong.sol


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
