//*****************************************************************************************************
 // Purpose      : This class contains unit tests for validating the behavior of Apex classes
 // Date         : 13-Feb-2012
 // Created by   : Capgemini
 // Author       : Sushma Mishra,Eswara Sobila, Bhargavi Vadlamani
 // Description  : Test class for Integrations_ResendMessage_Cls
 // Modified by  : Eswar Sobila
 //*****************************************************************************************************
@isTest
private class Integrations_ResendMessage_Test {
public void testing()
{
system.debug(' hai test');
system.debug(' hai test');
}
 /* public static String uidStr;
  public static List<String> idStrList=new  List<String>();
  public static   List<Integrations_Message__c> integrationMessageList=new  List<Integrations_Message__c>();
  
   public static Map<String, String> generateTestdata(String methodStr) {
        system.debug('@@ generateTestdata:start @@');
        
        Map<String, String> testdataMap = new Map<String, String>();
        if (methodStr == 'publishOrderInfo') { // NID
            testdataMap.put('NID_Order_ID', 'NID_Order_ID');
            testdataMap.put('Instance_ID', 'Instance_ID');
            testdataMap.put('NID_Action', 'NID_Action');
            testdataMap.put('Type_of_Service_Product', 'Type_of_Service_Product');
            testdataMap.put('Account_Name', 'Account_Name');
            testdataMap.put('delivery_date', '2009-07-15 06:44:00');
            testdataMap.put('Actual_delivery_date', '2011-07-15 06:44:00');
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
            testdataMap.put('Name', '111');
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
            testdataMap.put('Name', '1');
            testdataMap.put('TOM_ID__c', '2');
            testdataMap.put('Charge_kWh__c', '2.3');
            testdataMap.put('CFF_Common_Facility_Factor__c', '4');
            testdataMap.put('CurrencyISOCode', '5');
            testdataMap.put('Site_ID__c', '6');
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
        if (methodStr == 'publishSLAInfo') {
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
       
        return testdataMap;
    }
        //MEC Interface
        static testMethod void myUnitTestforMEC() 
        {   
            String methodStr='';
            //inserting integration Message Object
            Integrations_Message__c integrationMessageMECObj = new Integrations_Message__c();
            integrationMessageMECObj.Body__c='@#&%CFF_Common_Facility_Factor__c@#&%4@#&%TOM_ID__c@#&%2@#&%Charge_kWh__c'+
                                                '@#&%2.3@#&%Site_ID__c@#&%6@#&%CurrencyISOCode@#&%5@#&%Name@#&%1';
            integrationMessageMECObj.Interface_Method_Name__c='publishPricingInfoRequest';
            integrationMessageMECObj.Category__c='MEC'; 
            integrationMessageMECObj.Status__c='Failed';
            integrationMessageMECObj.UID__c='2012022500552886';
            integrationMessageMECObj.Status_Description__c='status not send';
            integrationMessageMECObj.Status_Code__c=-1;
            insert integrationMessageMECObj;
            
            String idMECStr=integrationMessageMECObj.Id;
            idStrList.add(idMECStr);
            Map<String, String> dataMap = Integrations_Utilities_Cls.generateTestdata('publishPricingInfoRequest');
            integrationMessageList.add(integrationMessageMECObj);
            Test.startTest();
            Integrations_EnergyPricingInterface_Cls.testmode=true;
            Integrations_ResendMessage_Cls.resend(idStrList);
            Test.stopTest();
            system.assertEquals(integrationMessageMECObj.Status__c, 'Failed');
            system.assertEquals(integrationMessageMECObj.Status__c, 'Failed');
         }
         
        //For NID Interface 
         static testMethod void myUnitTestNIDOrderinfo() 
        {
            //orderinfo
            Integrations_Message__c integrationMessageNidSenOrderObj=new Integrations_Message__c();
            integrationMessageNidSenOrderObj.Body__c=':!#2:!#@#&%RowType@#&%RowType@#&%Account_ID@#&%Account_ID'+
                '@#&%Type_of_Service_Product@#&%Type_of_Service_Product@#&%Account_Name@#&%Account_Name@#&%NID_Action@#&%NID_Action'+
                '@#&%Maximum_Bandwidth__Mbit_s@#&%222@#&%Desired_Routes@#&%Desired_Routes@#&%Routing_Specification@#&%Routing_Specification'+
                '@#&%Instance_ID@#&%Instance_ID@#&%NID_Order_ID@#&%NID_Order_ID@#&%Price_Model@#&%Price_Model@#&%Customers_Customer'+
                '@#&%Customers_Customer@#&%delivery_date@#&%2009-07-15 06:44:00@#&%Multicast@#&%Multicast@#&%Actual_delivery_date'+
                '@#&%2011-07-15 06:44:00@#&%Type_of_Service_MainProductGroup@#&%Type_of_Service_MainProductGroup';
            integrationMessageNidSenOrderObj.Interface_Method_Name__c='publishOrderInfo';
            integrationMessageNidSenOrderObj.Category__c='NID'; 
            integrationMessageNidSenOrderObj.Status__c='Failed';
            integrationMessageNidSenOrderObj.UID__c='201212251327500572886';
            integrationMessageNidSenOrderObj.Status_Description__c='status not send';
            integrationMessageNidSenOrderObj.Status_Code__c=-1;
            insert integrationMessageNidSenOrderObj;
            
            String idNidSenOrderStr=integrationMessageNidSenOrderObj.Id;
            idStrList.add(idNidSenOrderStr);
            Map<String, String> dataMap = Integrations_Utilities_Cls.generateTestdata('publishOrderInfo');        
            integrationMessageList.add(integrationMessageNidSenOrderObj); 
            Test.startTest();
            Integrations_NID_Cls.testmode=true;
            Integrations_ResendMessage_Cls.resend(idStrList);
            system.assertEquals(integrationMessageNidSenOrderObj.Status__c, 'Failed');
            system.assertEquals(integrationMessageNidSenOrderObj.Status__c, 'Failed');
            Test.stopTest();
    }
    
    static testMethod void myUnitTestNIDSiteInfo() 
    { 
        //site info
        Integrations_Message__c integrationMessageNidSiteInfoObj=new Integrations_Message__c();
        integrationMessageNidSiteInfoObj.Body__c=':!#1:!#@#&%Name@#&%111@#&%CRM_Site_Code__c@#&%1@#&%CRM_Status_Code__c@#&%Active';
        integrationMessageNidSiteInfoObj.Interface_Method_Name__c='publishSiteStatusInfo';
        integrationMessageNidSiteInfoObj.Category__c='NID'; 
        integrationMessageNidSiteInfoObj.Status__c='Failed';
        integrationMessageNidSiteInfoObj.UID__c='201211231327500572886';
        integrationMessageNidSiteInfoObj.Status_Description__c='status not send';
        integrationMessageNidSiteInfoObj.Status_Code__c=-1;
        insert integrationMessageNidSiteInfoObj;
        
        String idNidSiteInfoStr=integrationMessageNidSiteInfoObj.Id;
        idStrList.add(idNidSiteInfoStr);
        integrationMessageList.add(integrationMessageNidSiteInfoObj);
        Map<String, String> dataMap = Integrations_Utilities_Cls.generateTestdata('publishSiteStatusInfo'); 
        Test.startTest();
        Integrations_NID_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        Test.stopTest();
    }
    
    static testMethod void myUnitTestNIDCustomerInfo() 
    {
        //Customer Info
        Integrations_Message__c integrationMessageNidCustmerInfoObj=new Integrations_Message__c();
        integrationMessageNidCustmerInfoObj.Body__c=':!#3:!#@#&%Name@#&%mmm@#&%CRM_Account__c@#&%MrTester@#&%Tom_ID__c@#&%1111';
        integrationMessageNidCustmerInfoObj.Interface_Method_Name__c='publishCustomerInfo';
        integrationMessageNidCustmerInfoObj.Category__c='NID'; 
        integrationMessageNidCustmerInfoObj.Status__c='Failed';
        integrationMessageNidCustmerInfoObj.UID__c='201211251327886';
        integrationMessageNidCustmerInfoObj.Status_Description__c='status not send';
        integrationMessageNidCustmerInfoObj.Status_Code__c=-1;
        insert integrationMessageNidCustmerInfoObj;
        
        String idNidCustmerInfoStr=integrationMessageNidCustmerInfoObj.Id;
        idStrList.add(idNidCustmerInfoStr);
        integrationMessageList.add(integrationMessageNidCustmerInfoObj);
        test.startTest();
        Integrations_NID_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageNidCustmerInfoObj.Status__c, 'Failed');
        Test.stopTest();
    }
    static testMethod void myUnitTestSMSGateway() 
    {
        //SMSGateway
        Integrations_Message__c integrationMessagesmsgateObj=new Integrations_Message__c(); 
        integrationMessagesmsgateObj.Body__c='@#&%MSISDN No@#&%0000000000000@#&%id@#&%301105@#&%Text@#&%All your money is gone! .. Love Ragnar@#&%pwd@#&%t8ZynaR1';
        integrationMessagesmsgateObj.Interface_Method_Name__c='sendSMSRequest';
        integrationMessagesmsgateObj.Category__c='SMSGateway'; 
        integrationMessagesmsgateObj.Status__c='Failed';
        integrationMessagesmsgateObj.UID__c='20120127134556';
        integrationMessagesmsgateObj.Status_Description__c='status not send';
        integrationMessagesmsgateObj.Status_Code__c=-1;
        insert integrationMessagesmsgateObj;

        String idAnalysPSoldSeviceStr=integrationMessagesmsgateObj.Id;
        idStrList.add(idAnalysPSoldSeviceStr);
        integrationMessageList.add(integrationMessagesmsgateObj);
        test.startTest();
        Integrations_SMSGatewayInterface_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessagesmsgateObj.Status__c, 'Failed');
        test.stopTest();
    }
        
    static testMethod void oblicoreSLA() 
    {
        Integrations_Message__c integrationMessageSLAObj=new Integrations_Message__c();
        integrationMessageSLAObj.Body__c='@#&%Length_of_Contract_Months__c@#&%11@#&%CustomerIDNo@#&%2345'+
            '@#&%Customer_Signature_Date__c@#&%2009-09-15 06:44:00@#&%Type_of_service__c@#&%123@#&%Item_Main_Category__c'+
            '@#&%11@#&%Name@#&%IC Number In SFDC@#&%Revenue_End_Date__c@#&%2010-06-18 06:44:00'+
            '@#&%Item_Name__c@#&%123@#&%TOM_ID__c@#&%1171@#&%Notice_Period_Days__c@#&%100@#&%Account.Name'+
            '@#&%Account.Name@#&%Type_of_Equipment__c@#&%Type_of_Equipment__c@#&%RFS_date__c@#&%2009-07-15 06:44:00'+
            '@#&%Type_of_Contract_Abbreviation__c@#&%Type_of_Contract_Abbreviation__c@#&%Ready_For_Billing__c'+
            '@#&%2009-06-18 06:44:00';
        
        integrationMessageSLAObj.Interface_Method_Name__c='publishSLAInfo';
        integrationMessageSLAObj.Category__c='Oblicore'; 
        integrationMessageSLAObj.Status__c='Failed';
        integrationMessageSLAObj.UID__c='201713473886123';
        integrationMessageSLAObj.Status_Description__c='status not send';
        integrationMessageSLAObj.Status_Code__c=-1;
        insert  integrationMessageSLAObj;
        
        String idSLAInfoStr=integrationMessageSLAObj.Id;
        idStrList.add(idSLAInfoStr);
        integrationMessageList.add(integrationMessageSLAObj);
        test.startTest();
        Integrations_Oblicore_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageSLAObj.Status__c, 'Failed');
        test.stopTest();
    }
  static testMethod void oblicoreWaitingFalgTest() 
    {
        Integrations_Message__c integrationMessageSLAObj=new Integrations_Message__c();
        integrationMessageSLAObj.Body__c='@#&%Status@#&%Status value in SFDC@#&%Waiting start time@#&%2009-07-15 06:44:00'+
            '@#&%Waiting end time@#&%2009-07-15 06:44:00@#&%TicketNumber@#&%1234';
        
        integrationMessageSLAObj.Interface_Method_Name__c='publishIncidentInfoTicketUpdateWaitingFlag';
        integrationMessageSLAObj.Category__c='Oblicore'; 
        integrationMessageSLAObj.Status__c='Failed';
        integrationMessageSLAObj.UID__c='201713473886213';
        integrationMessageSLAObj.Status_Description__c='status not send';
        integrationMessageSLAObj.Status_Code__c=-1;
        insert  integrationMessageSLAObj;
        
        String idSLAInfoStr=integrationMessageSLAObj.Id;
        idStrList.add(idSLAInfoStr);
        integrationMessageList.add(integrationMessageSLAObj);
        test.startTest();
        Integrations_Oblicore_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageSLAObj.Status__c, 'Failed');
        test.stopTest();
    }
    static testMethod void oblicoreTicketUpdateTest() 
    {
        Integrations_Message__c integrationMessageSLAObj=new Integrations_Message__c();
        integrationMessageSLAObj.Body__c='@#&%Category@#&%Case_category__c value in SFDC@#&%TicketNumber@#&%1234';
        
        integrationMessageSLAObj.Interface_Method_Name__c='publishIncidentInfoTicketUpdateCategory';
        integrationMessageSLAObj.Category__c='Oblicore'; 
        integrationMessageSLAObj.Status__c='Failed';
        integrationMessageSLAObj.UID__c='20171347388621312331';
        integrationMessageSLAObj.Status_Description__c='status not send';
        integrationMessageSLAObj.Status_Code__c=-1;
        insert  integrationMessageSLAObj;
        
        String idSLAInfoStr=integrationMessageSLAObj.Id;
        idStrList.add(idSLAInfoStr);
        integrationMessageList.add(integrationMessageSLAObj);
        test.startTest();
        Integrations_Oblicore_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageSLAObj.Status__c, 'Failed');
        test.stopTest();
    }   
    static testMethod void oblicoreRFSTest() 
    {
        Integrations_Message__c integrationMessageSLAObj=new Integrations_Message__c();
        integrationMessageSLAObj.Body__c='@#&%RFS@#&%2009-07-15 06:44:00@#&%Outage Reason@#&%Reason_for_outage__c  value in SFDC'+
                                            '@#&%TicketNumber@#&%1234';
        
        integrationMessageSLAObj.Interface_Method_Name__c='publishIncidentInfoTicketUpdateRFS';
        integrationMessageSLAObj.Category__c='Oblicore'; 
        integrationMessageSLAObj.Status__c='Failed';
        integrationMessageSLAObj.UID__c='201203241332581812456';
        integrationMessageSLAObj.Status_Description__c='status not send';
        integrationMessageSLAObj.Status_Code__c=-1;
        insert  integrationMessageSLAObj;
        
        String idSLAInfoStr=integrationMessageSLAObj.Id;
        idStrList.add(idSLAInfoStr);
        integrationMessageList.add(integrationMessageSLAObj);
        test.startTest();
        Integrations_Oblicore_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageSLAObj.Status__c, 'Failed');
        test.stopTest();
    }
    static testMethod void oblicoreServiceAffectingTest() 
    {
        Integrations_Message__c integrationMessageSLAObj=new Integrations_Message__c();
        integrationMessageSLAObj.Body__c='@#&%Service affecting start time@#&%2009-07-15 06:44:00@#&%Service affecting end time'+
                                            '@#&%2009-07-15 06:44:00@#&%Service affecting@#&%2009-07-15 06:44:00@#&%TicketNumber@#&%1234';
        
        integrationMessageSLAObj.Interface_Method_Name__c='publishIncidentInfoTicketUpdateServiceAffecting';
        integrationMessageSLAObj.Category__c='Oblicore'; 
        integrationMessageSLAObj.Status__c='Failed';
        integrationMessageSLAObj.UID__c='201203241332581812456';
        integrationMessageSLAObj.Status_Description__c='status not send';
        integrationMessageSLAObj.Status_Code__c=-1;
        insert  integrationMessageSLAObj;
        
        String idSLAInfoStr=integrationMessageSLAObj.Id;
        idStrList.add(idSLAInfoStr);
        integrationMessageList.add(integrationMessageSLAObj);
        test.startTest();
        Integrations_Oblicore_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageSLAObj.Status__c, 'Failed');
        test.stopTest();
    }
    static testMethod void oblicoreNewTicketTest() 
    {
        Integrations_Message__c integrationMessageSLAObj=new Integrations_Message__c();
        integrationMessageSLAObj.Body__c='@#&%Ticket Description@#&%2009-07-15 06:44:00@#&%Voice service@#&%Voice_service__c value in sfdc'+
                '@#&%Customer No@#&%CustomerID value in sfdc@#&%Service affecting@#&%Service_Affecting__c value in sfdc'+
                '@#&%OpStartTime@#&%2009-07-15 06:44:00@#&%Registered@#&%2009-07-15 06:44:00@#&%SoldServiceID@#&%SSID__c value in sfdc'+
                '@#&%RealDestination@#&%Destination value in sfdc@#&%TicketNumber@#&%1234';
        
        integrationMessageSLAObj.Interface_Method_Name__c='publishIncidentInfoNewTicket';
        integrationMessageSLAObj.Category__c='Oblicore'; 
        integrationMessageSLAObj.Status__c='Failed';
        integrationMessageSLAObj.UID__c='201203241332581812456';
        integrationMessageSLAObj.Status_Description__c='status not send';
        integrationMessageSLAObj.Status_Code__c=-1;
        insert  integrationMessageSLAObj;
        
        String idSLAInfoStr=integrationMessageSLAObj.Id;
        idStrList.add(idSLAInfoStr);
        integrationMessageList.add(integrationMessageSLAObj);
        test.startTest();
        Integrations_Oblicore_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageSLAObj.Status__c, 'Failed');
        test.stopTest();
    }   
    
    static testMethod void nidRequestfullTest() 
    {
        Integrations_Message__c integrationMessageNIDObj=new Integrations_Message__c();
        integrationMessageNIDObj.Body__c='@#&%ServiceID@#&%1111@#&%CaseJobName@#&%@#&%Inventory_Information__c.Name@#&%A-0315@#&%CaseNumber@#&%00024773';
        
        integrationMessageNIDObj.Interface_Method_Name__c='InventoryInformationRequestFullType';
        integrationMessageNIDObj.Category__c='NID'; 
        integrationMessageNIDObj.Status__c='Failed';
        integrationMessageNIDObj.UID__c='201203241332581812456';
        integrationMessageNIDObj.Status_Description__c='status not send';
        integrationMessageNIDObj.Status_Code__c=-1;
        insert  integrationMessageNIDObj;
        
        String idNIDInfoStr=integrationMessageNIDObj.Id;
        idStrList.add(idNIDInfoStr);
        integrationMessageList.add(integrationMessageNIDObj);
        test.startTest();
        Integrations_INCA_SFDC_Request_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageNIDObj.Status__c, 'Failed');
        test.stopTest();
    }
    static testMethod void nidRequestPartialTest() 
    {
        Integrations_Message__c integrationMessageNIDObj=new Integrations_Message__c();
        integrationMessageNIDObj.Body__c='@#&%ServiceID@#&%2222@#&%Inventory_Information__c.Name@#&%A-0316@#&%CaseJob.Name@#&%1@#&%CaseNumber@#&%';
        integrationMessageNIDObj.Interface_Method_Name__c='InventoryInformationRequestPartialType';
        integrationMessageNIDObj.Category__c='NID'; 
        integrationMessageNIDObj.Status__c='Failed';
        integrationMessageNIDObj.UID__c='201203241332581812456';
        integrationMessageNIDObj.Status_Description__c='status not send';
        integrationMessageNIDObj.Status_Code__c=-1;
        insert  integrationMessageNIDObj;
        
        String idNIDInfoStr=integrationMessageNIDObj.Id;
        idStrList.add(idNIDInfoStr);
        integrationMessageList.add(integrationMessageNIDObj);
        test.startTest();
        Integrations_INCA_SFDC_Request_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageNIDObj.Status__c, 'Failed');
        test.stopTest();
    }   
    static testMethod void nidImpactAnalysisAffectedServicesRequestTest() 
    {
        Integrations_Message__c integrationMessageNIDObj=new Integrations_Message__c();
        integrationMessageNIDObj.Body__c='@#&%Action@#&%Restore@#&%SystemID@#&%NYKEB-NYKEC FYS06@#&%RestoreLogID@#&%1@#&%CaseNumber@#&%1';
        
        integrationMessageNIDObj.Interface_Method_Name__c='ImpactAnalysisAffectedServicesRequest';
        integrationMessageNIDObj.Category__c='NID'; 
        integrationMessageNIDObj.Status__c='Failed';
        integrationMessageNIDObj.UID__c='201203241332581812456';
        integrationMessageNIDObj.Status_Description__c='status not send';
        integrationMessageNIDObj.Status_Code__c=-1;
        insert  integrationMessageNIDObj;
        
        String idNIDInfoStr=integrationMessageNIDObj.Id;
        idStrList.add(idNIDInfoStr);
        integrationMessageList.add(integrationMessageNIDObj);
        test.startTest();
        Integrations_ImpctAnalysAffectServic_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageNIDObj.Status__c, 'Failed');
        test.stopTest();
    }   
    static testMethod void nidImpactAnalysisAffectedSystemRequestNETest() 
    {
        Integrations_Message__c integrationMessageNIDObj=new Integrations_Message__c();
        integrationMessageNIDObj.Body__c='@#&%Status@#&%Restore@#&%NE_Signature__c@#&%NE_Signature__c@#&%NE_Site_T__c OR NE_Type__c@#&%NE_Site_T__c OR NE_Type__c@#&%NE_T__c@#&%NE_T__c@#&%CaseNumber@#&%112';
        integrationMessageNIDObj.Interface_Method_Name__c='ImpactAnalysisAffectedSystemRequestFromNE';
        integrationMessageNIDObj.Category__c='NID'; 
        integrationMessageNIDObj.Status__c='Failed';
        integrationMessageNIDObj.UID__c='201203241332581812456';
        integrationMessageNIDObj.Status_Description__c='status not send';
        integrationMessageNIDObj.Status_Code__c=-1;
        insert  integrationMessageNIDObj;
        
        String idNIDInfoStr=integrationMessageNIDObj.Id;
        idStrList.add(idNIDInfoStr);
        integrationMessageList.add(integrationMessageNIDObj);
        test.startTest();
        Integrations_ImpactAnalysAffectSystm_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageNIDObj.Status__c, 'Failed');
        test.stopTest();
    }
    static testMethod void nidImpactAnalysisAffectedSystemRequestSiteTest() 
    {
        Integrations_Message__c integrationMessageNIDObj=new Integrations_Message__c();
        integrationMessageNIDObj.Body__c='@#&%Status@#&%Restore@#&%CaseNumber@#&%112@#&%SiteId@#&%123';
        integrationMessageNIDObj.Interface_Method_Name__c='ImpactAnalysisAffectedSystemRequestFromSite';
        integrationMessageNIDObj.Category__c='NID'; 
        integrationMessageNIDObj.Status__c='Failed';
        integrationMessageNIDObj.UID__c='201203241332581812456';
        integrationMessageNIDObj.Status_Description__c='status not send';
        integrationMessageNIDObj.Status_Code__c=-1;
        insert  integrationMessageNIDObj;
        
        String idNIDInfoStr=integrationMessageNIDObj.Id;
        idStrList.add(idNIDInfoStr);
        integrationMessageList.add(integrationMessageNIDObj);
        test.startTest();
        Integrations_ImpactAnalysAffectSystm_Cls.testmode=true;
        Integrations_ResendMessage_Cls.resend(idStrList);
        system.assertEquals(integrationMessageNIDObj.Status__c, 'Failed');
        test.stopTest();
    }*/                       
}