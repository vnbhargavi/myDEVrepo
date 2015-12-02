global class BatchOutboundMessage implements Database.Batchable<sObject>,Database.AllowsCallouts
 {
  	public String Query; 
  	
     global Database.QueryLocator start(Database.BatchableContext BC)
     {
       if ((query==null) || (query=='')) 
           query='Select  Id, LastModifiedDate,(Select id,LastModifiedDate From Contacts), (Select  id,LastModifiedDate From Cases) From Account where LastModifiedDate < LAST_N_DAYS:2';
            return Database.getQueryLocator(query);
     }
     global void execute(Database.BatchableContext BC, List<sobject> scope) 
     {
           sendXMLMessage.sendmsg();
     }
     global void finish(Database.BatchableContext BC)
     {
      	AsyncApexJob a = [Select Id, Status, NumberOfErrors,JobItemsProcessed,TotalJobItems,CreatedBy.Email from AsyncApexJob where Id =:BC.getJobId()];
		// Send an email to the Apex job's submitter notifying of job completion.
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddresses = new String[] {a.CreatedBy.Email};
		mail.setToAddresses(toAddresses);
		mail.setSubject('Apex Sharing Recalculation ' + a.Status);
		mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +' batches with '+ a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
     }
 
}