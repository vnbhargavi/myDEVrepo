public class testupdate
{
public void testing()
{
List<Account> acc= [Select id,Name,TOMID__c from Account];
    List<Order__c> ord1 = [Select Name,TOMID__c,Status__c from Order__c];
    
    for(Account acnt:acc)
    {
    for(Order__c ord:ord1)
    {
    if(acnt.TOMID__c == ord.TOMID__c)
    ord.Status__c='Inprogress';
    }
        }
   update ord1;
  }
}