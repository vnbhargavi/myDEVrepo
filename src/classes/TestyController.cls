public with sharing class TestyController {

//variable declaration 
    String bodystr= '';
    Integer querystartindex = 0;
    Integer queryEndindex   = 0;
    public list<String> classnameslist = new list<String>();
    public List<String> forLoopList ;
    List<Apexclass> classnames = new list<Apexclass>();  
    Integer nosharingkeywordInt = 0 ;
    Boolean containssharing =false;
    Integer queryclauseInt = 0;
    Integer testassertInt = 0;
    public class dataWrapperCls
    {
        public string querykeystr{get;set;}
        public integer countint{get;set;}
        public integer counterint{get;set;}
        public string groupkeystr{get;set;}
        public string clasnamestr{get;set;}
        public string triggernamestr{get;set;}
        
        public dataWrapperCls(string querykeystr,string groupkeystr,integer countint)
        {
            this.querykeystr =  querykeystr;
            this.countint    =  countint;
            this.groupkeystr =  groupkeystr;
        }
        public dataWrapperCls(string clasnamestr,integer countint)
        {
            this.clasnamestr =  clasnamestr;
            this.countint    =  countint;
        }
        public dataWrapperCls(integer counterint,string triggernamestr)
        {
            this.triggernamestr =  triggernamestr;
            this.counterint      =  counterint;
        }
    }
    //Method definitions    
    public List<dataWrapperCls> gettabledata()
    {
         classnames = [Select id,Name,body from Apexclass]; 
         
         for(Apexclass str : classnames)
        {
             classnameslist.add(str.Name); 
             bodystr = str.body;
             system.debug('body of the class' + bodystr);
              //Checking for sharing keyword in Class
         if(bodystr.contains('with sharing')) 
        { 
            containssharing = true; 
            system.debug('@@ class contains with sharing@@');
        }
        else    
        { 
            nosharingkeywordInt++; 
            system.debug('@@ there is no sharing keyword for the class @@@'+nosharingkeywordInt);
        }   
         //Check fo limit and where clause in the Query
        if(bodystr.contains('[Select ')&& bodystr.countMatches('[Select]')>0)
        {
            system.debug('@@Count matches for the query clause@@'+bodystr.countMatches('[Select]'));
            for(Integer i=0;i<bodystr.countMatches('[Select]');i++)
            {
                querystartindex =  bodystr.indexOf('[Select');
                queryEndindex   = bodystr.indexof(']');
                String remainingQuerystr = bodystr.mid(querystartindex, queryEndindex);
                if(!(remainingQuerystr.containsIgnoreCase('limit')|| remainingQuerystr.containsIgnoreCase('where')))
                { 
                    queryclauseInt++;
                    system.debug('@@there is no limit clause@@'+queryclauseInt);
                } 
            }
            querystartindex =0;
            queryEndindex =0;
        }
        if(bodystr.contains('@isTest')&& !bodystr.contains('system.assert'))
        {
            testassertInt++;
        }
      /*  Integer startIndex = 0;
        String tempContent;
        if(bodystr.contains('for(')){
            startIndex = bodystr.indexOf('for(');
            tempContent = bodystr.substring(startIndex);
            Integer noOfOpeningBraces = 0;
            Integer noOfClosingBraces = 0;
            String block='';
            Integer nextBlockStartIndex = 0;
            
            for(Integer i=0;i<tempContent.length();i++){
            String brace = tempContent.subString(i,i+1);
                if(brace =='{'){
                    noOfOpeningBraces++;
                }
                if(brace =='}'){
                    noOfClosingBraces++;
                }
                if((noOfClosingBraces>0 && noOfOpeningBraces>0) && (noOfClosingBraces==noOfOpeningBraces)){
                    block = tempContent.substring(0,i+1);
                    nextBlockStartIndex = i+2;
                    break;
                } 
            }
            system.debug('--for block--'+block);
            if(block.contains('select') && block.contains('from')){
                system.debug('---code contains query--');
            }
            forLoopList.add(block);
            system.debug('--for block list --'+forLoopList);
            system.debug('---temp stringqqq--'+tempContent.substring(nextBlockStartIndex));
        }*/
        
        } 
        List<dataWrapperCls> wrapperClassList = new  List<dataWrapperCls>();
        wrapperClassList.add(new dataWrapperCls('Sharing','Apex Force com Serious Security Risk',nosharingkeywordInt));
        wrapperClassList.add(new dataWrapperCls('Queryw/o clause','Apex Force com Code Quality',queryclauseInt));    
        wrapperClassList.add(new dataWrapperCls('Test Class W/o Asserts','Apex Force com Code Quality',testassertInt));  
        
        wrapperClassList.add(new dataWrapperCls('nosharigkeywords', 'class',110));
        wrapperClassList.add(new dataWrapperCls('bad', 'triggers',58));
        return wrapperClassList;     
    }
     public List<PieWedgeData> getPieData()
    {
        List<PieWedgeData> data = new List<PieWedgeData>();
        data.add(new PieWedgeData('Jan', 30));
        data.add(new PieWedgeData('Feb', 15));
        data.add(new PieWedgeData('Mar', 10));
        data.add(new PieWedgeData('Apr', 20));
        data.add(new PieWedgeData('May', 20));
        data.add(new PieWedgeData('Jun', 5));
        return data;
    }

    // Wrapper class for Pie Chart
    public class PieWedgeData
    {
        public String name { get; set; }
        public Integer data { get; set; }

        public PieWedgeData(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
}