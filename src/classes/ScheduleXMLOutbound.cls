global class ScheduleXMLOutbound implements Schedulable 
{
    global void execute(SchedulableContext sc)
    {
    	 database.executeBatch(new BatchOutboundMessage(),5);
         
    }
}