public class cloneOpptyCls{

public Opportunity opptyObj{get;set;}
public id accountId{get;set;}

public cloneOpptyCls()
{



}
public void addselected(){


}
public pagereference cloneOpty(){

opptyObj  = [select id,Accountid,OrderNumber__c from opportunity where id =: ApexPages.currentPage().getParameters().get('id')];
opportunity newOptyObj = new opportunity();
newoptyObj = opptyObj.clone(false,true);
newOptyObj.Accountid = opptyObj.Accountid;
insert newOptyObj;

return null;
} 
}