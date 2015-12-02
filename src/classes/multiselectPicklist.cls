public class multiselectPicklist {
    public String Index { get; set; }

 private User salesRegions;
  public multiselectPicklist() {
      salesRegions = new User(); }
       public User getSalesRegions() { 
 return salesRegions; } 
   public void setSalesRegions(User Value) {
    salesRegions = Value; }
public PageReference runReport() {  
  if (salesRegions.Sales_Regions__c == null || salesRegions.Sales_Regions__c == '') 
  {    
    apexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'Please select one or more regions first.'));   
return null;  
  } 
  // read the values into an array  
    string[] regions = salesRegions.Sales_Regions__c.split(';',0);  
  if (regions != null && regions.size() > 0)    { 
   //query the database based on the user's selection     
 users = [select Username, IsActive, Id from user where Sales_Regions__c in :regions and IsActive = true order by Username];    }   
 return null;  }
  private List<User> users;
    public List<User> getUsers() 
     {    return users;
  }
   }