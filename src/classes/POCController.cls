public with sharing class POCController
{
public account insertAccount()
{
Account a = new Account();
a.Name = 'POC Account';
a.Billingcity = 'US';
a.Type = 'Other';
insert a;
system.debug('@@'+a);
return a;

}
public list<Contact> contactlist(){
list<Contact> contactList = new list<Contact>();
Account a1 = insertAccount();
Contact c= new Contact();
c.Accountid = a1.id;
c.firstname = 'Test contact';
c.lastname = 'Test';
c.phone = '1223345';
c.email = 'a@c.com';

Contact c1= new Contact();
c1.Accountid = a1.id;
c1.firstname = 'Test contact1';
c1.lastname = 'Test';
c1.phone = '1223345';
c1.email = 'a@c.com';

contactList.add(c);
contactList.add(c1);
insert contactList;
return contactList;
}
public void validateaccount(){
Account a1 = insertAccount();
if(a1.Billingcity =='US')
{
changecontactname();
}

}
public Void changecontactname()
{
list<contact> clist = contactlist();
system.debug('@clst@'+clist);
for(contact c:clist)
{
c.firstname = c.firstname +'from USA';
}
update clist;

}
public pagereference Clickbutton()
{

validateaccount();
changecontactname();
Account a = insertAccount();
a.type = 'Prospect';
update a;
system.debug('@@'+a);
pagereference pg = new pagereference('/'+a.id);
pg.setredirect(true);
return pg;


}
}