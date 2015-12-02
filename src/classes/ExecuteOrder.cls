global class ExecuteOrder
{
	public static void  ExecutionStatusNotificationMeddelande()
	{
	
	String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
	String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
	String serviceNS = 'http://www.myservice.com/services/MyService/';	
	string url = 'www.google.com';
	//DOM class
	DOM.Document doc = new DOM.Document(); 
	dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
  	envelope.setNamespace('xsi', xsi);
  	envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
  	dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
  	
  	//Extensions Elemnts
     dom.XmlNode Extension_ES_tss_fns = body.addChildElement('Extension_ES_tss_fns',xsi,null);
     Extension_ES_tss_fns.addChildElement('ObjectElements',xsi,null).addChildElement('Object',xsi,null).addChildElement('ObjectID',xsi,null);
    
     dom.XmlNode SupplierParty = body.addChildElement('SupplierParty',xsi,null).addChildElement('Contact',xsi,null).addChildElement('Role',xsi,null).addTextNode('"Accomplisher"');
     
     dom.XmlNode IssuedDateTime = body.addChildElement('IssuedDateTime',xsi,null);
     
     dom.XmlNode Status = body.addChildElement('Status',xsi,null).addTextNode('"Meddelande"');
     
     dom.XmlNode OrderRef = body.addChildElement('OrderRef',xsi,null);
     OrderRef.addChildElement('Role',xsi,null).addTextNode('"Buyer"');
     OrderRef.addChildElement('Role',xsi,null).addTextNode('"Supplier"');
     
     dom.XmlNode Note = body.addChildElement('Note',xsi,null);
     
     System.debug('ExecutionStatusNotification(1), Meddelande  is.....'+doc.toXmlString()); 
        
        HttpRequest request = new HttpRequest();
		request.setMethod('POST');
		request.setEndpoint(url);
		request.setHeader('Content-Type', 'text/xml');
		request.setBodyDocument(doc);
		Http http = new Http();
		//HttpResponse response = http.send(request);
	  	
	  	//system.debug(' HTTP response for ExecutionStatusNotification(1), Meddelande  ---------- '+response);
     
     }
     
     public static void  OrderExecuted()
	{
	String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
	String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
	String serviceNS = 'http://www.myservice.com/services/MyService/';
	string url = 'www.google.com';	
	//DOM class
	DOM.Document doc = new DOM.Document(); 
	dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
  	envelope.setNamespace('xsi', xsi);
  	envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
  	dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
  	
  	//Extensions Elemnts
     dom.XmlNode Extension_ES_tss_fns = body.addChildElement('Extension_ES_tss_fns',xsi,null);
     
     Extension_ES_tss_fns.addChildElement('ObjectElements',xsi,null).addChildElement('Object',xsi,null).addChildElement('ObjectID',xsi,null);
    
     dom.XmlNode SupplierParty = body.addChildElement('SupplierParty',xsi,null).addChildElement('Contact',xsi,null).addChildElement('Role',xsi,null).addTextNode('"Billingliable"');
     
     dom.XmlNode IssuedDateTime = body.addChildElement('IssuedDateTime',xsi,null);
     
     dom.XmlNode Status = body.addChildElement('Status',xsi,null).addTextNode('"ÅtagandeKlart"');

     dom.XmlNode StatusChangeDateTime = body.addChildElement('StatusChangeDateTime',xsi,null);
     
     dom.XmlNode OrderRef = body.addChildElement('OrderRef',xsi,null);
     OrderRef.addChildElement('Role',xsi,null).addTextNode('"Buyer"');
     OrderRef.addChildElement('Role',xsi,null).addTextNode('"Supplier"');
     
     dom.XmlNode OrderLineStatus = body.addChildElement('OrderLineStatus',xsi,null);
     OrderLineStatus.addTextNode('123');
     
     dom.XmlNode OrderLineStatus1 = body.addChildElement('OrderLineStatus',xsi,null);
     OrderLineStatus1.addChildElement('ProductUseCaseDetails',xsi,null).addChildElement('Id',xsi,null).addTextNode('abc123');
     
     dom.XmlNode OrderLineStatus2 = body.addChildElement('OrderLineStatus',xsi,null);
     OrderLineStatus2.addChildElement('ProductUseCaseDetails',xsi,null);
     
     dom.XmlNode Extension_puc_ES_tss_fns = body.addChildElement('Extension_puc_ES_tss_fns',xsi,null);
     Extension_puc_ES_tss_fns.addChildElement('Unit',xsi,null).addTextNOde('"N"');
     
     dom.XmlNode OrderLineStatus3 = body.addChildElement('OrderLineStatus',xsi,null).addChildElement('ProductUseCaseDetails',xsi,null);
     
     dom.XmlNode Extension_puc_ES_tss_fns1 = body.addChildElement('Extension_puc_ES_tss_fns',xsi,null);
     Extension_puc_ES_tss_fns1.addChildElement('Quantity',xsi,null); 
     
     dom.XmlNode OrderLineStatus4 = body.addChildElement('OrderLineStatus',xsi,null).addChildElement('ProductUseCaseDetails',xsi,null);
     
     dom.XmlNode Extension_puc_ES_tss_fns11 = body.addChildElement('Extension_puc_ES_tss_fns',xsi,null);
     Extension_puc_ES_tss_fns11.addChildElement('Type',xsi,null).addTextNOde('"S"');
     
     dom.XmlNode OrderLineStatus5 = body.addChildElement('OrderLineStatus',xsi,null).addChildElement('ProductUseCaseDetails',xsi,null);
     
     dom.XmlNode Extension_puc_ES_tss_fns2 = body.addChildElement('Extension_puc_ES_tss_fns',xsi,null);
     Extension_puc_ES_tss_fns2.addChildElement('Currency',xsi,null).addTextNOde('"SEK"');
     
     dom.XmlNode OrderLineStatus6 = body.addChildElement('OrderLineStatus',xsi,null).addChildElement('ProductUseCaseDetails',xsi,null);
     
     dom.XmlNode Extension_puc_ES_tss_fns3 = body.addChildElement('Extension_puc_ES_tss_fns',xsi,null);
     
     dom.XmlNode ReadyNotification = body.addChildElement('ReadyNotification',xsi,null);
     ReadyNotification.addChildElement('SequenceNumber',xsi,null).addTextNode('"1"');
     
     dom.XmlNode OrderLineStatus7 = body.addChildElement('OrderLineStatus',xsi,null).addChildElement('ProductUseCaseDetails',xsi,null);
     
     dom.XmlNode Extension_puc_ES_tss_fns4 = body.addChildElement('Extension_puc_ES_tss_fns',xsi,null);
     
     dom.XmlNode ReadyNotification1 = body.addChildElement('ReadyNotification',xsi,null);
     ReadyNotification1.addChildElement('Note',xsi,null);
     
     System.debug('OrderExecuted  is.....'+doc.toXmlString()); 
     
     HttpRequest request = new HttpRequest();
		request.setMethod('POST');
		request.setEndpoint(url);
		request.setHeader('Content-Type', 'text/xml');
		request.setBodyDocument(doc);
		Http http = new Http();
		//HttpResponse response = http.send(request);

	  	//system.debug(' HTTP response for OrderExecuted   ---------- '+response);
     
     
     }
  }