global class SLAViolationTckt
{
/*
global with sharing class Integrations_SLAViolationTicket_Cls {

  global static Integrations_SLAViolationTicket_Data_Cls.SLAViolationTicketDataCls createSLAticket(Integrations_SLAViolationTicket_Data_Cls.SLAViolationTicketDataCls sv) {   
    sv.FAILED_REASON      = new String[]{};
    List<String> tomIDList     = new List<String>();
      List<String> ssidList     = new List<String>();
    Boolean isFail         = false;
    Sold_Service__c soldService = new Sold_Service__c();
    Account account       = new Account();
  
    // Ideally no need to validate this, this record type should always be present in SFDC
    RecordType recObj = [Select r.SobjectType, r.Name, r.Id From RecordType r where  r.SobjectType='case' and r.Name='SLA' limit 1];
  
    // Commented by Stanley - Changes as per the new Design - 8-Feb-2012
      // Uncommented by Stanley - Changes as per changes in the new design - 15-Feb-2012
    try {
      if (sv.caseRecord.SSID__c != null) {
        soldService = [Select Id, SSID__c from Sold_Service__c where SSID__c =: sv.caseRecord.SSID__c limit 1];
      }
    }
    catch (QueryException qe) {
      sv.FAILED_REASON.add('Sold Service ID not present in SFDC');
      isFail = true;
    }
  
    // We still want to do the Account check because the message should display all the errors present in the message
    try {
      if (sv.caseRecord.Customer_ID__c != null && sv.caseRecord.Customer_ID__c != '') {
        account = [Select Id, TOM_ID__c from Account where TOM_ID__c =:sv.caseRecord.Customer_ID__c limit 1];
      }
      else {
        sv.FAILED_REASON.add('Customer Id Mandatory.');
        isFail = true;
      }
    }
    catch (QueryException qe) {
      sv.FAILED_REASON.add('Account Id not present in SFDC.');
      isFail = true;
    }
  
    if (isFail != true) {
      Case caseObj           = new Case();
          caseObj.AccountId         = account.id;
          caseObj.SSID__c         = soldService.id;
          caseObj.Customer_ID__c       = sv.caseRecord.Customer_ID__c;      
          caseObj.Real_Destination__c    = sv.caseRecord.Real_Destination__c;
          caseObj.Description       = sv.caseRecord.Description;
          caseObj.RecordTypeId       = recObj.Id;
          caseObj.Priority         = 'High';
          caseObj.Origin           = 'Oblicore';
          caseObj.IsVisibleInSelfService  = false;
          caseObj.OwnerId         = [Select Id, SobjectType, QueueId, Queue.Name From QueueSobject where SobjectType = 'Case' AND Queue.Name like '%Oblicore Alarms Queue%' limit 1].QueueId;
         
          try {
        insert caseObj;
        String caseNumber   = [Select CaseNumber From Case  where Id =: caseObj.Id].CaseNumber;
              sv.Operation_String = 'Case successfully created with number : ' + caseNumber;
      }
      catch (Exception e) {
              // Should never enter this block
              sv.FAILED_REASON.add(String.valueOf(e));
      }
    }
      
    // Returning it as null, so that IPL does not get the same message back    
    return sv;  
  }
}
*/
}