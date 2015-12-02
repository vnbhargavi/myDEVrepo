public with sharing class sendmymessage
{
	public static void sendRequest()
    {
        
    String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
    String xsi = 'http://www.myservice.com/services/MyService/';
    String endpntUrl = 'https://teliasonera.com.se';
    String timeout = '10';
    Integer batchSize = 2;
    Integer listSize;
    String req = '';
    Integer index = 0;
    
    
     list<Account> lstAccounts = [Select id,Name,TOMID__c from Account];
     list<Case> cse= [Select CaseNumber,Status,Priority from  case];
     listSize = lstAccounts.size();
      Decimal lssize = ((Decimal)listSize)/batchSize;
      for(Integer i=0;i<(math.ceil(lssize));++i)
      {
	    DOM.Document doc = new DOM.Document();
	    dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'soapenv');
	    envelope.setNamespace('xsi', xsi);
      //Header
	      dom.XmlNode configData = envelope.addChildElement('_configData', soapNS, null);
	      dom.XmlNode endpointURL = configData.addChildElement('endpointURL', xsi, null).addTextNode(endpntUrl);
	      dom.XmlNode tout = configData.addChildElement('timeout', xsi, null).addTextNode(timeout);
      //Body
      	dom.XmlNode body = envelope.addChildElement('Body', soapNS, null);
      	system.debug('before entering');
        for(Integer j=0;j<batchSize && index <listSize;j++)
        {
        dom.XmlNode accountList = body.addChildElement('accountList',xsi,null);
        dom.XmlNode AccountName = accountList.addChildElement('Name', xsi, null).addTextNode(lstAccounts.get(index).Name);
        dom.XmlNode Id = accountList.addChildElement('Id', xsi, null).addTextNode(lstAccounts.get(index).Id);
        if(String.valueof(lstAccounts.get(index).TOMID__c)!=null)
        dom.XmlNode TOMID = accountList.addChildElement('TOM ID', xsi, null).addTextNode(String.valueof(lstAccounts.get(index).TOMID__c));
        index ++;
      }
      req = req + doc.toXmlString();
     }
            system.debug('req----------------'+req);
    }

}