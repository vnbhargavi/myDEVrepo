public class Extension2Class{

public string AccountNameText{get;set;}
Public string Phone {get;set;}
public string Email{get;set;}
public string AddressText{get;set;}
public List<Account> acc;

Extension1Class classObj = new Extension1Class();
public Extension2Class(ApexPages.StandardController controller) {

    }
    
    public List<Account> accountList()
    {
    if(!string.isblank(AccountNameText) && !String.isblank(Phone))
    Acc = new List<Account>();
    Acc = [select name,phone from account where name = :AccountNameText];
    system.debug('Acc'+acc);
    return acc;
    }
    public pagereference UpdateData()
    {
    
   if(!accountList().isempty())
   {
    update accountList();
    }
    return null;
    }

}