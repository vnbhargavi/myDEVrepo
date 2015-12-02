public with sharing class GetSLAReportsController{

    public string month {get; set;}
     public string year {get; set;}
     public boolean displayPopup {get; set;}  
     private final SObject so;
     private List<Reports> myReports = new List<Reports> ();   
     public Integer ICount = 0;
     public String strAttachName;
     public String hasAttachment;
     public String AttachId;
     public String strURL;
     public String ButtonClicked;
     public String BaseURL;
     public Boolean isEnabled{get; set;}
     public List<Account> lstAccounts; 
     public string strbody{get;set;}
     public GetSLAReportsController(ApexPages.StandardController controller) 
    {
        this.so = controller.getRecord ();
        fetchReports();
        isEnabled = false;
        lstAccounts = [Select id,Name,TOMID__c from Account where Id =: so.Id];
    }
     public List<SelectOption> getMonths()
    {    
    	Date myDate = date.today();
         Integer currentMonth;
         currentMonth = myDate.month();
         
         List<selectOption> options = new List<selectOption>();
         options.clear();
      
         options.add(new selectOption('January', 'January'));
         options.add(new selectOption('February', 'February'));
         options.add(new selectOption('March', 'March'));
         options.add(new selectOption('April', 'April'));
         options.add(new selectOption('May', 'May'));
         options.add(new selectOption('June', 'June'));
         options.add(new selectOption('July', 'July'));
         options.add(new selectOption('August', 'August'));
         options.add(new selectOption('September', 'September'));
         options.add(new selectOption('October', 'October'));
         options.add(new selectOption('November', 'November'));
         options.add(new selectOption('December', 'December'));
         return options;
    }
     public List<SelectOption> getYears()
    {
        Integer currentYear;
        Date myDate = date.today();
        currentYear = myDate.year();
       
        List<selectOption> options = new List<selectOption>();
        options.clear();
        options.add(new selectOption(String.valueOf(currentYear-1),String.valueOf(currentYear-1)));
        options.add(new selectOption(String.valueOf(currentYear),String.valueOf(currentYear)));
        return options;
        
    }
   
    public pagereference fetchReport()
    {   
        // Add logic here
        return null;    
    }
    public void closePopup() {        
        displayPopup = false;    
    }     
/*    public void showPopup() {        
        displayPopup = true;    
    }
*/    
    public class Reports
    {
        String id;
        String url;
        String name;
        
        public Reports(String ipId, String ipName){
            id   = ipId;
            url  = '/servlet/servlet.FileDownload?file=' + id;  
            name = ipName;
        }
        
        public String getId(){
            return id;
        }
        
        public String getUrl(){
            return url;
        }
        
        public String getName(){
            return name;
        }
    }

    private void fetchReports ()
    {
        myReports.clear ();  // Empty list
        
        for (Attachment a : [Select Id, Name, ContentType From Attachment Where ParentId = :so.Id limit 1])
        {
            if (a.ContentType.contains ('/pdf'))  // Only add pdf to the list, ignore all other types
            {
                myReports.add (new Reports (a.Id, a.Name));
            }
        }
    }
                           
    public List<Reports> getReports ()
    {
        Integer ReportSize = myReports.size();
        return myReports;
    }
    public PageReference increment()
    {
        if(isEnabled == false)
            return null;
            
       system.debug('inside increment ------ '+isEnabled);
                 
        List<Attachment> AttachLists = [Select ParentId ,Id, Name, ContentType From Attachment where ParentId =: so.Id];        
        for(Integer i=0;i<AttachLists.size();i++)
        {
           
            if((AttachLists.get(i)).ParentId == so.Id)
            {
                Attachment a = AttachLists.get(i);
                strAttachName = a.Name;
                AttachId = a.Id;
                if (strAttachName.contains(month))
                	if(strAttachName.contains(year))
	                	hasAttachment = 'true';                
                BaseURL = URL.getSalesforceBaseUrl().toExternalForm();
                strURL = BaseURL +'/servlet/servlet.FileDownload?file='+AttachId;
                break;
            }
            else
                hasAttachment = 'false';                     
        }

        ICount ++;
        if (hasAttachment == 'true')
        {
            PageReference pageRef = new PageReference(strURL);
            pageRef.setRedirect(true);
            return  pageRef;
        }
        else
        return null;
    }    
    Public  String getCount()
    {              
        if(hasAttachment == 'true')
        {
            PageReference pageRef = new PageReference(strURL);
            pageRef.setRedirect(true);
            displayPopup = false;                         
            return strAttachName;
        }
        else
        {
            if (ButtonClicked == 'true')
            displayPopup = true;                         
            return 'No PDF Available'+displayPopup+ICount;
        }
    }
     public void showPopup() 
     {        
        ButtonClicked = 'true';
        displayPopup = true; 
        isEnabled = true;
       AttachmentXML.sendRequest(lstAccounts, month, year,strbody);
                       
    }
    Public void doAction()
    {
        system.debug('inside do Action');
       List<Attachment> attachmentList = [Select ParentId ,Id, Name, ContentType From Attachment where ParentId =: so.Id];           
        
        for(Integer i=0;i<attachmentList.size();i++)
        {
        	
            if((attachmentList.get(i)).ParentId == so.Id)
            {
                Attachment attachment = attachmentList.get(i);
                Delete attachment;
                system.debug('Attachment deleted ------- '+attachment);
            }
                             
        }
    }
    
}