public with sharing class myController {

public id selectAccount{get;set;}
public List<Contact> contactsinformation{get;set;}

    public List<Account> getMyaccounts() {
        return [SELECT Id, Name, AccountNumber FROM Account ORDER BY
LastModifiedDate DESC LIMIT 10];
    }
    public void accountClicked() {
contactsInformation = [SELECT FirstName, LastName FROM Contact
WHERE AccountID = :selectAccount];
}


    public String name { get; set; }

    public myController(ApexPages.StandardSetController controller) {

    }


       Account acc;
    public String product {get;set;}
    public String selectedOfferingId {get;set;}
    public String selectedservice{
    get;
    set;
    }
    public List<Boolean> tabstatus = new List<Boolean>();
    public String selectedProductName;
    Id accId;
    public String selectedservicetype;
 Boolean disp=false;
    Public Boolean getdisp()
    {
    return disp;
    }  
public List<Boolean> gettabstatus()
             {
             tabstatus.clear();
             Integer i=0;
             Integer T=0;
             T = [select count() from My_Products__c where name=:selectedProductName];
             while(i<T)
             {  
             tabstatus.add(true);
             i++;
             }
             T=0;
         return tabstatus;
        
       }


    
   // Account acc = new Account();
     public myController(ApexPages.StandardController controller)
    {
                // Added by Stan
        accId= system.currentPagereference().getParameters().get('id');
    }
        
    public Account getacc() {   
         if(acc== null)        
              acc = new Account();    
                  return acc; 
                  
                     }
    public myController() {

    }
    

    /********************************************************************************
    * Method    : getProducts
     *********************************************************************************/   
    public List<SelectOption> getProducts()
    {    
         List<selectOption> options = new List<selectOption>();
         options.clear();
         options.add(new SelectOption('', '-select-')); 
         for(My_Products__c prod : [Select o.Name  From My_Products__c o])
         {              
                options.add(new selectOption(prod.Id, prod.Name));
         } 
            
        return options;
    }



/********************************************************************************
    * Method    : getOfferingList
    *********************************************************************************/   
    public List<SelectOption> getOfferingList()
    {
           List<selectOption> options = new List<selectOption>();
            options.clear();
            options.add(new SelectOption('','-none-'));
            
            for(My_Offers__c offList : [Select o.Name, o.My_Products__r.Name, o.My_Products__c 
                                        From My_Offers__c o
                                        where o.My_Products__r.Name =: selectedProductName
                                        ])
            {
                options.add(new selectOption(offList.Id, offList.Name));
            }
            
           return options;
    }
    /*public List<SelectOption> getService()
{
  List<SelectOption> opt = new List<SelectOption>();
 opt.clear();

 // List<My_services__c> citylist = new List<My_services__c>();
   opt.add(new SelectOption('',''));
for (My_services__c serv : [Select s.Name, s.My_Offers__r.Name, s.My_Offers__c 
                                        From My_services__c s
                                        where s.My_Offers__r.Name =: selectedservicetype
                                        ])
  {
      opt.add(new SelectOption(serv.Id, serv.Name));
  }
  return opt;
}*/
       public pageReference productChange()
    {
 selectedProductName = [Select Name From My_Products__c where Id =: product].Name;
 disp=true;
        return null;
    }
 
}