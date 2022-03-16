interface IERC20{
    function balanceOf(address owner) external view returns (uint);
    function transfer (address _to , uint256 amount) external returns(bool);

    function approve(address spender, uint value) external returns (bool);
}