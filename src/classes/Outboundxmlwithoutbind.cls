global class Outboundxmlwithoutbind
{
	  public string pid{get; set;}
	  public string tmid{get;set;}
      public Outboundxmlwithoutbind() {}
      
	public Outboundxmlwithoutbind(ApexPages.StandardController controller) {}
	   /*global Outboundxmlwithoutbind(){
	     VName='';
	     TOMID='';
	     Creditcard='Visa';
	     Numberoflocations='';
	      
	    } */      
	public static void sendreq()
	{  
      String VName;
      String TOMID; 
      String Creditcard;
      String Numberoflocations;
      String rawResponse; 
      String err;
      String result='';
      String transid;
      String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
      String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
      String serviceNS = 'http://www.myservice.com/services/MyService/';
     
     //Creating child elemts using DOM class
      DOM.Document doc = new DOM.Document();
      dom.XmlNode envelope = doc.createRootElement('Envelope\n', soapNS, 'soapenv');
      envelope.setNamespace('xsi\n', xsi);
      envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
      dom.XmlNode body = envelope.addChildElement('Body\n', soapNS, null);
      body.addChildElement('Name\n', VName, null).addTextNode('abc');
      body.addChildElement('TOMIDno\n', TOMID, null).addTextNode('123');
      body.addChildElement('CardType\n', Creditcard, null).addTextNode('Visa');
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
	  sendRequest += '<Account><Name>' + VName + ' '+ '</Name><Identity>' + TOMID + '</Identity>';
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
	 // return result;
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
}