trigger xmlmessage on Account (before delete) 
{
List<Account> accnt= new list<Account>();
for(Account a :trigger.Old)
	{
	accnt.add(a);
	}
 system.debug('account '+accnt);
	 Deletedrecord.delrec(accnt);
}