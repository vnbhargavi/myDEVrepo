public class EmailAttachment {
    
    public static Lead sendAttachments(lead leadObj){
		
		Integer attachmntCount = [SELECT count() FROM Attachment WHERE Parentid IN (Select Id from Lead where id = :leadObj.id)];
        LeadObj.NumberOfEmployees = attachmntCount;
		return leadObj;
	}

}