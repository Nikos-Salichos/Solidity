pragma solidity >= 0.7.0 < 0.9.9;

contract myLoopingPracticeContract {
    
     uint [] private longList = [1,2,3,4,5,6,7,8,9,10,1,12,13,14,15,16,17,18,19,20];
     uint [] private numbersList = [1,4,34,56];
     
     function numbersListLoop(uint userNumber) public view returns(bool){
         bool numberExists = false;
         for(uint i =0 ; i < numbersList.length ; i++){
             if(numbersList[i] == userNumber)
             {
                 numberExists = true;
                 return true;
             } 
             else
             {
                 return false;
             }
         }
     }
     
     function evenNumbersLoop() public view returns (uint){
        uint count = 0;
        for(uint i = 0; i<longList.length; i++ ){
            if(longList[i] % 2 == 0)
            {
             count ++;
            }
        }
        return count;
     }
     
}
