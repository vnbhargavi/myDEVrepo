global class OutboundWB 
{
     global class requestwb
     {
	     webservice outboundxmldata.OMLData ooml;
	     webservice Account account;
     }
      
    	webservice static requestwb reques(requestwb omln)
    	{
    
	     requestwb reql = new requestwb();
	     reql.ooml = mytest.getXml(omln.ooml,omln.account);
	        return reql;
   
  		}
  }