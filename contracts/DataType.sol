// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataType {
    uint256 public positiveNumber = 100;
    int256 public negativeNumber = -50;
    bool public isActive = true;
    address public recipient;
    address payable public wallet = payable(address(0));
    bytes32 public fixedData =
        0x3078616263646566313233343536000000000000000000000000000000000000;
    bytes public dynamicData;
    enum State {
        Created,
        Active,
        Inactive
    }
    State public currentState = State.Active;

    // 스마트 계약이 배포될 때 address 타입의 값을 인수로 받아 _recipient 변수에 저장
    constructor(address _recipient) {
        require(_recipient != address(0), "Invalid recipient address");
        recipient = _recipient; // 전달받은 _recipent를 스마트 계약의 recipent 변수에 저장
    }

    function setPositiveNumber(uint256 _newPositiveNumber) public {
        positiveNumber = _newPositiveNumber;
    }

    function setNegativeNumber(int256 _newNegativeNumber) public {
        if (_newNegativeNumber == -200) {
            negativeNumber = _newNegativeNumber;
        }
    }

    function toggleActive() public {
        isActive = !isActive;
    }

    event WalletUpdated(address indexed oldWallet, address indexed newWallet);

    function setWallet(address payable _wallet) public {
        require(_wallet != address(0), "Invalid wallet address");
        wallet = _wallet;
    }

    function setFixedData(bytes32 _fixedData) public {
        fixedData = _fixedData;
    }

    function setDynamicData(bytes memory _dynamicData) public {
        require(_dynamicData.length <= 32, "Data too long");
        dynamicData = _dynamicData;
    }

    function getDynamicDataLength() public view returns (uint) {
        return dynamicData.length;
    }

    function getDynamicDataAsString() public view returns (string memory) {
        return string(dynamicData);
    }

    function setState(State _state) public {
        require(
            _state == State.Created ||
                _state == State.Active ||
                _state == State.Inactive,
            "Invalid state"
        );
        currentState = _state;
    }

    function getDetails()
        public
        view
        returns (
            uint256,
            int256,
            bool,
            address,
            address,
            bytes32,
            bytes memory,
            State
        )
    {
        return (
            positiveNumber,
            negativeNumber,
            isActive,
            wallet,
            recipient,
            fixedData,
            dynamicData,
            currentState
        );
    }
}
