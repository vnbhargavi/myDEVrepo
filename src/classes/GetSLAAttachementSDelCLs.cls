// thi s get sla class
global class GetSLAAttachementSDelCLs
{
/*
global class Integrations_GetSLAAttachmentsDelete_Cls implements Database.Batchable<sObject>
{
    global final String Query ;
    global Integrations_GetSLAAttachmentsDelete_Cls(String QueryStr)
    {
        Query = QueryStr;
    }
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        //return Database.getQueryLocator([SELECT Name FROM Attachment]);//Get all attachments in a queryQuery
        return Database.getQueryLocator(Query);//Get all attachments in a query        
    }
    global void execute(Database.BatchableContext BC,List<Attachment> scope)
    {
        Integer iMonth;
        String month,year;
        List <Attachment> DelAtt = new List<Attachment>();
        for(Attachment a:scope)
        {
            System.Debug('@@@@@@@@@@@@@@@@@@@'+a.name);
            List<String> s = (a.Name).split('_');//split attachment name 
            month = s.get(1);
            if(s.get(2).length()>4)
            {
                year = s.get(2).substring(0,4);//if attachment name ends with 'pdf' remove that suffix 
            }
            else
            {
                year = s.get(2);
            }
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
                Integer iYear = integer.valueOf(year);          
                Date myDate = date.today();
                Integer currentYear = myDate.year();
        
                if(iMonth < myDate.month())//comparing current month is less than month from attachment name
                {
                    if(iYear < currentYear)
                    {
                        DelAtt.add(a); //add to delete attachments list
                    }
                }
                
                if(iMonth > myDate.month())//comparing current month is greater than month from attachment name
                {
                    if(iYear == currentYear)
                    {
                        DelAtt.add(a);//add to delete attachments list
                    }
                }    
        }               
        try
        {
            //Deleting all attachments which are year old
            Delete DelAtt;        
        }
        catch(DMLException e)
        {
            System.Debug('Error while deleting....');
        }
    }
    global void finish(Database.BatchableContext BC)
    {   
    }
}
*/
}