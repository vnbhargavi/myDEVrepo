public with sharing class mytest {
  
	  public Account account{get;set;}
	  public Account acc;
	  public mytest()
	  {
	  		account = new Account();
      }
   /* public static List<String> getSobjectFields() 
       {
            List<String> fields = new List<String>();
            Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
            Schema.SObjectType sobjType = gd.get('account');
            Schema.DescribeSObjectResult r = sobjType.getDescribe();
            Map<String,Schema.SObjectField> M = r.fields.getMap();
            
            for(String fieldName : M.keyset())
                {
                    Schema.SObjectField field = M.get(fieldName);                                                    
                    Schema.DescribeFieldResult fieldDesc = field.getDescribe();
                    fields.add(fieldName.toLowerCase());
                }
            return fields;
       } */
       
      public static outboundxmldata.OMLData getXml(outboundxmldata.OMLData oom,Account account)
      { 
      	
      	list<Account> acc = new list<Account>();
      	
      	      String VName= account.Name ;
		      //String TOMID = account.TOMID__c; 
		      String Creditcard=account.Credit_Check_Status__c;
		      String Districtstatus= account.Districting_Status__c;
		      String Numberoflocations;
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
		      body.addChildElement('echo', serviceNS, 'req');
		      body.addChildElement('Name', VName, null).getText();
		      //body.addChildElement('TOMIDno', TOMID, null).getText();
		      body.addChildElement('CardType', Creditcard, null).getText();
		      System.debug(doc.toXmlString());      
		      
		      Http h = new Http();
			  HttpRequest req = new HttpRequest();
			  string url = 'www.google.com';
			  string uname = 'bhargavi.vadlamani@gmail.com';
			  string pwd = 'xxxxxxxxxx'; 
		      
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
			  return oom;
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