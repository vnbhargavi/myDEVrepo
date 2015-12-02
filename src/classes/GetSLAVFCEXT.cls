global class GetSLAVFCEXT
{
/*
public with sharing class Integrations_GetSLAReports_VFCExt{ 

     public string month {get; set;}
     public String year {get; set;}
     public Integer iMonth{get;set;}   
     public boolean displayPopup {get; set;}
     public boolean displayErrorPopup {get; set;}
     public boolean bYearOut {get; set;} 
     private final sObject acc;
     public String AttachmentNameStr;
     public String hasAttachmentStr;
     public String AttachId;
     public String URLStr;
     public String ButtonClickedStr;
     public String BaseURLStr;
     public Boolean isEnabledBoolean{get; set;}
     public Account currentAccount;
     public String currentMonthStr{get;set;}
     public Integer currentYearInt{get;set;}
     public Integer showCurrentYearInt{get;set;}
     public Integer previousYearInt{get;set;}
     public String prevoiusMonthStr {get;set;}
     public Map<String,String> attachmentParamMap {get;set;}
     public String HttpMessageStr {get;set;}
     public String TimeOutErrorStr {get;set;}
     
     public Integrations_GetSLAReports_VFCExt(ApexPages.StandardController controller) 
    {
        System.debug('@@ Entering into Integrations_GetSLAAttachment_Cls.Integrations_GetSLAReports_VFCExt constructor @@');
        acc = controller.getRecord ();
        isEnabledBoolean = false;
        displayErrorPopup = false;
        currentAccount = [Select Id, TOM_ID__c from Account where Id =: acc.Id limit 1];
     System.Debug('@@ Exiting from Integrations_GetSLAAttachment_Cls.Integrations_GetSLAReports_VFCExt constructor @@');        
    }
    // This method will show all month names
     public List<SelectOption> getMonths()
    {    
                 
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
    
    // This method will show current year and previous year    
    public List<SelectOption> getYears()
    {
       
        Date myDate = date.today();
        currentYearInt = myDate.year();
        showCurrentYearInt = currentYearInt;
        
        List<selectOption> options = new List<selectOption>();
        options.clear();
        options.add(new selectOption(String.valueOf(currentYearInt-1),String.valueOf(currentYearInt-1)));
        options.add(new selectOption(String.valueOf(currentYearInt),String.valueOf(currentYearInt)));
        return options;
        
    }
    
    //This method will be called by Action Poller for every 10 secs and will check for whether Attachment has been created for this Account or not
    //If it found pdf attachment then it will display its contents
    public PageReference pollingForAttachment()
    {
        System.debug('@@ Entering into Integrations_GetSLAReports_VFCExt.pollingForAttachment method @@');
        if(isEnabledBoolean == false)
            return null;
        
        List<Attachment> AttachLists = [Select ParentId ,Id, Name, ContentType 
                                        From Attachment 
                                        where ParentId =: acc.Id 
                                        ];
    //checking all attachments whether required attachment is there or not                                                
        for(Integer i=0;i<AttachLists.size();i++)
        {
                Attachment a = AttachLists.get(i);
                AttachmentNameStr = a.Name;
               
                AttachId = a.Id;
                if (AttachmentNameStr.contains(month))
                {
                    if(AttachmentNameStr.contains(year))
                        {
                          //Making pdf file attachment URL
                            hasAttachmentStr = 'true';                
                            BaseURLStr = URL.getSalesforceBaseURL().toExternalForm();
                            URLStr = BaseURLStr +'/servlet/servlet.FileDownload?file='+AttachId;
                            break;
                        }
                }
                //if attachment could not found 
                else
                {    
                  hasAttachmentStr = 'false';
                }
        }
     System.Debug('@@ Exiting from Integrations_GetSLAReports_VFCExt.pollingForAttachment method @@');
        //Attachment found and redirecting to that attachment URL
        if (hasAttachmentStr == 'true')
        {
            PageReference pageRef = new PageReference(URLStr);
            pageRef.setRedirect(true);
            return  pageRef;
        }             
        else return null;
           
    } 
    //This method will be called once Fetch Report button has been clicked   
     public void fetchReport() 
     {  
        System.debug('@@ Entering into Integrations_GetSLAReports_VFCExt.fetchReport method @@');
        Integer iYear = integer.valueOf(year);
        bYearOut = false;
        if (month == 'January'){
            iMonth=1;
        } 
        else if (month == 'February'){
            iMonth=2;
        } 
        else if (month == 'March'){
            iMonth=3;
        }
        else if (month == 'April'){
            iMonth=4;
        } 
        else if (month == 'May'){
            iMonth=5;
        } 
        else if (month == 'June'){
            iMonth=6;
        } 
        else if (month == 'July'){
            iMonth=7;
        } 
        else if (month == 'August'){
            iMonth=8;
        } 
        else if (month == 'September'){
            iMonth=9;
        } 
        else if (month == 'October'){
            iMonth=10;
        } 
        else if (month == 'November'){
            iMonth=11;
        } 
        else {
            iMonth=12;
        } 
        Date myDate = date.today();
        Integer currentYearInt = myDate.year();
        
        //Checking if selected month is less than curent Month                                
        if(iMonth < myDate.month())
        {
            if(iYear < currentYearInt){bYearOut = true;}
        }
        
        if(iMonth >= myDate.month())
        {
            if(iYear == currentYearInt){bYearOut = true;}//checking if month is greater than or equal to current month and selected year is equal to current year 
        }
        //the selected month and year are in limits try to send HTTP request to get response                
        if(bYearOut == false)
        {    
            ButtonClickedStr = 'true';
            displayPopup = true; 
            isEnabledBoolean = true;
            displayErrorPopup = false; 
            HttpMessageStr = null;            
            String isFound = 'false';
             List<Attachment> AttachLists = [Select ParentId ,Id, Name, ContentType 
                                        From Attachment 
                                        where ParentId =: acc.Id 
                                        ];  
            for(Integer i=0;i<AttachLists.size();i++)
            {
                    Attachment a = AttachLists.get(i);
                    AttachmentNameStr = a.Name;
                   
                   if (AttachmentNameStr.contains(month) && AttachmentNameStr.contains(year)){
                       isFound = 'true'; 
                       break;   
                   }
                   else{
                        isFound = 'false';
                   }
            }
            if(isFound.equalsIgnoreCase('false'))
            {
                //SendXMLMessage.sendRequest(currentAccount.TOM_ID__c,month,year);
                if(currentAccount.TOM_ID__c!= null && month != null && year != null) 
                {
                  attachmentParamMap = new Map<String,String>();                   
                    attachmentParamMap.put('Month',String.ValueOf(iMonth));
                  attachmentParamMap.put('Year',year);
                  attachmentParamMap.put('TOM_ID',String.ValueOf(currentAccount.TOM_ID__c));
                  //calling this method to send HTTP request and get response
                  Integer iInt = Integrations_GetSLAAttachment_Cls.getResponse(attachmentParamMap); 
                } 
            }
        }
        //Selected Month and Year are beyond the limits then show Message
        else
        {
            Date myDateandMonth = date.today(); 
            Integer currentMonth = myDateandMonth.month();
            previousYearInt = currentYearInt - 1;
           if (currentMonth == 1)
           {
              currentMonthStr='December';
                prevoiusMonthStr = 'January'; 
            showCurrentYearInt = previousYearInt;
            } 
            else if (currentMonth == 2){
                currentMonthStr='January';
                prevoiusMonthStr = 'February';                
            } 
            else if (currentMonth == 3){
                currentMonthStr='February';
                prevoiusMonthStr = 'March';                
            }
            else if (currentMonth == 4){
                currentMonthStr='March';
                prevoiusMonthStr = 'April';                
            } 
            else if (currentMonth == 5){
                currentMonthStr='April';
                prevoiusMonthStr = 'May';                
            } 
            else if (currentMonth == 6){
                currentMonthStr='May';
                prevoiusMonthStr = 'June';                
            } 
            else if (currentMonth == 7){
                currentMonthStr='June';
                prevoiusMonthStr = 'July';                
            } 
            else if (currentMonth == 8){
                currentMonthStr='July';
                prevoiusMonthStr = 'August';                
            } 
            else if (currentMonth == 9){
                currentMonthStr='August';
                prevoiusMonthStr = 'September';                
            } 
            else if (currentMonth == 10){
                currentMonthStr='September';
                prevoiusMonthStr = 'October';                
            } 
            else if (currentMonth == 11){
                currentMonthStr='October';
                prevoiusMonthStr = 'November';                
            } 
            else {
                currentMonthStr='November';
                prevoiusMonthStr = 'December';
            } 
            
            ButtonClickedStr = 'false';
            displayPopup = false; 
            isEnabledBoolean = false;
            displayErrorPopup = true;  
            HttpMessageStr = null;     
        }
     System.Debug('@@ Exiting from Integrations_GetSLAReports_VFCExt.fetchReport method @@');         
    }
    //The following method will be called after 40 sec to notify user that session has been timedout
    public void sessionTimeOut()
    {
       System.debug('@@ Entering into Integrations_GetSLAReports_VFCExt.sessionTimeOut method @@');   
          ButtonClickedStr = 'false';
            displayPopup = false; 
            isEnabledBoolean = false;
            displayErrorPopup = false;
            HttpMessageStr = null;
            TimeOutErrorStr = 'Your Session has been TimeOut.Kindly refresh this page.';
       System.debug('@@ Exiting from Integrations_GetSLAReports_VFCExt.sessionTimeOut method @@');
    }
  
}
*/
}