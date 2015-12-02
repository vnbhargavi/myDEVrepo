global class ReNegotiateOrderBuyer
{
	public static void DialogCancellationByResponder()
	{
		String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
		String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
		String serviceNS = 'http://www.myservice.com/services/MyService/';
		String rawResponse;
		string url = 'www.google.com';
		string uname = 'bhargavi.vadlamani@gmail.com';
		string pwd = 'xxxxxxxxxx';
		string reqs='';
		
		DOM.Document doc = new DOM.Document(); 
		dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
	  	envelope.setNamespace('xsi', xsi);
	  	envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
	  	dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
	  	//child Elements
	  	dom.XmlNode BusinessObjectRef = body.addChildElement('BusinessObjectRef',xsi,null);
	    BusinessObjectRef.addChildElement('Role',xsi,null).addTextNode('Buyer');
	    
	   	body.addChildElement('IssueDateTime',xsi,null);
	    
	    BusinessObjectRef.addChildElement('Role',xsi,null).addTextNode('supplier');
	  	dom.XmlNode Reason = body.addChildElement('Reason',xsi,null);
	  	
	  	Reason.addChildElement('Name',xsi,null).addTextNode('Reason');
	  	
	  	Reason.addChildElement('Description',xsi,null).addTextNode('xyz');
	  	//XMl String Proccessed
	  	System.debug('DialogCancellationByResponder is.....'+doc.toXmlString()); 
	  	
	  	HttpRequest request = new HttpRequest();
		request.setMethod('POST');
		request.setEndpoint(url);
		request.setHeader('Content-Type', 'text/xml');
		request.setBodyDocument(doc);
		Http http = new Http();
		//HttpResponse response = http.send(request);
	  	
	  	//system.debug(' Httpresponse for DialogCancellationByResponder  ---------- '+response);
	}
	
	   public static void OrderUpdateAcknowledgmentByResponder()
	   {
		String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
		String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
		String serviceNS = 'http://www.myservice.com/services/MyService/';
		String rawResponse;
		string url = 'www.google.com';
		string uname = 'bhargavi.vadlamani@gmail.com';
		string pwd = 'xxxxxxxxxx';
		string reqs='';
		
		DOM.Document doc = new DOM.Document(); 
		dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
	  	envelope.setNamespace('xsi', xsi);
	  	envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
	  	dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
	  	//child Elements
	  	  	
	  	body.addChildElement('IssueDateTime',xsi,null);
	  	dom.XmlNode OrderRef = body.addChildElement('OrderRef',xsi,null);
	  	OrderRef.addChildElement('Role',xsi,null).addTextNode('Buyer');
	  	OrderRef.addChildElement('Role',xsi,null).addTextNode('supplier');
	  	System.debug('OrderUpdateAcknowledgmentByResponder is.....'+doc.toXmlString()); 
	  	
	  	HttpRequest request = new HttpRequest();
		request.setMethod('POST');
		request.setEndpoint(url);
		request.setHeader('Content-Type', 'text/xml');
		request.setBodyDocument(doc);
		Http http = new Http();
		//HttpResponse response = http.send(request);
	  
	   	//system.debug(' HTTP response for OrderUpdateAcknowledgmentByResponder  ---------- '+response);
	  
	}
	
	public static void OrderUpdateRequestByInitiator()
	{
		String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
		String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
		String serviceNS = 'http://www.myservice.com/services/MyService/';
		String rawResponse;
		string url = 'www.google.com';
		string uname = 'bhargavi.vadlamani@gmail.com';
		string pwd = 'xxxxxxxxxx';
		string reqs='';
		
		// Creating DOM class
		DOM.Document doc = new DOM.Document(); 
		dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
	  	envelope.setNamespace('xsi', xsi);
	  	envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
	  	dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
	  	
	  	              /*********Child Elements**********************/
	  	//OrderBody
	  	dom.XmlNode OrderBody = body.addChildElement('OrderBody',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('ShipToParty',xsi,null).addChildElement('Reference',xsi,null).addChildElement('Name',xsi,null).addTextNode('BestUnderlagId');
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('ShipToParty',xsi,null).addChildElement('Reference',xsi,null).addChildElement('Value',xsi,null);
	  	OrderBody.addChildElement('BusinessAgreementRef',xsi,null).addChildElement('Role',xsi,null).addTextNode('"Buyer"');
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('ShipToParty',xsi,null).addChildElement('Reference',xsi,null).addChildElement('Name',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('ShipToParty',xsi,null).addChildElement('Contact',xsi,null).addChildElement('Name',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('ShipToParty',xsi,null).addChildElement('Contact',xsi,null).addChildElement('Role',xsi,null).addTextNode('"Notifier"');
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('ShipToParty',xsi,null).addChildElement('Contact',xsi,null).addChildElement('Email',xsi,null);
	  	//Notes
	  	dom.XmlNode Notes = body.addChildElement('Note',xsi,null);
	  	
	  	//Order Body Child Elemnts
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ES_tss_fns',xsi,null).addChildElement('ObjectElements',xsi,null).addChildElement('Object',xsi,null).addChildElement('ObjectType',xsi,null).addChildElement('Domain',xsi,null).addTextNode('"mainProductActivityCode"');
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ES_tss_fns',xsi,null).addChildElement('ObjectElements',xsi,null).addChildElement('Object',xsi,null).addChildElement('ObjectType',xsi,null).addChildElement('TypeId',xsi,null);
	  	
	  	//BuyerParty Node
	  	dom.XmlNode BuyerParty = body.addChildElement('BuyerParty',xsi,null).addChildElement('Contact',xsi,null).addChildElement('Name',xsi,null);
	  	BuyerParty.addChildElement('Contact',xsi,null).addChildElement('Telephone',xsi,null).addChildElement('Type',xsi,null).addTextNode('"Office"');
	    BuyerParty.addChildElement('Type',xsi,null).addTextNode('"Other"');
	  	BuyerParty.addChildElement('Type',xsi,null).addTextNode('"Mobile"');
	  	
	  	// Order BOdy Child Elements
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ds_O_tss_fns',xsi,null).addChildElement('ObjectElements',xsi,null).addChildElement('Object',xsi,null).addChildElement('SubObject',xsi,null).addChildElement('Item',xsi,null).addChildElement('ItemType',xsi,null).addChildElement('Domain',xsi,null).addTextNode('"TypeId"');
	  	OrderBody.addChildElement('TypeId',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ds_O_tss_fns',xsi,null).addChildElement('ObjectElements',xsi,null).addChildElement('Object',xsi,null).addChildElement('SubObject',xsi,null).addChildElement('Item',xsi,null).addChildElement('Action',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('DeliveryDateTime',xsi,null).addChildElement('Type',xsi,null).addTextNode('"Min"');
	  	OrderBody.addChildElement('DeliveryDateTime',xsi,null).addChildElement('Type',xsi,null).addTextNode('"Start"');
	  	OrderBody.addChildElement('DateTime1',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ds_O_tss_fns',xsi,null).addChildElement('InstructionElements',xsi,null).addChildElement('MaintenanceEquipmentInfo',xsi,null).addChildElement('EquipmentSupplier',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ds_O_tss_fns',xsi,null).addChildElement('InstructionElements',xsi,null).addChildElement('MaintenanceEquipmentInfo',xsi,null).addChildElement('OtherEquipmentSupplier',xsi,null);
	  	OrderBody.addChildElement('IssuedDateTime',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ds_O_tss_fns',xsi,null).addChildElement('ObjectElements',xsi,null).addChildElement('Object',xsi,null).addChildElement('ObjectId',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ds_O_tss_fns',xsi,null).addChildElement('ObjectElements',xsi,null).addChildElement('Object',xsi,null).addChildElement('ObjectId',xsi,null).addChildElement('Domain',xsi,null).addTextNode('"ObjectId"');
	  	//OrderID	  	
	  	dom.XmlNode OrderId = body.addChildElement('OrderId',xsi,null);
	  	OrderId.addChildElement('Role',xsi,null).addTextNode('buyer');
	  	
	  	// Order Body with child elements
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('DeliveryDateTime',xsi,null).addChildElement('Type',xsi,null).addTextNode('"Max"');
	  	OrderBody.addChildElement('DeliveryDateTime',xsi,null).addChildElement('Type',xsi,null).addTextNode('"End"');
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('DeliveryDateTime',xsi,null).addChildElement('Type',xsi,null).addTextNode('"Exact"');
	  	OrderBody.addChildElement('DeliveryDateTime',xsi,null).addChildElement('Type',xsi,null).addTextNode('"Start"');
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ds_O_tss_fns',xsi,null).addChildElement('InstructionElements',xsi,null).addChildElement('MaintenanceEquipmentInfo',xsi,null).addChildElement('Country',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ds_O_tss_fns',xsi,null).addChildElement('InstructionElements',xsi,null).addChildElement('MaintenanceEquipmentInfo',xsi,null).addChildElement('SiteSignature',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ds_O_tss_fns',xsi,null).addChildElement('ObjectElements',xsi,null).addChildElement('Object',xsi,null).addChildElement('SubObject',xsi,null).addChildElement('Node',xsi,null).addChildElement('NodeID',xsi,null);
	  	
	  	//OrderLine with child elements
	  	dom.XmlNode OrderLine = body.addChildElement('OrderLine',xsi,null).addChildElement('ProductUseCaseDetails',xsi,null).addChildElement('Id',xsi,null);
	  	OrderLine.addChildElement('ProductUseCaseDetails',xsi,null).addChildElement('Name',xsi,null);
	  	OrderLine.addChildElement('Number',xsi,null);
	  	OrderLine.addChildElement('Quantity',xsi,null);
	  	
	  	//Order Body Child Elemnts
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('Extension_ds_O_tss_fns',xsi,null).addChildElement('InstructionElements',xsi,null).addChildElement('MaintenanceEquipmentInfo',xsi,null).addChildElement('Cause',xsi,null);
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('ShipToParty',xsi,null).addChildElement('Reference',xsi,null).addChildElement('Name',xsi,null).addTextNode('Description');
	  	OrderBody.addChildElement('DeliverySpec',xsi,null).addChildElement('ShipToParty',xsi,null).addChildElement('Reference',xsi,null).addChildElement('Value',xsi,null);
	  	
	  	OrderId.addChildElement('Role',xsi,null).addTextNode('Supplier');
	  	
	  	//XMl String Proccessed
	  	System.debug('OrderUpdateRequestByInitiator is.....'+doc.toXmlString()); 
	  	
	  	HttpRequest request = new HttpRequest();
		request.setMethod('POST');
		request.setEndpoint(url);
		request.setHeader('Content-Type', 'text/xml');
		request.setBodyDocument(doc);
		Http http = new Http();
		//HttpResponse response = http.send(request);
	  	
	  	//system.debug(' HTTP response for OrderUpdateRequestByInitiator  ---------- '+response);
	}	
}