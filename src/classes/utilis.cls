global class utilis
{
/*
 // generateUID: Create a UID (unique ID) based on a full timestamp
    public static String generateUID() {
        system.debug('@@ generateUID:start @@');
        
        Datetime dt     = System.now();
        String dateStr  = String.valueOf(dt.date());
        dateStr         = dateStr.replace('-', '');
        String timeStr  = String.valueOf(dt.getTime());
        String UIDStr   = dateStr + timeStr;
        
        system.debug('@@ generateUID:end @@');
        return UIDStr;
    }
    
    // mapToMessageBody: Creates a readable format of a Map for viewing purposes only
     public static String mapToMessageBody(Map<String, String> dataMap) {
    system.debug('@@ mapToMessageBody:start @@');
     
    String messageBody = '';
      Set <String> keys = dataMap.keySet();
     for (String keyLoop : keys) {
       messageBody = messageBody + keyLoop + ' - ' + dataMap.get(keyLoop) + '\n';
     }
     
     system.debug('@@ mapToMessageBody:end @@');
      return messageBody;
    }
    
    // mapMapToString: 
    public static String mapMapToString(Map<Integer, Map<String, String>> dataMap) {
      system.debug('@@ mapMapToString:start @@');
      
      String dataStr = '';
      
      
      system.debug('@@ mapMapToString:end @@');
      return dataStr;
    }
    
    // stringToMapMap: 
    public static Map<Integer, Map<String, String>> stringToMapMap(String dataStr) {
      system.debug('@@ stringToMapMap:start @@');
      
      Map<Integer, Map<String, String>> dataMap = new Map<Integer, Map<String, String>>();
      
      
      system.debug('@@ stringToMapMap:end @@');
      return dataMap;
    }
    
    // mapToString: Converts a Map into a single string with delimitor as @#&%
    public static String mapToString(Map<String, String> dataMap) {
    system.debug('@@ mapToString:start @@');

    String dataStr = '';
      Set <String> keys = dataMap.keySet();
     for (String keyLoop : keys) {
       dataStr = dataStr + '@#&%' + keyLoop + '@#&%' + dataMap.get(keyLoop);
     }

    system.debug('@@ mapToString:end @@');
      return dataStr;
    }
    
    // stringToMap: Converts a string with delimitor @#&% to a Map
    public static Map<String, String> stringToMap(String dataStr) {
    system.debug('@@ stringToMap:start @@');
    
    Map<String, String> dataMap = new Map<String, String>(); 
    List <String> res = dataStr.split('@#&%', 0);
    Integer counter = 1;
    while ( (counter+1) < res.size()) {
      dataMap.put(res.get(counter), res.get(counter+1));
      counter = counter + 2;
    }

    system.debug('@@ stringToMap:end @@');
    return dataMap;
    }

  // checkTechError: Checks if the provided category has a technical_error entry in the database
  public static Boolean checkTechErrorDB(String categoryStr) {
    system.debug('@@ checkTechErrorDB:start @@');
    
    String recordTypeId = [Select r.Id From RecordType r where r.Name = :categoryStr and r.SobjectType = 'Integrations_Queue__c'].id;
    List<Integrations_Message__c> intAckList = [Select i.Id From Integrations_Message__c i where i.Error_Status__c = 'Technical Error' and i.Category__c = :categoryStr];

    system.debug('@@ checkTechErrorDB:end @@');
    // If list is bigger than 0, we have a technical error and return false
    if (intAckList.size() > 0)
      return true;
    else 
      return false;
  }

  // insertIntoDB: Function for storing an entry in the Integrations_Messages and/or Integrations_Queue if needed
  public static Integer insertIntoDB(String UIDStr, String dataMap, String categoryStr, String methodStr, Integer statusCode, String statusMessage) {  
    system.debug('@@ insertIntoDB:start @@');
     
    // Sets default/initial values
    Integer responseCode   = 0;
    String statusText    = 'New';
    String errorText    = '';
    String messageBody     = Integrations_Utilities_Cls.mapToMessageBody(stringToMap(dataMap));

    // Sets different text descriptions depending on statusCode
    if (statusCode == 0) {
      statusText   = 'Sent';
      errorText  = '';
    }
    if (statusCode < 0) {
      statusText   = 'Failed';
      errorText   = 'Technical Error';
    }
    if (statusCode > 0) {
      statusText   = 'Failed';
      errorText   = 'Business Error';
    }

    // Insert the base information into the database
    System.Savepoint dbSavepoint = Database.setSavepoint();
    Integrations_Message__c ackInsert = new Integrations_Message__c(UID__c = UIDStr, Body__c = dataMap, Category__c = categoryStr, Status_Code__c = statusCode, Status_Description__c = statusMessage, Message_Body__c = messageBody, Interface_Method_Name__c = methodStr, Status__c = statusText, Error_Status__c = errorText);
      try {
      insert ackInsert;
      responseCode = 0;
      }
      catch (Exception e) {
            system.debug('ERROR: Could not insert into [Integrations_Message__c]: ' + e);
            Database.rollback(dbSavepoint);           
            responseCode = -1;
        }
        
    system.debug('@@ insertIntoDB:end @@');
    return responseCode;  
  }
    
    // updateStatusDB: Function for triggers to be able to update an entry in the database
  public static void updateStatusDB(String UIDStr, Integer statusCode, String statusMessage) {
        system.debug('@@ updateStatusDB:start @@');

      System.Savepoint dbSavepoint = Database.setSavepoint();
        try {
          Integrations_Message__c newUpdate = [SELECT UID__c, Status_Code__c FROM Integrations_Message__c WHERE UID__c = :UIDStr];
            newUpdate.Status_Code__c = statusCode;
            newUpdate.Status_Description__c = statusMessage;
            if (statusCode == 0) {
              newUpdate.Status__c = 'Sent';
              newUpdate.Error_Status__c = '';
            }
          if (statusCode < 0) {
        newUpdate.Status__c = 'Failed';
        newUpdate.Error_Status__c = 'Technical Error';
      }
      if (statusCode > 0) {
        newUpdate.Status__c = 'Failed';
        newUpdate.Error_Status__c = 'Business Error';
      }
            
       update(newUpdate);
        }
        catch (Exception e) {
            system.debug('ERROR: Could not update [Status_Code__c, Status_Description__c] in [Integrations_Message__c]: ' + e);
            Database.rollback(dbSavepoint);           
        }
                
        system.debug('@@ updateStatusDB:end @@');
    }
    
    // generateTestdata: Method that create a Map of elements for requested function
    public static Map<String, String> generateTestdata(String methodStr) {
        system.debug('@@ generateTestdata:start @@');
        
        Map<String, String> testdataMap = new Map<String, String>();
        if (methodStr == 'publishOrderInfo') { // NID
            /*
            testdataMap.put('a_Identitet', 'ident');
            testdataMap.put('a_Produkt', 'produkt');
            testdataMap.put('a_KundNamn', 'namn');
            testdataMap.put('a_NodA', 'noda');
            testdataMap.put('a_NodB', 'nodb');
            testdataMap.put('a_MaxBandWidth', 'bandwidth');
            testdataMap.put('a_MultiCast', 'multicast');
            testdataMap.put('a_RoutingInformation', 'routing');
            testdataMap.put('a_DesiredRoutes', 'routes');
            testdataMap.put('a_CustomerId', 'cust id');
            testdataMap.put('a_CustomersCustomers', 'customer list');
            testdataMap.put('a_SolutionId', 'solution');
            */
           /* testdataMap.put('NID_Order_ID', 'NID_Order_ID');
            testdataMap.put('Instance_ID', 'Instance_ID');
            testdataMap.put('NID_Action', 'NID_Action');
            testdataMap.put('Type_of_Service_Product', 'Type_of_Service_Product');
            testdataMap.put('Account_Name', 'Account_Name');
            testdataMap.put('delivery_date', '2009-07-15 06:44:00');
            testdataMap.put('Actual_delivery_date', 'Actual_delivery_date');
            testdataMap.put('RowType', 'RowType');
            testdataMap.put('Type_of_Service_MainProductGroup', 'Type_of_Service_MainProductGroup');
            testdataMap.put('Maximum_Bandwidth__Mbit_s', '222');
            testdataMap.put('Multicast', 'Multicast');
            testdataMap.put('Routing_Specification', 'Routing_Specification');
            testdataMap.put('Desired_Routes', 'Desired_Routes');
            testdataMap.put('Account_ID', 'Account_ID   ');
            testdataMap.put('Customers_Customer', 'Customers_Customer');
            testdataMap.put('Instance_ID', 'Instance_ID');
            testdataMap.put('Price_Model', 'Price_Model');
        }
        if (methodStr == 'publishSiteStatusInfo') { // NID
          testdataMap.put('Name', 'Testname');
          testdataMap.put('CRM_Site_Code__c', '1');
          testdataMap.put('CRM_Status_Code__c', 'Active');
        }
        if (methodStr == 'publishSiteStatusInfo2') { // NID
          testdataMap.put('Name', 'Anothername');
          testdataMap.put('CRM_Site_Code__c', '2');
          testdataMap.put('CRM_Status_Code__c', 'Expired');
        }
        if (methodStr == 'publishCustomerInfo') { // NID
            testdataMap.put('Name', 'mmm');
            testdataMap.put('CRM_Account__c', 'MrTester');
            testdataMap.put('Tom_ID__c', '1111');
        }
        if (methodStr == 'publishPricingInfoRequest') { // MEC
            testdataMap.put('Sold_Service.Name', '1');
            testdataMap.put('Sold_Service.TOM_ID__c', '2');
            testdataMap.put('Sold_Service.Charge_kWh__c', '2.3');
            testdataMap.put('Sold_Service.CFF_Common_Facility_Factor__c', '4');
            testdataMap.put('Sold_Service.CurrencyISOCode', '5');
            testdataMap.put('Sold_Service.Site_ID__c', '6');
        }
        if (methodStr == 'sendOperationalContactInformation') {
            testdataMap.put('SSID__c','011 10254'); 
            testdataMap.put('Account__r.Name','LUFTFARTSVERKET');
            testdataMap.put('Account__r.TOM_ID__c','12595');
            testdataMap.put('Contact_Planned_Work__c','csc-sweden@skanova.com'); 
            testdataMap.put('Contact_Service_Disturbance__c','csc-sweden@skanova.com');
            testdataMap.put('Contact_Service_Manager__c','christer.rognell@teliasonera.com');
            testdataMap.put('Product','ILL 64 K');
            testdataMap.put('International_Designation__c','International Designation');
            testdataMap.put('In_Service_From__c','2009-07-15 06:44:00');
            testdataMap.put('Dismantled_From__c','2009-07-15 06:44:00');
        }
        if (methodStr == 'smsGatewayRequest') {  
          // Telia ID of Stanley 
          testdataMap.put('id','301105');   
          // Telia PIN of Stanley
          testdataMap.put('pwd','t8ZynaR1'); 
            testdataMap.put('MSISDN No','0046722800974'); 
            testdataMap.put('Text','This is a test from SFDC');
        }        
        if (methodStr == 'newTktSFDCOblicore') {
            testdataMap.put('TicketNumber','1234'); 
            testdataMap.put('SoldServiceID','SSID__c value in sfdc');
            testdataMap.put('RealDestination','Destination value in sfdc');
            testdataMap.put('Registered','2009-07-15 06:44:00');
            testdataMap.put('Service affecting','Service_Affecting__c value in sfdc');
            testdataMap.put('Customer No','CustomerID value in sfdc');
            testdataMap.put('Voice service','Voice_service__c value in sfdc');
            testdataMap.put('Ticket Description','2009-07-15 06:44:00');
            testdataMap.put('OpStartTime','2009-07-15 06:44:00');
        }
        if (methodStr == 'serviceAffectingUpdateSFDCOblicore') {
            testdataMap.put('TicketNumber','1234'); 
            testdataMap.put('Service affecting start time','2009-07-15 06:44:00');
            testdataMap.put('Service affecting end time','2009-07-15 06:44:00');
            testdataMap.put('Service affecting','2009-07-15 06:44:00');
        }
        if (methodStr == 'rfsSFDCOblicore') {
            testdataMap.put('TicketNumber','1234'); 
            testdataMap.put('RFS','2009-07-15 06:44:00');   
            testdataMap.put('Outage Reason','Reason_for_outage__c  value in SFDC');
        }
        if (methodStr == 'operationalStartTimeSFDCOblicore') {
            testdataMap.put('TicketNumber','1234'); 
            testdataMap.put('OpStartTime','2009-07-15 06:44:00');
        }
        if (methodStr == 'waitingFlagSFDCOblicore') {
            testdataMap.put('TicketNumber','1234');
            testdataMap.put('Status','Status value in SFDC');
            testdataMap.put('Waiting start time','2009-07-15 06:44:00');
            testdataMap.put('Waiting end time','2009-07-15 06:44:00');
        }
        if (methodStr == 'ticketCategorySFDCOblicore') {
            testdataMap.put('TicketNumber','1234');        
            testdataMap.put('Category','Case_category__c value in SFDC');
        }
        if (methodStr == 'crmToOblicore') {
          testdataMap.put('TOM_ID__c','14124'); 
      testdataMap.put('CustomerIDNo','1313');  
      testdataMap.put('Name','Name  value in SFDC');
      testdataMap.put('IC_Number__c','IC_Number__c in sfdc'); 
      testdataMap.put('NPS_L1__c','13');  
      testdataMap.put('NPS_L2__c','111');
      testdataMap.put('NPS_L3__c','41'); 
      testdataMap.put('Contract_Length_in_Months__c','11');  
      testdataMap.put('Notice_Period__c','444');
      testdataMap.put('Contract_Type__c','1231');
      testdataMap.put('Revenue_Start_Date__c','2009-07-15 06:44:00');
      testdataMap.put('Customer_Signature_Date__c','2009-07-15 06:44:00');
      testdataMap.put('Start_of_Charge_Date__c','2009-07-15 06:44:00');
      testdataMap.put('Estimated_Revenue_End_Date__c','2009-07-15 06:44:00');
        }
        if (methodStr == 'soldServiceDetails' || methodStr == 'publishSoldServices') { // AnalysP
          testdataMap.put('SSID__c', '123');
      testdataMap.put('Product', '11223');
      testdataMap.put('International_Designation__c', 'SE');
      testdataMap.put('In_Service_From__c', '2009-07-15 06:44:00');
      testdataMap.put('Dismantled_From__c', '2010-07-15 06:44:00');
      testdataMap.put('Account__r.Name', 'Tester');
      testdataMap.put('Account__r.TOM_ID__c', '12221');
        }
        if (methodStr == 'sendOperationalContactsRequest' || methodStr == 'publishOperationalContacts') { // AnalysP
          testdataMap.put('SSID__c', '123');
      testdataMap.put('Contact_Planned_Work__c', 'Person');
      testdataMap.put('Contact_Service_Disturbance__c', 'Yes');
      testdataMap.put('Contact_Service_Manager__c', 'MrManager');
        }
        
        
        system.debug('@@ generateTestdata:end @@');
        return testdataMap;
    }
*/
}