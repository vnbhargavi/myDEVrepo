public class nestedqueryexample
{
  public List<Account> getaccsandtmember()
  {
      List<Account> accounts = [Select Id,(Select TeamMemberRole, User.Name From Account.AccountTeamMembers), Name, BillingCountry from Account];
      return accounts;
  }
}