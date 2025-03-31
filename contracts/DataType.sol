// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataType {
    uint256 public positiveNumber = 100;
    int256 public negativeNumber = -50;
    bool public isActive = true;
    address payable public recipient;
    address public wallet = payable(address(0));
    bytes32 public fixedData = "0xabcdef123456";
    bytes public dynamicData;
    enum State {
        Created, // 0
        Active, // 1
        Inactive // 2
    }
    State public currentState = State.Active;

    // 스마트 계약이 배포될 때 address 타입의 값을 인수로 받아 _recipient 변수에 저장
    constructor(address _recipient) {
        require(_recipient != address(0), "Invalid recipient address");
        recipient = payable(_recipient); // 전달받은 _recipent를 스마트 계약의 recipent 변수에 저장
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
        isActive = !isActive; //isActive에 반대값 저장
    }

    function setWallet(address payable _newWallet) public {
        wallet = _newWallet;
        recipient = payable(_newWallet);
    }

    function setFixedData(bytes32 _fixedData) public {
        require(_fixedData.length <= 32, "Data too long");
        fixedData = _fixedData;
    }

    // bytes 는 가변이라 참조이기 때문에 어디서(memory에서인지 storage 에서 인지) 확인 하는지 적어야 함
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
