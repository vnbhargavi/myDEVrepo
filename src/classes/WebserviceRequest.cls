public class WebserviceRequest{  
public void sendRequest(){  
     String endpointUrl = ''; // please provide the endpoint url here  
       
     //create a new instance of httprequest  
     HttpRequest req = new HttpRequest();  
     //set method  
     req.setMethod('POST');  
  
     // set endpoint url  
     req.setEndpoint(endpointUrl);  
  
     // set header  
     req.setHeader('Content-Type', 'text/xml');  
  
     // set soap envelope into request body  
     req.setBody(getSoapEnvelope());  
       
     // create a new instance of Http class  
     Http http = new Http();  
     // send request  
     HttpResponse res = http.send(req);  
       
     // method to parse httpresponse  
     parseResponse(res);  
 }  
// method to create envelope  
public String getSoapEnvelope()
{  
String envelope = '<soap:envelope soap:encodingstyle="http://www.w3.org/2001/12/soap-encoding" xmlns:soap="http://www.w3.org/2001/12/soap-envelope"><soap:body xmlns:m="http://www.example.org/stock"><m:getstockprice><m:stockname>IBM</m:stockname></m:getstockprice></soap:body></soap:envelope>';  
return envelope ;  
}  
//this method is used to parse the response.  
public void parseResponse(HttpResponse res)  
{  
 dom.document doc = res.getBodyDocument();  
 dom.XmlNode [] node = doc.getRootElement().getChildElements();  
 // iterate over node will return all the nodes of the xml respose.    
}  
  
}