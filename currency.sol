pragma solidity ^0.8.7;

contract Currency {
    address public getOwner;

    uint8 public decimals;
    uint256 public totalSupply;
    
    string public name;
    string public symbol;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address from, address to, uint256 amount);
    event Approval(address tokenOwner, address spender, uint tokens);
    constructor() {
        name = "Guillermina Munoz";
        symbol = "GUI";
        getOwner = msg.sender;
        totalSupply = 100000000000;
        balanceOf[msg.sender] = totalSupply;
    }
    function increaseAllowance(address _approve, uint256 _amount) public {
        require(allowance[msg.sender][_approve] + _amount > allowance[msg.sender][_approve]);
        allowance[msg.sender][_approve] += _amount;   
        emit Approval(msg.sender, _approve, allowance[msg.sender][_approve]);
    }
    function decreaseAllowance(address _approved, uint256 _amount) public {
        require(allowance[msg.sender][_approved] >= _amount );
        allowance[msg.sender][_approved] -= _amount;
        emit Approval(msg.sender, _approved, allowance[msg.sender][_approved]);
    }
    function transfer(address _to, uint256 _amount) public {
        _transfer(msg.sender, _to, _amount);
        emit Transfer(msg.sender, _to, _amount);
    }
    function transferFrom(address _from, address _to, uint256 _amount) public returns(bool) {
        require(_amount <= balanceOf[_from]);
        require(_amount <= allowance[_from][msg.sender]);
        _transfer(_from, _to, _amount);
        emit Transfer(_from, _to, _amount);
        return true;
    }
    function _transfer(address _from, address _to, uint256 _amount) internal {
        require(balanceOf[_to] + _amount > balanceOf[_to]);
        require(balanceOf[_from] > _amount);
        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;
    }

    
}