public with sharing class AttachmentXML 
{
	//public static void sendRequest(list<Account> r_lstAccounts,String endpntUrl,String timeout,string strbody)
   public static void sendRequest(blob attchghfgbody)
    {
    	String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
		String xsi = 'http://www.myservice.com/services/MyService/';
		//String endpntUrl = 'https://teliasonera.com.se';
		//String timeout = '10';
		Integer batchSize = 1;
		Integer listSize;
		String req1 = ''; 
		Integer index = 0;
		string endpntUrl='xyz';
		string timeout='abc'; 
		string result; 
		string rawresponse;
		string err;
		string url='www.google.com';
		 list<Account> lstAccounts = [Select id,Name,TOMID__c from Account ];
		 listSize = lstAccounts.size();
		 system.debug('listSize ----------- '+listSize);
	
		 Account acc=[select id ,name from Account limit 1];
		 //Attachment  Query
		 Attachment attchd=[Select Body,Id,ParentId,ContentType from Attachment where ParentId=:acc.id limit 1];
		 blob attachdblb=attchd.Body;
		 string strbody=attachdblb.tostring();
	   	for(Integer i=0;i<listSize/batchSize; ++i)
		{
		DOM.Document doc = new DOM.Document();
		dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
		envelope.setNamespace('xsi', xsi);
		//Header
		dom.XmlNode configData = envelope.addChildElement('_configData', soapNS, null);
		dom.XmlNode endpointURL = configData.addChildElement('endpointURL', xsi, null).addTextNode(endpntUrl);
		dom.XmlNode tout = configData.addChildElement('timeout', xsi, null).addTextNode(timeout);
		dom.XmlNode attchmnt = configData.addChildElement('attchent', xsi, null).addTextNode(strbody);    
		
		//Body
		dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
		
		    for(Integer j=0;j<batchSize;j++){
			dom.XmlNode accountList = body.addChildElement('accountList',xsi,null);
			dom.XmlNode AccountName = accountList.addChildElement('Name', xsi, null).addTextNode(lstAccounts.get(index).Name);
			dom.XmlNode Id = accountList.addChildElement('Id', xsi, null).addTextNode(lstAccounts.get(index).Id);
	
	//if(lstAccounts.get(index).TOMID__c!=null)
		//dom.XmlNode TOMID = accountList.addChildElement('TOM ID', xsi, null).addTextNode(lstAccounts.get(index).TOMID__c);
		
		index ++;
		}
		req1 = req1 + doc.toXmlString();
   }
		system.debug('req----------------'+req1);
	
		Http h = new Http();
	    HttpRequest req = new HttpRequest();	
	    //req.setBodyDocument(doc); 
	  req.setBody(req1);
	  req.setEndpoint(url);
	  req.setMethod('POST');
	  req.setHeader('Content-length', '1753' );
	  req.setHeader('Content-Type', 'text/xml;charset=UTF-8'); 
	  req.setHeader('SOAPAction','');
	  req.setHeader('Host','api-aa.sandbox.paypal.com');
	  
	  HttpResponse res = h.send(req);
	  String xml = res.getBody();
	  rawResponse = xml;
	  system.debug('::' + rawResponse);
	  
	  XmlStreamReader reader = res.getXmlStreamReader();
	  result = readXMLResponse(reader,'Ack');
	  reader = res.getXmlStreamReader();
	  err = readXMLResponse(reader, 'LongMessage');
	  system.debug('rawResponse'+rawResponse);
	  
	  if (result == 'Success')
	  {
	    reader = res.getXmlStreamReader();
	     string transid = readXMLResponse(reader, 'TransactionID'); 
	    system.debug(':::'+transid);
	      }
	  else
	  {
	    result = err;
	  }
	  //return result;
	}
	
	public  static String readXMLResponse(XmlStreamReader reader, String sxmltag)
	{
	  string retValue; 
	  // Read through the XML
	  while(reader.hasNext())
	  {
	    if (reader.getEventType() == XmlTag.START_ELEMENT)
	    {
	      if (reader.getLocalName() == sxmltag) {
	        reader.next();
	        if (reader.getEventType() == XmlTag.characters)
	        {
	          retValue = reader.getText();
	        }
	      }
	    }
	    reader.next();
	  }
	  return retValue;
	}
		
 }