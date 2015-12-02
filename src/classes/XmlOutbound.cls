public class XmlOutbound
{
public void sendmessage()
{
List<Account> account = [Select id ,Name ,TOMID__c from Account];

List<Order__c> order = [Select id,Name,TOMID__c,Status__c,Account__c from Order__c];
for(Account acc:account)
{
for(Order__c ord:order)
{
if(acc.TOMID__c==ord.TOMID__c)
ord.Status__c='Submitted';
}
}
update order;
}

}