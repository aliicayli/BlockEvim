// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract StorageContract {
  string public storedData;

  event DataChanged(string newData);

  function set(string memory data) public {
    storedData = data;
    emit DataChanged(data);
  }

  function get() public view returns (string memory) {
    return storedData;
  }
}
