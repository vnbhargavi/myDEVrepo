public with sharing class oeController {

    public oeController(ApexPages.StandardSetController controller) {

    }
    
    Boolean disp3=false;
    Public Boolean getdisp3()
    {
    return disp3;
    }  

       Account acc;
    public String product {get;set;}
       public String product1 {get;set;}
   public String offer {get;set;}
    public String selectedOfferingId {get;set;}
    public String selectedservice{
    get;
    set;
    }
    public List<Boolean> tabstatus = new List<Boolean>();
    public String selectedProductName;
    Id accId;
    public string selectedservName;
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
             T = [select count() from My_Offers__c];
             while(i<T)
             {  
             tabstatus.add(true);
             i++;
             }
             T=0;
         return tabstatus;
        
       }
       
   // Account acc = new Account();
     public oeController(ApexPages.StandardController controller)
    {
                // Added by Stan
     
    }
        
    public Account getacc() {   
         if(acc== null)        
              acc = new Account();    
                  return acc; 
                  
                     }
    public oeController() {

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
             options.add(new SelectOption('', '-select-'));        
            for(My_Offers__c offList : [Select o.Name, o.My_Products__r.Name, o.My_Products__c 
                                        From My_Offers__c o
                                        where o.My_Products__r.Name =: selectedProductName
                                        ])
            {
                options.add(new selectOption(offList.Id, offList.Name));
            }
            
           return options;
    }
public List<SelectOption> getsuboffer()
    {
           List<SelectOption> options = new List<SelectOption>();
            options.clear();
           // options.add(new SelectOption('',''));
            
            for(OM_OfferServices__c offList1 : [Select o1.Name,o1.OM_SubOfferings__r.Name, o1.OM_SubOfferings__c 
                                        From OM_OfferServices__c o1
             ])
            {
                options.add(new SelectOption(offList1.Id, offList1.Name));
            }
            
           return options;
    }
 public List<OM_SubOfferings__c> myofr {
 get {
if (myofr == null) {

myofr = [SELECT Name FROM OM_SubOfferings__c  where My_Offers__c =: selectedservName ];
}
return myofr ;

}
set;
}
public List<OM_SubOfferings__c> myofr2 {
 get {
if (myofr2 == null) {

myofr2 = [SELECT o.Name,o.My_Offers__r.Name FROM OM_SubOfferings__c o ];
}
return myofr2;

}
set;
}     

   public List<My_Offers__c> myofr1 {
 get {
if (myofr1 == null) {

myofr1 = [SELECT Name FROM My_Offers__c];
}
return myofr1;

}
set;
}   
  
public PageReference productchange(){

selectedProductName = [Select Name From My_Products__c where Id =: product].Name;

 disp=true;
        return null;
    }
public PageReference servchange(){
 selectedservName = [Select Name From My_Offers__c where Id =: offer].Name;

 disp3=true;
        return null;
    }
    
    }