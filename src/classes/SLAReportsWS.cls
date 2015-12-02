global class SLAReportsWS {
    
     global class SLRWS {
        webservice SLAReportsDataCls.SLAReports slaReports;
    }
    
    webservice static SLRWS createSLAReports(SLRWS s){ 
    
        SLRWS slrWS = new SLRWS();
        slrWS.slaReports =  SLAReportsCls.create(s.slaReports); 
        return slrWS;
    }

}