public with sharing class SchedulesendMsg {

   public Account account{get;set;}
   public final String serviceEndpoint = 'http://api.acmecorp.com:8888/InvoiceService/list';
  
   public final String certName = null;

   private final Account acct;

    public class Invoice {
    public Integer invoiceNumber {get;set;}
    public Integer orderNumber {get;set;}
    public Integer contractNumber {get;set;}
    public Date dueDate {get;set;}
    public Double amount {get;set;}
    public String status {get;set;}
 
    public void from_xml(dom.XmlNode node) {
      invoiceNumber = Integer.valueOf(node.getChildElement('invoice-number',null).getText());
      orderNumber = Integer.valueOf(node.getChildElement('order-number',null).getText());
      contractNumber = Integer.valueOf(node.getChildElement('contract-number',null).getText());
      dueDate = Date.parse(node.getChildElement('due-date',null).getText());
      amount = Double.valueOf(node.getChildElement('amount',null).getText());
      status = node.getChildElement('status',null).getText();
    }
  }
  public List<Invoice> invoices {
    get {
      if(invoices==null) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(serviceEndpoint+'?id='+acct.id);
        req.setMethod('GET');
        if(certName!=null) {
          req.setClientCertificateName(certName);
        }
        HttpResponse res = h.send(req);
 
        if(res.getStatusCode()>299) {
          System.debug('ERROR: '+res.getStatusCode()+': '+res.getStatus());
          System.debug(res.getBody());
        } else {
          dom.Document doc = res.getBodyDocument();
          invoices = new List<Invoice>();
          for(dom.XmlNode node : doc.getRootElement().getChildElements()) {
            if(node.getName()=='invoice') {
              Invoice iv = new Invoice();
              iv.from_xml(node);
              invoices.add(iv);
            }
          }
        }
      }
      return invoices;
    }
    set;
  }
 
  public SchedulesendMsg(ApexPages.StandardController stdController) {
    this.acct = (Account)stdController.getRecord();
  }
}