public class MyController1 {
private final Account account;
public MyController1() {
account = [select id, name, site from Account where id =
:ApexPages.currentPage().getParameters().get('id')];
}
public Account getAccount() {
return account;
}
public PageReference save() {
update account;
return null;
}
}