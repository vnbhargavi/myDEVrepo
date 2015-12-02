public class sampleCon {
    String country = null;
    public list<Account> lstacc{get;set;}  
    public PageReference test() {
        return null;
    }
                
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('US','US')); 
        options.add(new SelectOption('CANADA','Canada')); 
        options.add(new SelectOption('MEXICO','Mexico')); return options; 
    }
    public list<ACcount> acclist()
    {
    lstacc = [select id,name from account limit 5];
    return lstacc;
    }
                   
    public String getCountry() {
        return country;
    }
                    
    public void setCountry(String country) { this.country = country; }
}