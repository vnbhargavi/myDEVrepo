global class outboundxmldata
{
	global class OMLData
	{
		//Account header
		webservice string AccntName;
		webservice string TOMID;
		webservice string Creditcard;
		webservice String NumberofLocations;
	    webservice Date SLAExpirationDate;
	    webservice string CreditCheckedDate;
	    webservice string PotentialLiability;
	    webservice string EngineeringReqNumber;
	    webservice string SLAViolation;
	    webservice string GeocodingStatus;
	    webservice string DistrictingStatus;
	    webservice string Longitude;
	    webservice string Latitude;
	    
	    webservice List<Account> account;   
		webservice List<Order__c> order;
		webservice List<Case> cse;  
		webservice List<Contact> opp;
	}

}