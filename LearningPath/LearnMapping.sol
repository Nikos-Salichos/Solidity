contract learnMapping{
    
    //key and value - key can be string uint or bool - value can be anything
    mapping(address => uint256) public myMap;
    
    function getAddress(address _addr) public view returns(uint){
        return myMap[_addr];
    }
    
    function setAddress(address _addr, uint _i) public {
        myMap[_addr] = _i;
    }
    
    function removeAddress(address _addr)public {
        delete myMap[_addr];
    }
    
}
