// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IERC20 {
    function transfer(address to, uint amount) external;
    function decimals() external view returns(uint);
}

contract TokenSale {
    uint public tokenPriceInWei = 1 ether;
    IERC20 public token;
    address public owner;
    address public authorizedSigner;

    event TokensPurchased(address indexed buyer, uint amount, uint tokensPurchased, uint remainder);
    event AuthorizationChanged(address indexed newSigner);
    event EtherWithdrawn(address indexed owner, uint amount);

    constructor(address _token, address _signer) {
        token = IERC20(_token);
        owner = msg.sender;
        authorizedSigner = _signer;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function setAuthorizedSigner(address _signer) public onlyOwner {
        authorizedSigner = _signer;
        emit AuthorizationChanged(_signer);
    }

    function purchase(uint256 _amount, bytes memory _signature) public payable {
        require(msg.value >= tokenPriceInWei * _amount, "Not enough money sent");

        bytes32 messageHash = getMessageHash(msg.sender, _amount);
        require(recoverSigner(messageHash, _signature) == authorizedSigner, "Invalid signature");

        uint tokensToTransfer = _amount * 10 ** token.decimals();
        uint remainder = msg.value - (tokenPriceInWei * _amount);

        token.transfer(msg.sender, tokensToTransfer);
        payable(msg.sender).transfer(remainder);

        emit TokensPurchased(msg.sender, msg.value, _amount, remainder);
    }

    function getMessageHash(address _buyer, uint256 _amount) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_buyer, _amount));
    }

    function recoverSigner(bytes32 _messageHash, bytes memory _signature) public pure returns (address) {
        return recoverSignerFromMessage(_messageHash, _signature);
    }

    function recoverSignerFromMessage(bytes32 _messageHash, bytes memory _signature) internal pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_messageHash, v, r, s);
    }

    function splitSignature(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, "Invalid signature length");

        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }

    function withdrawEthers() public onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No ethers to withdraw");
        payable(owner).transfer(balance);
        emit EtherWithdrawn(owner, balance);
    }
}
