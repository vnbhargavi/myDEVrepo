public class Javascriptpagecontroller{
    public List<AccountWrapperCls> acctList {get;set;}
     public Set<String> selAccountNames {get;set;}
     public Boolean hasSelAcct {get;set;}

     // CONSTRUCTOR
     public Javascriptpagecontroller(){
          acctList = new List<AccountWrapperCls>();
          selAccountNames = new Set<String>();

          for(Account a : [SELECT AccountNumber,id,Subcategories__c, Name 
          FROM Account WHERE AccountNumber != NULL 
          LIMIT 100]){
               acctList.add(new AccountWrapperCls(a));
          }
     }

     // METHODS
     public void displaySelectedAccountNumbers(){
          selAccountNames.clear();
          hasSelAcct = false;
          for(AccountWrapperCls cWrapper : acctList){
               if(cWrapper.isSelected){
                    hasSelAcct = true;
                   selAccountNames.add(cWrapper.cAccount.AccountNumber);
               }
          }
     }
    public class AccountWrapperCls {
     public Boolean isSelected {get;set;}
     public Account cAccount {get;set;}

     public AccountWrapperCls(Account cAccount){
          this.cAccount = cAccount;
     }
}
}