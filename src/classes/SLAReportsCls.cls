global with sharing class SLAReportsCls {
  
  global static SLAReportsDataCls.SLAReports create(SLAReportsDataCls.SLAReports sr){
    
    Account acc = [Select id from Account where TOM_ID__c =: sr.TOM_ID];
    
    Attachment a = new Attachment();
    a.Name = 'SLA_'+sr.month+sr.year;
    a.body = sr.pdfBody;
    a.ParentId = acc.id;
    a.ContentType = 'pdf';
    insert a;
    
    return sr;
  }

}