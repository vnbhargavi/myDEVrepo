global without sharing class SLAReportsDataCls {

  global class SLAReports{
    
    webservice String TOM_ID;
    webservice String month;
    webservice String year;
    
    webservice String attachmentName;
    webservice Blob pdfBody;
    // Fault Strings
    
    webservice List<String> FAILED_REASON;
    webservice String Operation_String;  
  
    // Constructors
    
    global SLAReports() {}
    global SLAReports(String TOMID, Blob pdfBody){ 
    
      this.TOM_ID = TOMID;
      this.pdfBody = pdfBody; 
    }  
  }
  
  public enum Operation {
              CREATE // Create the SLA Reports in the SFDC system
  }  
}