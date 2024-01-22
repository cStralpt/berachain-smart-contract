// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Todo {
    address public owner;
    string public ownerName;
    string[] todoNames;
    struct TodoItem {
        uint id;
        string name;
        string content;
    }
    mapping(string => TodoItem) todoList;

    event TodoCreated(string todoName, uint todoId);

    constructor(string memory _ownerName) {
        owner = msg.sender;
        ownerName = _ownerName;
    }

    function createTodo(string memory _name, string memory _content) public {
        todoList[_name] = TodoItem({id: 1, name: _name, content: _content});
        todoNames.push(_name);
        emit TodoCreated(_name, 1);
    }

    function editTodo(string memory _name, string memory _content) public {
        require(todoList[_name].id != 0, "No such todo");
        todoList[_name] = TodoItem({id: 1, name: _name, content: _content});
    }

    function getTodo(
        string memory _todoName
    ) public view returns (TodoItem memory) {
        return todoList[_todoName];
    }

    function getAllTodos() public view returns (TodoItem[] memory) {
        require(todoNames.length > 0, "No todo");

        TodoItem[] memory allTodos = new TodoItem[](todoNames.length);

        for (uint256 index = 0; index < todoNames.length; index++) {
            string memory name = todoNames[index];
            allTodos[index] = todoList[name];
        }

        return allTodos;
    }
}
