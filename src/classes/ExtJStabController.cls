public class ExtJStabController {

    public ExtJStabController(ApexPages.StandardSetController controller) {

    }public String selectedProductName;
      public String offer1 {get;set;}
    public String selectedoffertype;
    public String product1 {get;set;}
 
 ApexPages.StandardController controller;

Boolean disp2=false;
    Public Boolean getdisp2()
    {
    return disp2;
    }  
    


 
public List<OM_SubOfferings__c> myofr {
get {
if (myofr == null) {

myofr = [SELECT Name,id FROM OM_SubOfferings__c];
}
return myofr;

}
set;
}
 public pageReference productChange()
    {
selectedoffertype=[select o.name,o.My_Offers__r.name,o.id from OM_SubOfferings__c o where id=:offer1].Name;

 disp2=true;
        return null;
    }
    }