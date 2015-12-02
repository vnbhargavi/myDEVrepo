Public class Extension1Class{

    public Extension1Class(ApexPages.StandardController controller) {

    }


public string AccountNameText{get;set;}
Public string Phone {get;set;}
public string Email{get;set;}
public string AddressText{get;set;}


public Extension1Class(String accname,string phn,string emailid,string addtext){
this.AccountNameText = accname;
this.phone = phn;
this.Email = emailid;
this.addressText = addtext;

}
public pagereference InsertData(){

Account acc = new Account();
acc.name = AccountNameText;
acc.Phone = phone;
acc.TOM_ID__c = email;
acc.Districting_Status__c = AddressText ;
insert acc;
return null;
}
}