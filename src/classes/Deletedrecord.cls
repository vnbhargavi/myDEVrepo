public with sharing class Deletedrecord 
{ 
	public static string delrec(List<Account> ac)
	{
	String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
	String xsi = 'http://www.w3.org/2001/XMLSchema-instance';
	String serviceNS = 'http://www.myservice.com/services/MyService/';
	Integer index=0;
	//List<Account> acc= [Select id,Name from Account where IsDeleted=true ALL ROWS];
	String reqs='';
	
	    for(Account accdel:ac)
	    {
		DOM.Document doc = new DOM.Document();
		dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
	  	envelope.setNamespace('xsi', xsi);
	  	envelope.setAttributeNS('schemaLocation', soapNS, xsi, null);
	  	dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
	  	
	  	for(Integer j=0;j<ac.size();++j)
 	    {
 	      dom.XmlNode accountList = body.addChildElement('accountList',xsi,null);
		  dom.XmlNode AccountName = accountList.addChildElement('Name', xsi, null).addTextNode(ac.get(index).Name);
		  accountList.addChildElement('Id', xsi, null).addTextNode(ac.get(index).Id);
		  index++;
 	     }
 	   reqs = reqs+ doc.toXmlString();		
	    }
	   
	system.debug('Deleted records are:'+reqs);
	return null;
	}

}