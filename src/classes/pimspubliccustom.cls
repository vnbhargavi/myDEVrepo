public class pimspubliccustom {

    public class GetContactInfo_element {
        public String partnerID;
        public Integer nameID;
        private String[] partnerID_type_info = new String[]{'partnerID','http://www.w3.org/2001/XMLSchema','string','0','1','false'};
        private String[] nameID_type_info = new String[]{'nameID','http://www.w3.org/2001/XMLSchema','int','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://habitat.org/','false','false'};
        private String[] field_order_type_info = new String[]{'partnerID','nameID'};
    }
    
    public class GetContactInfoResult_element {
        private String[] apex_schema_type_info = new String[]{'http://habitat.org/','false','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class GetContactInfoResponse_element {
        public pimspubliccustom.GetContactInfoResult_element GetContactInfoResult;
        private String[] GetContactInfoResult_type_info = new String[]{'GetContactInfoResult','http://habitat.org/','GetContactInfoResult_element','0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://habitat.org/','false','false'};
        private String[] field_order_type_info = new String[]{'GetContactInfoResult'};
    }
    public class Pims {
        public String endpoint_x = 'http://aspspider.ws/kspartha/PimsService.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://habitat.org/', 'pimspubliccustom'};

        public pimspubliccustom.GetContactInfoResult_element GetContactInfo(String partnerID,Integer nameID) {
            pimspubliccustom.GetContactInfo_element request_x = new pimspubliccustom.GetContactInfo_element();
            pimspubliccustom.GetContactInfoResponse_element response_x;
            request_x.partnerID = partnerID;
            request_x.nameID = nameID;
            Map<String, pimspubliccustom.GetContactInfoResponse_element> response_map_x = new Map<String, pimspubliccustom.GetContactInfoResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://habitat.org/GetContactInfo',
              'http://habitat.org/',
              'GetContactInfo',
              'http://habitat.org/',
              'GetContactInfoResponse',
              'pimspubliccustom.GetContactInfoResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.GetContactInfoResult;
           
        }
    }
}