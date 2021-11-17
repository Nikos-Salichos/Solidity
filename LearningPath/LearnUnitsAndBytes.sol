pragma solidity >= 0.7.0 < 0.9.0;

contract BytesAndUnits{
    
    //Default uint is uint256, but you can declare uints with less bits , uint8, uint16, uint32
    
    //Conversion to smaller type costs higher order bits
    uint32 a = 0x12345678;
    uint16 b = uint16(a); // b = 0x5678
    
    //Conversion to higher type padding bits to the left
    uint16 c = 0x1234;
    uint32 d = uint32(c); //d = 0x00001234
    
    bytes2 e = 0x1234;
    bytes1 f = bytes1(e);  //f = 0x12
    
    bytes2 g = 0x1234;
    bytes4 h = bytes4(g); //h 0x12340000
}
