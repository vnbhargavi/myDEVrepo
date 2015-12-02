global class GetSLAAttachmentCls
{
/*
public with sharing class Integrations_GetSLAAttachment_Cls 
{
   
   public static Account acc;   
   public static String yearStr;
   public static String monthStr;
   public static String pdfBodyStr; 
   public static Boolean testmode = false; 
   public static String EmbeddedDataStr;
   public static String FileNameStr;
   public static String FileExtensionStr;       
   public static List<String> attachmentStringList;
   public static Integer stringSizeInt ;
   public static Integer subStringSizeInt ;
   public static Integer startIndexInt=0,endIndexInt;     
   public static set<String> attachementSet;   
   public static String yearMapStr;
   public static String monthMapStr;
   
   
  /*public static void test_SLAReports()
  {
    Map<String,String> parsedMap = new Map<String,String>();                     
        parsedMap.put('Month','8');
      parsedMap.put('Year','2011');
      parsedMap.put('TOM_ID','21485');
        String UIDStr           = Integrations_Utilities_Cls.generateUID(); 
        String str = Integrations_GetSLAAttachment_Cls.sendRequest(parsedMap,UIDStr);   
        Integrations_GetSLAAttachment_Cls.createAttachment(str);  
  }*/ 
 /* public static Integer getResponse(Map<String,String>attachmentParamMap)
  {
        System.debug('@@ Entering into Integrations_GetSLAAttachment_Cls.getResponse @@');    
    Map<String,String>  slaReportMap = new  Map<String,String>();
    slaReportMap.putAll(attachmentParamMap);
    yearMapStr = attachmentParamMap.get('Year');
    monthMapStr = attachmentParamMap.get('Month');    
    //From the map getting TOMID and querying for Account,this is required because this Account Id is ParentId for Attachement
    acc = [select name from Account where Tom_Id__c =:slaReportMap.get('TOM_ID')]; 
        Integer resultInt       = 0;
        
        //Generating UID
        String UIDStr           = Integrations_Utilities_Cls.generateUID();
        
        //Calling sendRequest method using the Map and UID
        if (Test.isRunningTest() == false) 
        {
      Integer returnStatusInt = sendRequest(attachmentParamMap, UIDStr);
      if(returnStatusInt == 0)
      {
        createAttachment(EmbeddedDataStr);
      }            
        }
        else
        {
      Integer returnStatusNullInt = sendRequest(attachmentParamMap, UIDStr);
      createAttachment('aGVsbG8gVGhpcyBpcyB0ZXN0IGNsYXNz');            
        }
        System.debug('@@ Exiting from Integrations_GetSLAAttachment_Cls.getResponse @@'); 
        return 0;             
  }  
  public static Integer sendRequest(Map<String,String> parsedMap,String UIDStr) 
    {
  //In this class we are framing an XML which will be using for sending request to Oblicore
      System.debug('@@ Entering into Integrations_GetSLAAttachment_Cls.sendRequest @@'); 
           // Setting default/initial values
    Integer result       = 0;
    Boolean techError     = false;
    Boolean resendFromQueue = true;
    String statusMessage  = '';
       Integer statusCode  = null;    
    Integrations_OblicoreXSD_Cls.AttachmentType attachObj = new Integrations_OblicoreXSD_Cls.AttachmentType(); 

    // If UID is present, no new UID is created, else it is a new entry  (resendFromQueue is set accordingly)
    if (UIDStr == null || UIDStr == '') {
      UIDStr = Integrations_Utilities_Cls.generateUID();  
      resendFromQueue = false;  
    }
    Integrations_OblicoreIPLPropWSDL_Cls.IplApplicationPropertiesType ackObj = new Integrations_OblicoreIPLPropWSDL_Cls.IplApplicationPropertiesType();
    Integrations_OblicoreXSD_Cls.SLAComplianceReportRequestType SLAObj = new Integrations_OblicoreXSD_Cls.SLAComplianceReportRequestType();

    SLAObj.CustomerID = Integer.ValueOf(parsedMap.get('TOM_ID'));
    SLAObj.Month = parsedMap.get('Month');
    SLAObj.Year = parsedMap.get('Year');        
        
    Integrations_OblicoreWSDL_Cls.getSLAComplianceReportRequest_element slaCompElementObj = new Integrations_OblicoreWSDL_Cls.getSLAComplianceReportRequest_element();
  
        slaCompElementObj.SLAComplianceReportRequest = SLAObj;
        slaCompElementObj.IplApplicationProperties= ackObj;     
        
       
        ackObj.msgID = UIDStr; 
        ackObj.msgSource = 'Salesforce'; 
        ackObj.msgType = 'getSLAComplianceReport';
        
          Integrations_OblicoreWSDL_Cls.ServicePortTypeEndpoint serviceObj = new Integrations_OblicoreWSDL_Cls.ServicePortTypeEndpoint();
            serviceObj.clientCertName_x   = System.label.TSIC_Certificate; //'ca1_tsic_teliasonera_com';
      serviceObj.timeout_x       = integer.valueof(System.label.TSIC_Timeout); //1000;            
      if (Test.isRunningTest() == false) 
      {
        try
        {
            //making a callout from here
          Integrations_OblicoreXSD_Cls.SLAComplianceReportReplyType response = serviceObj.getSLAComplianceReport(ackObj, SLAObj);
          statusMessage  = response.message;
          statusCode    = Integer.valueOf(response.status);
          attachObj     = response.Attachment;
          if(statusCode == 0)  
          {
            EmbeddedDataStr = attachObj.EmbeddedData;
            FileNameStr   = attachObj.FileName;
            FileExtensionStr= attachObj.FileExtension;                            
          }
        }
        catch(Exception e)
        {
          System.debug('@@ Exception @@'+e.getmessage());
        }        
      }
     System.Debug('@@ Exiting from Integrations_GetSLAAttachment_Cls.sendRequest method @@');    
    return statusCode;      
    }
  public static void createAttachment(String responseAttachStr)    
    { 
        //This method will be used to create attachment for an account               
            System.debug('@@ Entering into Integrations_GetSLAAttachment_Cls.createAttachment @@');
            //The following converts List of Strings into a String,this is required for XMLStreamReader class   
      String responseStr = '';      
      //Creating attachment for Account
            Attachment a = new Attachment();
            String monthAttachStr;
            if(monthMapStr == '01' || monthMapStr == '1')
            {
              monthAttachStr = 'January';
            }
            else if(monthMapStr == '02' || monthMapStr == '2')
            {
              monthAttachStr = 'February';
            }
            else if(monthMapStr == '03' || monthMapStr == '3')
            {
              monthAttachStr = 'March';
            }
            else if(monthMapStr == '04' || monthMapStr == '4')
            {
              monthAttachStr = 'April';
            }
            else if(monthMapStr == '05' || monthMapStr == '5')
            {
              monthAttachStr = 'May';
            }
            else if(monthMapStr == '06' || monthMapStr == '6')
            {
              monthAttachStr = 'June';
            }
            else if(monthMapStr == '07' || monthMapStr == '7')
            {
              monthAttachStr = 'July';
            }
            else if(monthMapStr == '08' || monthMapStr == '8')
            {
              monthAttachStr = 'August';
            }
            else if(monthMapStr == '09' || monthMapStr == '9')
            {
              monthAttachStr = 'September';
            }
            else if(monthMapStr == '10')
            {
              monthAttachStr = 'October';
            }
            else if(monthMapStr == '11')
            {
              monthAttachStr = 'November';
            }
            else if(monthMapStr == '12')
            {
              monthAttachStr = 'December';
            }                         
            a.Name = 'SLA_'+monthAttachStr+'_'+yearMapStr;
            a.body = EncodingUtil.base64Decode(responseAttachStr); 
            a.ParentId = acc.id;
            a.ContentType = 'application/pdf';
            try
            { 
                insert a; // TODO: uncomment this line
            }
            catch(DMLException e)
            {
                for (Integer i = 0; i < e.getNumDml(); i++) 
                {
                    // Process exception here
                    System.debug('Error while inserting'+e.getDmlMessage(i));
                }
            }
            System.debug('@@ Exiting from Integrations_GetSLAAttachment_Cls.createAttachment @@');           
    }          
}
*/
}