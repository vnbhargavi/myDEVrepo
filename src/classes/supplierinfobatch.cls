global class supplierinfobatch
{
/*
global with sharing class Integrations_SupplierInfoBatch_Cls {  

    public class ValidationException extends Exception {}   
      
    global static list<Integrations_SupplierInfoBatch_Data.SupplierInformationBatch> upsertSupplierContactInfo(list<Integrations_SupplierInfoBatch_Data.SupplierInformationBatch> supplierinformationbatch){
   
        System.debug('@@ Entering into Integrations_SupplierInfoBatch_Cls.upsertSupplierContactInfo @@');
        
        Integrations_SupplierInfoBatch_Data.SupplierInformationBatch batchobj= new Integrations_SupplierInfoBatch_Data.SupplierInformationBatch();
        Integer countAccountInsertsInt = 0; 
        Integer countContactInsertsInt=0;
        Integer failedRecordsInt = 0;
         
        batchobj.FAILED_REASON=new String[]{};
        boolean valuefound=true; 
        list<String> accountIDList= new list<String>();
        list<Contact> contactObjList= new list<Contact>();
        list<Account> accountUpsertList = new list<Account>();
        
        Map<Integer,String> accountsNetowrkIdMap= new map<Integer,String>();
        Map<Integer,Contact> contactsNetworkIDMap= new map<Integer,Contact>();
        Map<String,Account> accountsNewMap= new Map<String,Account>();
        Map<Id,Id> accContactIdsMap= new Map<Id,Id>();    
        
        set<Integer> NetworkIDSet= new set<Integer>();
        set<Integer> networkIDExistSet= new set<Integer>();     
        set<String> accountobjSet= new set<String>();
        set<Id> contactobjSet= new set<Id>();
        set<Account> accountSet= new set<Account>();
        set<Contact> contactSet = new set<Contact>();
        
        Id RecordTypeIdContact=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Supplier').getRecordTypeId();
        Id RecordTypeIdAccount=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Supplier').getRecordTypeId();

        for(Integrations_SupplierInfoBatch_Data.SupplierInformationBatch supplierinfobatchvar:supplierinformationbatch)
        {
          //Checking if all mandatory fields are there or not
            if((supplierinfobatchvar.AdditionalInfo==''||supplierinfobatchvar.AdditionalInfo==null)||
          (supplierinfobatchvar.Address==''||supplierinfobatchvar.Address==null)||(supplierinfobatchvar.Webpage==''||supplierinfobatchvar.Webpage==null)
          ||(supplierinfobatchvar.NetworkProvider==''||supplierinfobatchvar.NetworkProvider==null)||(String.valueOf(supplierinfobatchvar.NetworkProviderID)== ''||supplierinfobatchvar.NetworkProviderID==null)
          ||(supplierinfobatchvar.ContactTel==''||supplierinfobatchvar.ContactTel==null)||(supplierinfobatchvar.EmailAddress==''||supplierinfobatchvar.EmailAddress==null)
          ||(supplierinfobatchvar.InternationalTel==''||supplierinfobatchvar.InternationalTel==null)
          ||(supplierinfobatchvar.SupportTel==''||supplierinfobatchvar.SupportTel==null))
          {
            batchobj.FAILED_REASON.add('Mandatory field is missing');
            failedRecordsInt++;
          }
          else
          {
            //putting all network Inventory Ids in a Set
            NetworkIDSet.add(supplierinfobatchvar.NetworkProviderID);
          }
        }
        //making list of accounts with network Inventory Ids 
        list<Account> accountlist=[Select id ,Name,RecordtypeId,Inventory_Network_Provider_Id__c from Account where Inventory_Network_Provider_Id__c IN:NetworkIDSet and RecordtypeId=:RecordTypeIdAccount];
        
        for(Account accountvar:accountlist)
        {
            accountIDList.add(accountvar.Id);   
            accountsNetowrkIdMap.put(Integer.valueof(accountvar.Inventory_Network_Provider_Id__c),accountvar.id);
        }
        accountobjSet.addAll(accountIDList);
        
        list<Contact> contactlist=[Select c.LastName,c.RecordtypeId, c.Inventory_Support_Phone__c, c.Inventory_International_Phone__c, c.Inventory_Contact_Phone__c, c.Email, c.AccountId From Contact c where c.RecordtypeId=:RecordTypeIdContact and c.AccountId IN:accountIDList];
        
        //Creating Map of Account Id and Contact Id ,Creating Set of Account Ids
        for(Contact conObj:contactlist)
        {
            accContactIdsMap.put(conObj.accountId,conObj.Id);
            contactobjSet.add(conObj.accountId);
        }
        networkIDExistSet.addAll(accountsNetowrkIdMap.keyset());
        //iterating over all elements here
        for(Integrations_SupplierInfoBatch_Data.SupplierInformationBatch supplierinfobatchvarnew:supplierinformationbatch)
        {
            //Checking whether each Network ID from SOAP is existing in Set or not
            if(networkIDExistSet.contains(supplierinfobatchvarnew.NetworkProviderID))
            {
                    Account accountobj= new Account(Id=(accountsNetowrkIdMap.get(supplierinfobatchvarnew.NetworkProviderID)));
                    accountobj.Inventory_Add_Info__c=supplierinfobatchvarnew.AdditionalInfo;
                    accountobj.Inventory_Address__c=supplierinfobatchvarnew.Address;
                    accountobj.Website=supplierinfobatchvarnew.Webpage;
                    accountUpsertList.add(accountobj);
                    accountsNewMap.put(accountobj.id,accountobj);
                //If for an Account contact exists,we have to do update 
                if(contactobjSet.Contains(accountobj.Id))
                {
                    Contact contactobj= new Contact(Id=accContactIdsMap.get(accountobj.Id));
                    contactobj.Inventory_Contact_Phone__c=supplierinfobatchvarnew.ContactTel;
                    contactobj.Email=supplierinfobatchvarnew.EmailAddress;
                    contactobj.RecordTypeId=RecordTypeIdContact;
                    contactobj.Inventory_International_Phone__c=supplierinfobatchvarnew.InternationalTel;
                    contactobj.Inventory_Support_Phone__c=supplierinfobatchvarnew.SupportTel;
                    contactObjList.add(contactobj); 
                }
                //If for an Account contact does not exists,we have to do insert            
                else
                {
                    Contact contactobj= new Contact();
                    contactobj.lastname = supplierinfobatchvarnew.NetworkProvider;                  
                    contactobj.AccountId= accountobj.Id;
                    contactobj.RecordTypeId=RecordTypeIdContact;
                    contactobj.Inventory_Contact_Phone__c=supplierinfobatchvarnew.ContactTel;
                    contactobj.Email=supplierinfobatchvarnew.EmailAddress;
                    contactobj.Inventory_International_Phone__c=supplierinfobatchvarnew.InternationalTel;
                    contactobj.Inventory_Support_Phone__c=supplierinfobatchvarnew.SupportTel;
                    contactObjList.add(contactobj);
                }
            }
                //If the Network Id is not found in SFDC, create a new Account and Contact Record in Salesforce
                else 
                {
                  if(NetworkIDSet.contains(supplierinfobatchvarnew.NetworkProviderID))
                  {
                      Account accountobjnew= new Account();
                      accountobjnew.Name=supplierinfobatchvarnew.NetworkProvider;
                      accountobjnew.Inventory_Network_Provider_Id__c=supplierinfobatchvarnew.NetworkProviderID;
                      accountobjnew.Inventory_Add_Info__c=supplierinfobatchvarnew.AdditionalInfo;
                      accountobjnew.RecordTypeId=RecordTypeIdAccount;
                      accountobjnew.Inventory_Address__c=supplierinfobatchvarnew.Address;
                      accountobjnew.Website=supplierinfobatchvarnew.Webpage;
                      accountUpsertList.add(accountobjnew);
                                          
                      Contact contactnewobj= new Contact();
                      contactnewobj.LastName=supplierinfobatchvarnew.NetworkProvider;
                      contactnewobj.RecordTypeId=RecordTypeIdContact;
                      contactnewobj.Inventory_Contact_Phone__c=supplierinfobatchvarnew.ContactTel;
                      contactnewobj.Email=supplierinfobatchvarnew.EmailAddress;
                      contactnewobj.Inventory_International_Phone__c=supplierinfobatchvarnew.InternationalTel;
                      contactnewobj.Inventory_Support_Phone__c=supplierinfobatchvarnew.SupportTel;
                      contactsNetworkIDMap.put(Integer.ValueOf(accountobjnew.Inventory_Network_Provider_Id__c),contactnewobj);
                  }
                }
        }
                    accountSet.addAll(accountUpsertList);
                    accountUpsertList= new List<Account>();
                    accountUpsertList.addAll(accountSet);
                try
                {
                    //Upserting account records here
                        Database.UpsertResult[] upsertresult = Database.upsert(accountUpsertList,false);
                        for(Database.UpsertResult databasereult:upsertresult)
                        {
                          if(!databasereult.isSuccess())
                          {
                              Database.Error errorresult = databasereult.getErrors()[0]; 
                              batchobj.FAILED_REASON.add('Error in DB operation  for Accounts' +errorresult.getStatusCode()+' '+errorresult.getMessage());
                          }
                        }
                    countAccountInsertsInt=accountUpsertList.size()-failedRecordsInt; 
                    for(Account accObj:accountUpsertList)
                    {
                        if((contactsNetworkIDMap.keyset()).contains(Integer.ValueOf(accObj.Inventory_Network_Provider_Id__c)))
                        {
                        Contact conObj   = contactsNetworkIDMap.get(Integer.ValueOf(accObj.Inventory_Network_Provider_Id__c));
                        conObj.AccountId = accObj.id;
                        contactObjList.add(conObj); 
                        }                   
                    }
                    contactSet.addAll(contactObjList);  
                    contactObjList= new list<Contact>();
                    contactObjList.addAll(contactSet);
                    //Upserting contact records here
                    Database.UpsertResult[] upsertresult1 = Database.upsert(contactObjList,false);
                    for(Database.UpsertResult databasereult:upsertresult1)
                        {
                          if(!databasereult.isSuccess())
                          {
                              Database.Error errorresult = databasereult.getErrors()[0]; 
                              batchobj.FAILED_REASON.add('Error in DB operation for Contacts' +errorresult.getStatusCode()+' '+errorresult.getMessage());
                          }
                        }
                    countContactInsertsInt=contactObjList.size()-failedRecordsInt;
                    batchobj.Operation_String='Successful creation or updation of  '+ countAccountInsertsInt +' Account(s) and '+countContactInsertsInt+ 'Conatct(s)';
                }
                catch(Exception e){
                    batchobj.FAILED_REASON.add('Unable to Insert or update a records ' + e);
                }
                supplierinformationbatch = new list<Integrations_SupplierInfoBatch_Data.SupplierInformationBatch>();
                supplierinformationbatch.add(batchobj);
                System.debug('@@ Exiting from Integrations_SupplierInfoBatch_Cls.upsertSupplierContactInfo @@');                     
                return supplierinformationbatch;
        }
    }
    */
    }