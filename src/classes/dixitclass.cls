global class dixitclass{
public static void sendreq()
{
String outputres='';
String soapNS='http://www.w3.org/2001/XMLSchema';
string xmlns='http://www.w3.org/2001/XMLSchema-instance';
String Merchanname='dixit';
String Sesiontoken='gAc9F$cY0VRqpzLLlfhWdhQYR9WWLxhUvnXWSE9ffqkA';
 string xmlns1='AnetApi/xml/v1/schema/AnetApiSchema.xsd';  
    DOM.Document doc = new DOM.Document();
    dom.XmlNode envelope = doc.createRootElement('createTransactionRequest', '', '');
    //envelope.setNamespace('xmlns', xmlns);
    //envelope.setAttributeNS('xmlns', soapNS, xmlns1, '');
    dom.XmlNode merchantAuthentication= envelope.addChildElement('merchantAuthentication', soapNS, null);
    merchantAuthentication.addChildElement('Name', Merchanname, null).addChildElement('SessionToken', Sesiontoken, null);
    System.debug(doc.toXmlString());


}



}