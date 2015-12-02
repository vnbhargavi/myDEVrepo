trigger UpdateProductRecordType on OpportunityLineItem (after insert)
{
    Set<String> oppLineItemIds = new Set<String>();
    
     for(OpportunityLineItem oppLineItem : Trigger.new)
     {
         oppLineItemIds.add(oppLineItem.Id);
     }
     List<OpportunityLineItem> oppLineItems = new List<OpportunityLineItem>();
     
     for(OpportunityLineItem oppLineItem : [select Opportunity.RecordType.Name,PriceBookEntry.Product2ID,Product__c, record_type__c from OpportunityLineItem where Id in :oppLineItemIds])
     {
          oppLineItem.Product__r.record_type__c= oppLineItem.Opportunity.RecordType.Name;
          oppLineItems.add(oppLineItem);
     }
     if(oppLineItems.size() > 0)
     {
          update oppLineItems;
     }
     }