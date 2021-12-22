
pragma solidity ^0.8.0;


contract Bank{

    mapping(address=>uint) account_balances;

    
    
    function get_balance() external view  returns (uint){
          return account_balances[msg.sender];

    }

    function transfer (address recipient , uint amount) public  {

     
     account_balances[msg.sender] -= amount;
     account_balances[recipient] += amount;
    }
   

    function withdraw(uint amount) public {

        account_balances[msg.sender] -= amount;
        payable (msg.sender).transfer(amount);

    }

    receive() external payable{
        account_balances[msg.sender] += msg.value;
        
    }
}


contract FunBank{

    uint number_of_accounts;

    mapping(address=>uint) account_balances;
    mapping(address=>uint) account_info_map;

    struct BankAccountRecord{
        uint account_number;
        string fullName;
        string profession;
        string dateOfBirth;
        address wallet_addr;
        string customer_addr;
    }

    BankAccountRecord[]  bankAccountRecords;



modifier onlyRegistered(){

        require (account_info_map[msg.sender] > 0 , "User not rigister, please rigister to use this method");
        _;
    }

    function get_balance() external view onlyRegistered returns (uint){
          return account_balances[msg.sender];

    }

    function transfer (address recipient , uint amount) public onlyRegistered {

     
     account_balances[msg.sender] -= amount;
     account_balances[recipient] += amount;
    }
   

    function withdraw(uint amount) public onlyRegistered {

        account_balances[msg.sender] -= amount;
        payable (msg.sender).transfer(amount);

    }

    receive() external payable{
        account_balances[msg.sender] += msg.value;
        
    }
    

    function rigister_account(
        string memory fullName_,
        string memory profession_,
        string memory dateOfBirth_,
        string memory customer_addr_) external {


        require(account_info_map[msg.sender] == 0 , "Account already exists!");
        
        
        bankAccountRecords.push(
            BankAccountRecord({ 
            account_number:++number_of_accounts,
            fullName:fullName_,
            profession:profession_,
            dateOfBirth:dateOfBirth_,
            wallet_addr:msg.sender,
            customer_addr:customer_addr_}));
    
        
        
        account_info_map[msg.sender] = number_of_accounts;
    
    }
}
