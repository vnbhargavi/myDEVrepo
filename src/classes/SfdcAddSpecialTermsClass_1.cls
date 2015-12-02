public class SfdcAddSpecialTermsClass_1
{
    public List<ContractWrapper> contractList{get;set;}
 
    public String message{get;set;}
    public id accountid{get;set;}
    public id quoteid{get;set;}
    public id accountidstr {get;set;}
    public list<Contract> Acccontractlist1{get;set;}
    public SfdcAddSpecialTermsClass_1(){
    
    quoteid = ApexPages.currentPage().getParameters().get('id');
    system.debug('Quote id'+quoteid);
 
        this.message = 'Please select one or more Contacts.';
 
        //initialize the ContactWrapper container
        this.contractList  = new List<ContractWrapper>();
 
        loadContracts();
 
    }
     
     
    public List<ContractWrapper> loadContracts(){
     list<Contact> quotelist =[select id,name,Account.id from Contact where id =:quoteid];
     //list<Apttus_Proposal__Proposal__c> quotelist =[select id,name,Apttus_Proposal__Account__r.id from Apttus_Proposal__Proposal__c where id =:quoteid];
        for(Contact apps :quotelist )
        {
        accountidstr = apps.Account.id;
        system.debug('Quote Account id'+accountidstr );
        }
        list<Contract> cntrctlist = [select id,Account.id,ContractNumber,status from Contract where Account.id = :accountidstr ];
        system.debug('Contract list'+cntrctlist );
       
        for(Contract c : cntrctlist ){
             this.contractList.add( new ContractWrapper(c) );
             system.debug('@@Contract list@@'+this.contractList);
         }
         return this.contractList;
     }
     public Pagereference doProcessSelection(){
         Integer selectedCount = 0;
         Acccontractlist1 = new list<Contract>();
         for(ContractWrapper cw : this.contractList){
             if(cw.selected==true)
             {
                selectedCount++;
                system.debug('@@come here'+cw.tcontract+'and'+cw);
                Acccontractlist1.add(cw.tcontract);
                
                }
                system.debug('@@Contract selected list'+Acccontractlist1);
        }
        
         this.message = 'You have selected '+selectedCount+' records.';
         return null;
     }
   
    public class ContractWrapper{
    public Contract tContract{get;set;}
    public string tContractid{get;set;}
         //whether the record is selected
        public Boolean selected{get;set;}
        
        public ContractWrapper(Contract c){
            this.tContract = c;
            this.tContractid = c.id;
            this.selected = false;
        }
     }
 
}