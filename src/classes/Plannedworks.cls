global class Plannedworks
{
/*
public class ValidationException extends Exception {}
    
  public static List<Integrations_AnalysP_PlannedW_Data_Cls.plannedWorksInformation> create(List<Integrations_AnalysP_PlannedW_Data_Cls.plannedWorksInformation> plannedWorksInfo) {
           
    Integrations_AnalysP_PlannedW_Data_Cls.plannedWorksInformation obj = new Integrations_AnalysP_PlannedW_Data_Cls.plannedWorksInformation();
    obj.FAILED_REASON       = new String[]{};
    Integer countInsertsInt   = 0; 
    Integer failedRecordsInt   = 0;
    String planWorkIdStr     = '';

    List<Planned_Works__c> plannedWorksUpsertList          = new List<Planned_Works__c> ();
    List<Planned_Works__c> plannedWorksList              = new List<Planned_Works__c> ();        
    List<Planned_Works__c> PlannedWorksobjectList           = new List<Planned_Works__c> ();  
    List<CRM_Planned_Works_Junction__c> PlannedJunctionDeleteList   = new List<CRM_Planned_Works_Junction__c> (); 

    List<Sold_Service__c> SoldServicesList   = new List<Sold_Service__c> ();   
    List<String> soldServiceNamesList     = new List<String>();
  
    List<String> PlannedWorksNamesStringList   = new List<String> ();   
    List<String> planWorkInfoNameList       = new List<String>(); 
    List<String> planWorkInfoNameDeleteList   = new List<String>();
    List<Id> PlannedWorksIDs           = new List<Id>();

    Map<String, List<String>> SSListMap     = new  Map<String, List<String>>();
    Map<String, ID> SoldServiceMap        = new  Map<String, ID>();
    Map<String, Planned_Works__c> mapSetPWId   = new Map<String, Planned_Works__c>();

    Set<String> SoldServicesSet     = new Set<String>();  
    Set<String> SSIDList        = new Set<String>(); 
    Set<String> planWorkInfoNamesSet   = new Set<String>();

    Planned_Works__c plannedWorkNewObj   = new Planned_Works__c ();

    //Getting all information here from SOAP request
    for (Integrations_AnalysP_PlannedW_Data_Cls.plannedWorksInformation plannedWorksInfoObj : plannedWorksInfo) {
      SSIDList.addAll(plannedWorksInfoObj.SoldServiceList);     
      planWorkInfoNameList.add((plannedWorksInfoObj.plannedWorksObj).name);
    }

    //Querying all sold services those are there in SFDC
    List<Sold_Service__c> SSList1 = [Select Name, ssid__c, Id From Sold_Service__c where SSID__c IN: SSIDList];

    //Getting all PlannedWorks Objects into a list based on the PlannedWorks Names in SOAP Request
    plannedWorksList = [select Name, Start_Date__c, End_Date__c, Cause__c, Impacted_Platform__c, Action_and_Reason__c, Responsible_Centre__c, Location__c, Scope_of_Work__c from Planned_Works__c where Name IN :planWorkInfoNameList];

    for(Planned_Works__c pwExistingNamesList :plannedWorksList) {
      PlannedWorksNamesStringList.add(pwExistingNamesList.name);
      mapSetPWId.put(pwExistingNamesList.Name, pwExistingNamesList);                 
    }

    //Preparing a Set with all PlannedWorks Names so that while iterating over all Plannedorks we can check
    planWorkInfoNamesSet.addAll(PlannedWorksNamesStringList);                     
                                        
    for (Integrations_AnalysP_PlannedW_Data_Cls.plannedWorksInformation plannedWorksInfoObj : plannedWorksInfo) {
      //Checking whether each PlannedWork Name from SOAP is existing in Set or not
      if (planWorkInfoNamesSet.contains((plannedWorksInfoObj.plannedWorksObj).Name)) {                                                
        
        //This Planned Work Object is already existing in SFDC,so update is needed
        plannedWorkNewObj = new Planned_Works__c(id=(mapSetPWId.get((plannedWorksInfoObj.plannedWorksObj).Name).id)); 
        plannedWorkNewObj.End_Date__c = (plannedWorksInfoObj.plannedWorksObj).End_Date__c; 
        plannedWorkNewObj.Cause__c = (plannedWorksInfoObj.plannedWorksObj).Cause__c; 
        plannedWorkNewObj.Impacted_Platform__c = (plannedWorksInfoObj.plannedWorksObj).Impacted_Platform__c;  
        plannedWorkNewObj.Action_and_Reason__c = (plannedWorksInfoObj.plannedWorksObj).Action_and_Reason__c; 
        plannedWorkNewObj.Responsible_Centre__c = (plannedWorksInfoObj.plannedWorksObj).Responsible_Centre__c; 
        plannedWorkNewObj.Location__c = (plannedWorksInfoObj.plannedWorksObj).Location__c; 
        plannedWorkNewObj.Scope_of_Work__c = (plannedWorksInfoObj.plannedWorksObj).Scope_of_Work__c; 
        plannedWorkNewObj.Start_Date__c = (plannedWorksInfoObj.plannedWorksObj).Start_Date__c; 
        
        if((plannedWorksInfoObj.plannedWorksObj).ActionType__c =='C')
        {
          system.debug('@@@@@@@'+plannedWorkNewObj.ActionType__c);
          plannedWorkNewObj.Status__c  = 'Cancel';    
          system.debug('@@@@@@@plannedWorkNewObj.Status__c'+plannedWorkNewObj.Status__c);    
        }
        //Adding updated PlannedWorks Object to a Upsert list
        plannedWorksUpsertList.add(plannedWorkNewObj);
    
        //The following manipulation is for eliminating duplicate SSIDs in List
        Set<String> SoldServicesUniqueOldSet = new Set<String>();  
        SoldServicesUniqueOldSet.addAll(plannedWorksInfoObj.SoldServiceList);
        (plannedWorksInfoObj.SoldServiceList).clear();
        (plannedWorksInfoObj.SoldServiceList).addAll(SoldServicesUniqueOldSet);
                            
        //Creating a Map with PlannedWork name and associated SoldServices List
        SSListMap.put((plannedWorksInfoObj.plannedWorksObj).Name, plannedWorksInfoObj.SoldServiceList);
        soldServiceNamesList.addAll(plannedWorksInfoObj.SoldServiceList);

        for(Integer existingSSidInt = 0;existingSSidInt < SSList1.size(); existingSSidInt++) {
          SoldServicesSet.add(SSList1[existingSSidInt].SSID__c);
        }

        //Checking each sold service Id is there in set of existing SSIDs
        for(Integer ssidInt = 0; ssidInt<plannedWorksInfoObj.SoldServiceList.size(); ssidInt++) {
          if (!SoldServicesSet.contains(plannedWorksInfoObj.SoldServiceList[ssidInt])) {
            if (plannedWorksInfoObj.SoldServiceList[ssidInt] == '' || plannedWorksInfoObj.SoldServiceList[ssidInt] == null)  {
              obj.FAILED_REASON.add('Sold Service ID is Null for Planned Work Name \'' + (plannedWorksInfoObj.plannedWorksObj).Name + '\'');
            }                        
            else {
              obj.FAILED_REASON.add('Sold Service ID \'' + plannedWorksInfoObj.SoldServiceList[ssidInt] + '\' is not found in SFDC for Planned Work Name \'' + (plannedWorksInfoObj.plannedWorksObj).Name + '\'');
            }                                                
          }
        }                                         
      }
      else {
        // This Planned Work Object is not there in SFDC,so creating whole new object  
        Planned_Works__c newPlannedWorksObj = new Planned_Works__c (Name = (plannedWorksInfoObj.plannedWorksObj).Name, 
          Start_Date__c = (plannedWorksInfoObj.plannedWorksObj).Start_Date__c, 
          End_Date__c = (plannedWorksInfoObj.plannedWorksObj).End_Date__c,
          Cause__c = (plannedWorksInfoObj.plannedWorksObj).Cause__c,
          Impacted_Platform__c = (plannedWorksInfoObj.plannedWorksObj).Impacted_Platform__c, 
          Action_and_Reason__c = (plannedWorksInfoObj.plannedWorksObj).Action_and_Reason__c,
          Responsible_Centre__c = (plannedWorksInfoObj.plannedWorksObj).Responsible_Centre__c,
          Location__c = (plannedWorksInfoObj.plannedWorksObj).Location__c,
          Scope_of_Work__c = (plannedWorksInfoObj.plannedWorksObj).Scope_of_Work__c);
          if(newPlannedWorksObj.ActionType__c =='C')
          {
            newPlannedWorksObj.Status__c='Cancel';        
          }
        // Adding new PlannedWorks Object to a Upsert list
        plannedWorksUpsertList.add(newPlannedWorksObj);

        // The following manipulation is for eliminating duplicate SSIDs in List
        Set<String> SoldServicesUniqueNewSet = new Set<String> ();  
        SoldServicesUniqueNewSet.addAll(plannedWorksInfoObj.SoldServiceList);
        (plannedWorksInfoObj.SoldServiceList).clear();
        (plannedWorksInfoObj.SoldServiceList).addAll(SoldServicesUniqueNewSet);
  
        SSListMap.put((plannedWorksInfoObj.plannedWorksObj).Name, plannedWorksInfoObj.SoldServiceList);
        // Adding sold services list to single soldService List
        soldServiceNamesList.addAll(plannedWorksInfoObj.SoldServiceList);

        for(Integer existingSSidInt = 0; existingSSidInt < SSList1.size(); existingSSidInt++) {
          SoldServicesSet.add(SSList1[existingSSidInt].SSID__c);
        }
        
        //Checking each sold service Id is there in set of existing SSIDs
        for(Integer ssidInt = 0; ssidInt<plannedWorksInfoObj.SoldServiceList.size(); ssidInt++) {
          if (!SoldServicesSet.contains(plannedWorksInfoObj.SoldServiceList[ssidInt])) {
            if (plannedWorksInfoObj.SoldServiceList[ssidInt] == '' || plannedWorksInfoObj.SoldServiceList[ssidInt] == null)  {
              obj.FAILED_REASON.add('Sold Service ID is Null for Planned Work Name \'' + (plannedWorksInfoObj.plannedWorksObj).Name + '\'');                          
            }                        
            else {
              obj.FAILED_REASON.add('Sold Service ID ' + plannedWorksInfoObj.SoldServiceList[ssidInt] + ' is not found in SFDC for Planned Work Name ' + (plannedWorksInfoObj.plannedWorksObj).Name);
            }                        
          }
        }                                      
      } 
    }
    
    try {
      Set<Planned_Works__c> setPlannedWorks = new Set<Planned_Works__c>();
      setPlannedWorks.addAll(plannedWorksUpsertList);
      plannedWorksUpsertList = new List<Planned_Works__c>();
      plannedWorksUpsertList.addAll(setPlannedWorks);
            
      // Performing an upsert operaion for PlannedWorks on SFDC
      upsert plannedWorksUpsertList;

      PlannedWorksIDs = new List<Id>();
      PlannedWorksobjectList = new List<Planned_Works__c>();                     
      plannedWorksList = [select name from Planned_Works__c where Name IN :planWorkInfoNameList];

      for(Planned_Works__c plannedObj : plannedWorksList) {                            
        PlannedWorksIDs.add(plannedObj.id);
      }

      // Selecting all junction objects which are related to PlannedWorks in SOAP message
      PlannedJunctionDeleteList = [Select Id, Name from CRM_Planned_Works_Junction__c WHERE Planned_Work__c IN : PlannedWorksIDs];
      
      // Performing delete operation on junction object,so that it will delete all existing relationships of SoldServices
      delete PlannedJunctionDeleteList;
      
      SoldServiceMap = new map<String,Id>();

      // Selecting SoldServices object list from the above single Sold Services List
      SoldServicesList = [select name, SSID__c from Sold_Service__c where SSID__c IN :soldServiceNamesList];   
      for (Sold_Service__c soldServiceObj : SoldServicesList) {
        // Preparing a Map with SSID and SoldService Id this Map will be used while linking PlannedWorks and SoldServices
        SoldServiceMap.put(soldServiceObj.SSID__c, soldServiceObj.id);                
      }

      obj.Operation_String = 'Total Number of Planned Works Inserted/Updated : '+ String.valueOf(plannedWorksUpsertList.size()); 
    }
    catch(Exception e) {
      obj.FAILED_REASON.add('Error in Planned Works ' + e);
    }
    
    List<CRM_Planned_Works_Junction__c> PWSSList1 = new List<CRM_Planned_Works_Junction__c>(); 
    // Creating a List that contains PlannedWorks Names From SOAP message
    List<String> planWorkIdList = new List<String>(SSListMap.keySet());                  
    for(Planned_Works__c plannedObj : plannedWorksList) {
      List<String> ssNewList = SSListMap.get(plannedObj.Name); 
      if (ssNewList != null) {
        for(Integer iInt = 0; iInt < ssNewList.size(); iInt++) {
          CRM_Planned_Works_Junction__c PWSS1 = new CRM_Planned_Works_Junction__c();
          PWSS1.Planned_Work__c = plannedObj.Id;                        
          PWSS1.Sold_Service__c = SoldServiceMap.get((ssNewList.get(iInt)));          
          PWSSList1.add(PWSS1);               
        }   
      }
    }

    try {
      Database.saveResult[] sr = Database.insert(PWSSList1, false);                 
    }
    catch(Exception e) {
      obj.FAILED_REASON.add('Error when inserting to DB: ' + e);
    }

    plannedWorksInfo = new List<Integrations_AnalysP_PlannedW_Data_Cls.plannedWorksInformation>();  
    plannedWorksInfo.add(obj);
    
    try {
      Messaging.SingleEmailMessage mail  = new Messaging.SingleEmailMessage();
      String email             = System.label.AnalysP_Job_Reports;
      String[] toAddresses         = email.split(',', 0);
      mail.setToAddresses(toAddresses);
      Date myDate              = Date.Today();
      String sDate             = String.valueOf(myDate);
      mail.setSubject('AnalysP Report ' + sDate);
      obj.Operation_String         = 'Total Number of Planned Works Inserted/Updated: '+ String.valueOf(plannedWorksUpsertList.size());  
      mail.setHtmlBody(obj.Operation_String);
      Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    catch(Exception e) {
      obj.FAILED_REASON.add('Email body size too large: '+ e);
    }

    return  plannedWorksInfo;
  }
*/
}