global class listxml {

	  public string pid{get; set;}
	  public string tmid{get;set;}
      public listxml() {
    }
	public listxml(ApexPages.StandardController controller) {}
	
	public List<Account> sendreq()
	{  
	  String VName ;
      String TOMID ; 
      String Creditcard;
      String Product;
      String Numberoflocations;
      String rawResponse; 
      String err ;
      String result='';
      String transid;
      String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
      String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
      String serviceNS = 'http://www.myservice.com/services/MyService/';
      
      List<Account> acc = [Select Name,TOMID__c,Credit_Check_Status__c,TickerSymbol,Districting_Status__c,Geocoding_Status__c,Cong_District__c,Latitude__c from Account];
      List<Contact> cntct= [Select Name,Languages__c,Voter_Leg_District__c,State_Senate__c,Department from Contact];
      List<Case> cse = [Select Case.AccountId,EngineeringReqNumber__c,Subject,PotentialLiability__c  from Case ];
      List<Order__c> ord = [Select Status__c,TOMID__c from Order__c];
    
      for(Account acnt: acc)
      {
      DOM.Document doc = new DOM.Document();		 
      dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
      envelope.setNamespace('xsi', xsi);
      envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
      dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
      body.addChildElement('echo', serviceNS, 'req').addChildElement('Name', VName, null).addTextNode('abc');
      body.addChildElement('TOMIDno', TOMID, null).addTextNode('ncsdjkfnks');
      body.addChildElement('TOMIDno', acnt.Name, null).getText();
      body.addChildElement('CardType', Creditcard, null).addTextNode('Visa');
      System.debug(doc.toXmlString());   
      }
      for(Case cas:cse)
      //Http Request 
      {
      DOM.Document doc = new DOM.Document();		 
      dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
      envelope.setNamespace('xsi', xsi);
      envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
      dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
      body.addChildElement('echo', serviceNS, 'req').addChildElement('Name', VName, null).addTextNode('Case');
      body.addChildElement('TOMIDno', TOMID, null).addTextNode('214jldk');
      body.addChildElement('TOMIDno', cas.AccountId, null).getText();
      body.addChildElement('Product', Product, null).addTextNode('SFDC');
      System.debug(doc.toXmlString());   
      }
	  Http h = new Http();
	  HttpRequest req = new HttpRequest();
	  string url = 'www.google.com';
	  string uname = 'bhargavi.vadlamani@gmail.com';
	  string pwd = 'xxxxxxxxxx';
     
      req.setEndpoint(url);
   	  //req.setBodyDocument(doc); 
	  //req.setBody(sendRequest);
	  
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
	  
	  XmlStreamReader reader = res.getXmlStreamReader();
	  result = readXMLResponse(reader,'Ack');
	  reader = res.getXmlStreamReader();
	  err = readXMLResponse(reader, 'LongMessage');
	  system.debug('rawResponse'+rawResponse);
	  
	  if (result == 'Success')
	  {
	    reader = res.getXmlStreamReader();
	    transid = readXMLResponse(reader, 'TransactionID'); 
	    system.debug(':::'+transid);
	      }
	  else
	  {
	    result = err;
	  }
	  return acc;
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