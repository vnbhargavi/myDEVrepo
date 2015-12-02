public class SendOutbound {

	public string x{get;set;} 
    public SendOutbound() {}
	public SendOutbound(ApexPages.StandardController controller) {}
	      
	public static void  sendreq()
	{  
	  String VName ;
      String TOMID ;   
      String Creditcard;
      String Numberoflocations;
      String rawResponse; 
      String err ;
      String result='';
      String transid;
      String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
      String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
      String serviceNS = 'http://www.myservice.com/services/MyService/';
     
      List<Contact> contact = new List<Contact>();
	  List<Case> opp = new list<Case>();
	  List<Order__c> order=  new List<Order__c>();
	  List<Account> acc1=[Select a.id,a.Name,a.Credit_Checked_Date__c,a.Credit_check_Expiry_Date__c,a.CustomerPriority__c,a.Districting_Status__c,a.TOMID__c from Account a];
                       
      //Creating child elemts using DOM class
      DOM.Document doc = new DOM.Document();
      dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
      envelope.setNamespace('xsi', xsi);
      envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
      dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
      body.addChildElement('echo', serviceNS, 'req').addChildElement('Name', VName, null).addTextNode('abc');
      body.addChildElement('TOMIDno', TOMID, null).addTextNode('123');
      body.addChildElement('CardType', Creditcard, null).addTextNode('Visa');
      System.debug(doc.toXmlString());   
      
      //Http Request 
	  Http h = new Http();
	  HttpRequest req = new HttpRequest();
	  string url = 'www.google.com';
	  string uname = 'bhargavi.vadlamani@gmail.com';
	  string pwd = 'xxxxxxxxxx';
  
	  /*String sendRequest;
	  sendRequest =  '<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:enterprise.soap.sforce.com\">';
	  sendRequest += '<soap:Header>';
	  sendRequest += '<Username>' + uname + '</Username><Password>' + pwd;
	  sendRequest += '</Password>';
	  sendRequest += '</soap:Header><soap:Body>';
	  sendRequest += '<Account><Name>' + Name + ' '+ '</Name><Identity>' + TOMID + '</Identity>';
	  sendRequest += '<CreditCard><CreditCardType>' + Creditcard + '</CreditCardType></CreditCard></Account>';
	  sendRequest += '</soap:Body></soap:Envelope>';*/
   	  
   	  req.setBodyDocument(doc); 
	//req.setBody(sendRequest);
	  req.setEndpoint(url);
	  req.setMethod('POST');
	  req.setHeader('Content-length', '1753' );
	  req.setHeader('Content-Type', 'text/xml;charset=UTF-8'); 
	  req.setHeader('SOAPAction','');
	  req.setHeader('Host','api-aa.sandbox.paypal.com');
     
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
	  //return result;
	}

    public static PageReference calloutbound()
	{
	sendreq();
	return null;
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
	
	public static string getMonth(String Month)
	{
	  String months ;
      String Years ; 
      String rawResponse; 
      String err ;
      String result='';
      String transid;
      String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
      String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
      String serviceNS = 'http://www.myservice.com/services/MyService/';
      
      DOM.Document doc = new DOM.Document();
      dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
      envelope.setNamespace('xsi', xsi);
      envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
      dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
      body.addChildElement('echo', serviceNS, 'req').addChildElement('Month', months, null).addTextNode('Month');
      System.debug(doc.toXmlString());  
      return month; 
      
	}
}