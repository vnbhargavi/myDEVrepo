public with sharing class XMLMessageParse 

{	//public static void sendRequest(String TOM_ID,String month,String year)
	public static void sendRequest()
    {
    String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
    String xsi = 'http://www.myservice.com/services/MyService/';
    //String endpntUrl = 'https://salesforce.ext.telia.se:7000';
    String endpntUrl='http://www.google.co.in/';
	String timeout = '10';
        String req = '';  
        String result =''; 
        string err ='';
        string rawResponse ='';  
        string transid ='';
       String TOM_ID='234567';
       String month='abc';
       string year='123';
       List<Account> acc = [Select id,Name,TOM_ID__c from Account];
       // where TOM_ID__c =: sr.TOM_ID];
       
        DOM.Document doc = new DOM.Document();
        dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
        envelope.setNamespace('xsi', xsi);
        //Header
        dom.XmlNode configData = envelope.addChildElement('_configData', soapNS, null);
        dom.XmlNode endpointURL = configData.addChildElement('endpointURL', xsi, null).addTextNode(endpntUrl);
        dom.XmlNode tout = configData.addChildElement('timeout', xsi, null).addTextNode(timeout);
        // Body
  		dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
		dom.XmlNode accountList = body.addChildElement('Account',xsi,null);
		dom.XmlNode TOMID = accountList.addChildElement('TOM_ID', xsi, null).addTextNode(TOM_ID);
		dom.XmlNode MonthNode = accountList.addChildElement('Month', xsi, null).addTextNode(month);
		dom.XmlNode YearNode = accountList.addChildElement('Year', xsi, null).addTextNode(year);
			
        req = req + doc.toXmlString();
        system.debug('request----------------'+req);
        
        HttpRequest request = new HttpRequest();
		request.setMethod('POST');
		request.setEndpoint(endpntUrl);
		request.setHeader('Content-Type', 'text/xml');
		request.setBodyDocument(doc);
		Http http = new Http(); 
		HttpResponse response = http.send(request);
		 
		system.debug('response  ---------- '+response.getBody());
		String pdfb='';
		XMLStreamReader reader= new XMLStreamReader(req); 
		XMLStreamReader reader1 =response.getXmlStreamReader();
		Dom.XMLNode address = doc.getRootElement();
		
		while(reader.hasNext())
		{
			if (reader.getEventType() == XmlTag.START_ELEMENT)
			{
			System.debug('********************************'+reader.getLocalName());
			if(reader.getLocalName()=='TOM_ID')
			{
			pdfb=pdfb+reader.getAttributeValue('TOM_ID', '');
			System.debug('values are----------------'+pdfb);
			}
			} 
			/*for(Dom.XMLNode child : address.getChildElements()) 
			{
				if(reader.getLocalName()=='TOM_ID')
				{
				string tomid=reader.getText();
				System.debug('configdtaa value is'+tomid);
				}
				
				System.debug('child elements with text are'+child.getText());
		 }*/
		 reader.next();
	   }
}
}