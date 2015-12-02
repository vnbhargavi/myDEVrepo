public with sharing class sendXMLMessage 
{
	 public static string sendmsg() 
	 {
		String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
		String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
		String serviceNS = 'http://www.myservice.com/services/MyService/';
		String rawResponse;
		string url = 'www.google.com';
		string uname = 'bhargavi.vadlamani@gmail.com';
		string pwd = 'xxxxxxxxxx';
		string reqs='';
		Integer ind=0;
		Integer contindex=0;
		Integer ordindex=0;
		Integer index=0;
		
		list<Account> acc= [Select id,Name,TOMID__c,Districting_Status__c,SLASerialNumber__c,Credit_Check_Status__c from Account];
		list<Case> cse= [Select CaseNumber,Status,Priority from  case];
		list<Contact> conc=[Select Name,Title,Phone,Email from Contact];
		list<Order__c> ord= [Select Name,TOMID__c,Status__c from Order__c];
		
		Integer batchSize =5;
		Integer  listSize = math.max(acc.size(),cse.size());
		Integer maxlist =math.max(listSize,conc.size());
		Decimal acccsize = ((Decimal)maxlist)/batchSize; 	
		//Decimal csesize = ((Decimal)cse.size())/batchSize; 	
		//Decimal consize = ((Decimal)conc.size())/batchSize; 	
		//Decimal ordsize = ((Decimal)ord.size())/batchSize; 	
		system.debug(acccsize);

	 	    for(Integer a=0;a<(((maxlist)/batchSize)+(math.mod(maxlist,batchSize)));++a)
	 	    {
 	    	DOM.Document doc = new DOM.Document();
			dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
		  	envelope.setNamespace('xsi', xsi);
		  	envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
		  	dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
			  	
		   	for(Integer j=0;j<batchSize && index <acc.size();++j)
 	      	{
 	      	dom.XmlNode accountList = body.addChildElement('accountList',xsi,null);
		    dom.XmlNode AccountName = accountList.addChildElement('Name', xsi, null).addTextNode(acc.get(index).Name);
		   	accountList.addChildElement('Id', xsi, null).addTextNode(acc.get(index).Id);
		   	if(String.valueof(acc.get(index).TOMID__c)!=null)
		   	accountList.addChildElement('TOMID', xsi, null).addTextNode(String.Valueof(acc.get(index).TOMID__c));
 	      	index ++;
 	      	}
 	      		
	      	for(Integer i=0;i<batchSize && ind <cse.size();++i)
	      	{
	       	dom.XmlNode caseList = body.addChildElement('caselist',xsi,null);
	      	dom.XmlNode CaseName = caseList.addChildElement('CaseNumber', xsi, null).addTextNode(cse.get(ind).CaseNumber);
	      	caseList.addChildElement('Status', xsi, null).addTextNode(cse.get(ind).Status);
	      	caseList.addChildElement('Priority', xsi, null).addTextNode(cse.get(ind).Priority);
	      	ind ++;
	      	}
	      		      	
 	      	for(Integer l=0;l<batchSize && contindex <conc.size();++l)
			{
			dom.XmlNode contactList = body.addChildElement('ContactList',xsi,null);
			contactList.addChildElement('ContactName', xsi, null).addTextNode(conc.get(contindex).Name);
			if(conc.get(contindex).Title!=null)
			contactList.addChildElement('Title', xsi, null).addTextNode(conc.get(contindex).Title);
			if(conc.get(contindex).Phone!=null)
			contactList.addChildElement('Phone', xsi, null).addTextNode(conc.get(contindex).Phone);
			if(conc.get(contindex).Email!=null)
			contactList.addChildElement('Email\t\t', xsi, null).addTextNode(conc.get(contindex).Email);
			contindex++;
			}
			reqs = reqs+ doc.toXmlString();
       	}
		    System.debug(' Request msg  '+reqs);
	     
	     	 //Http Request 
		     Http h = new Http();
			 HttpRequest req = new HttpRequest();
			 //req.setBodyDocument(doc); 
			 req.setEndpoint(url);
			 req.setMethod('POST');
			 req.setHeader('Content-length', '1753' );
			 req.setHeader('Content-Type', 'text/xml;charset=UTF-8'); 
			 req.setHeader('SOAPAction','');
			 req.setHeader('Host','api-aa.sandbox.paypal.com');
		     system.debug('request msg.............................'+req);  
		    
		    //Http Response 
			 HttpResponse res = h.send(req);
			 String xml = res.getBody();
			 rawResponse = xml;
			 system.debug('::' + rawResponse);
			 return rawResponse;
	}
}