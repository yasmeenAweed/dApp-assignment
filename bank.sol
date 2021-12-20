
pragma solidity ^0.8.0;


contract Bank{

    modifier onlyRegistered(){

        require (false , "User not rigister, please rigister to use this method");
        _;
    }
    function get_balance() external view onlyRegistered returns (uint){
        return account_balances[msg.sender];

    }

    function transfer (uint amount, address acctToTransferTo) public onlyRegistered {

     
     account_balances[msg.sender] -= amount;
     account_balances[acctToTransferTo] += amount;
    }
   


    function bankBalance() public view onlyRegistered returns (uint) { return address(this).balance;}

    function account_balances() public view onlyRegistered returns (uint) { return account_balances[msg.sender];
    }

    function withdraw(uint amount) external {

        account_balances[msg.sender] -= amount;
        payable (msg.sender).transfer(amount);

    }

    receive() external payable{
        account_balances[msg.sender] += msg.value;
        
    }
}


contract FunBank{

     uint number_of_accounts;
     mapping (address=> uint) account_balances;
     mapping(address=>uint) account_info_map;

    struct BankAccountRecord{
        uint account_number;
        string fullName;
        string dateOfBirth;
        string profession;
        string customer_addr;
        address wallet_addr;
    }

    string public bank_name;
    string public bank_address;
   
    

    BankAccountRecord[]  bankAccountRecords;
   
    function rigister_account(string memory full_name_, 
                              string memory profession_,
                              string memory dateOfBirth_,
                              string memory customer_addr_) external {


        require(account_info_map[msg.sender] == 0 , "Account already exists!");
        
        
        BankAccountRecord.push(
            BankAccountRecord({ 
            account_number:++number_of_accounts,
            full_name:full_name_,
            profession:dateOfBirth_,
            dateOfBirth:dateOfBirth_,
            customer_addr:customer_addr_,
            wallet_addr:msg.sender}));
    
        account_info_map[msg.sender] = number_of_accounts;
        return true;
    }
    }
