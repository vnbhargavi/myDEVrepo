public class TestUtils {

     /* Public Id enqueueId;      
      Public Boolean testInitiated {get;set;}
      Public String strWaitMessage {get;set;}
      Public Boolean activated {get;set;}  
      Public Boolean showData {get;set;} 
      public String str{get;set;}          
      public Integer mainIndex{get;set;}       
             //check quality code
      public String var1{get;set;}
      public static List<String> forLoopList = new List<String>(); 
      public Integer classCount{get;set;}
      public Integer methodCount{get;set;}
      public Integer totalMethodCount{get;set;}
      public Integer count1 = 0;
      public Integer count3 = 0;
      public Integer count4 = 0;
      public Integer startIndex;
      public Integer endIndex;
      public Integer coverage;
        
        String[] apexLimitMethods = new String[]{'getAggregateQueries','getLimitAggregateQueries','getCallouts','getChildRelationshipsDescribes ','getLimitChildRelationshipsDescribes ','getCpuTime ','getLimitCpuTime ','getDMLRows ','getLimitDMLRows ','getDMLStatements ',
                                                'getLimitDMLStatements ','getEmailInvocations ','getLimitEmailInvocations ','getFieldsDescribes ','getLimitFieldsDescribes ','getFieldSetsDescribes ','getLimitFieldSetsDescribes ','getFindSimilarCalls ','getLimitFindSimilarCalls','getFutureCalls','getLimitFutureCalls','getHeapSize',
                                                'getLimitHeapSize','getQueries','getLimitQueries','getPicklistDescribes','getLimitPicklistDescribes','getQueryLocatorRows','getLimitQueryLocatorRows','getQueryRows ','getLimitQueryRows ','getRecordTypesDescribes ','getLimitRecordTypesDescribes ','getRunAs ','getLimitRunAs ','getSavepointRollbacks ',
                                                'getLimitSavepointRollbacks','getSavepoints','getLimitSavepoints','getScriptStatements','getLimitScriptStatements','getSoslQueries','getLimitSoslQueries' };
       
String[] arrDataTypes = new String[]{'void','Integer','String','Boolean','Date','DateTime','Double','ID','Long','Time','Decimal'};
    
 String[] varTypes = new String[]{'public String','public Integer','public Boolean','public Date','public DateTime','public Decimal',
         'public Double','public ID','public Long','public Time','private String','private Integer','private Boolean','private Date','private DateTime',
         'private Decimal','private Double','private ID','private Long','private Time','protected String','protected Integer','protected Boolean',
         'protected Date','protected DateTime','protected Decimal','protected Double','protected ID','protected Long','protected Time',       
         'public Static String','public Static Integer','public Static Boolean','public Static Date','public Static DateTime','public Static Decimal',
         'public Static Double','public Static ID','public Static Long','public Static Time','private Static String','private Static Integer',
         'private Static Boolean','private Static Date','private Static DateTime','private Static Decimal','private Static Double','private Static ID',
         'private Static Long','private Static Time','protected Static String','protected Static Integer','protected Static Boolean','protected Static Date',
         'protected Static Decimal','protected Static Double','protected Static ID','protected Static Long','protected Static Time','String','Integer',
         'Boolean','Date','DateTime','Decimal','Double','ID','Long','Time','public List','public Static List','private List','private Static List',
         'protected List','protected Static List','public void','private void','protected void'};
        

        public Integer getCount1(){
        return count1;
        }
        public void setCount1(Integer count1){
            this.count1=count1;
        }
        
        public Integer getCount3(){
        return count3;
        }
        public void setCount3(Integer count3){
            this.count3=count3;
        }
        
        public Integer getCount4(){
        return count4;
        }
        public void setCount4(Integer count4){
            this.count4=count4;
        }
        //public Integer count2{get;set;}
        public Integer count2{get;set;}
        
        public Integer variableCount{get;set;}   
        Public Boolean showQuality {get;set;}
        public List<String> lines{get;set;}
        
      public TestUtils(){
        activated = false;
        showData = false;
        showQuality = false;
        str = [select a.Body from apexClass a where a.Name='testClass'].body;
      }

      public void enqueueTests() {        
        ApexClass[] testClasses = [SELECT Id FROM ApexClass
                                   WHERE Name LIKE '%test%'   
                                  ];
        
        if (testClasses.size() > 0){
            ApexTestQueueItem[] queueItems = new List<ApexTestQueueItem>();
            
            for (ApexClass cls : testClasses){
                queueItems.add(new ApexTestQueueItem(ApexClassId=cls.Id));
            }
            
            insert queueItems;

            // Get the job ID of the first queue item returned. 
            System.debug('queueItems==> ' + queueItems[0].Id);
            ApexTestQueueItem item = [SELECT ParentJobId FROM ApexTestQueueItem 
                                      WHERE Id=:queueItems[0].Id LIMIT 1];
            
            //checkClassStatus(item.parentjobid);
            //checkMethodStatus(item.parentjobid);
              
            system.debug('@@ item.parentjobid @@'+item.parentjobid); 
            activated = true;  
            enqueueId = item.parentjobid;
            strWaitMessage = 'Wait for 15 Minutes';
            testInitiated = true;                                 
        }
    }

    // Get the result for each test method that was executed.     
    public void checkMethodStatus(){
        
        List<Test_Result__c> testResultsList  = new List<Test_Result__c>();
        Test_Result__c testResult;
        testInitiated = false;        
        system.debug('@@ enqueueId @@'+enqueueId); 

        ApexTestResult[] results              = [SELECT Outcome, ApexClass.Name, MethodName, Message, StackTrace,AsyncApexJobId 
                                                 FROM ApexTestResult 
                                                 WHERE AsyncApexJobId=:enqueueId];                                            
        for (ApexTestResult atr : results){
            testResult                        = new Test_Result__c();
            testResult.JobId__c               = atr.AsyncApexJobId;
            testResult.Name                   = atr.ApexClass.Name;
            testResult.Method_Name__c         = atr.MethodName;
            testResult.Outcome__c             = atr.Outcome;
            
            if(atr.Message!=null){
                testResult.Message__c         = atr.Message;
                testResult.StackTrace__c      = atr.StackTrace;
            }            
            
            testResult.Coverage__c            = getRandomNumber(100);
            
            testResultsList.add(testResult);
        }
        resultCleanUp();
        insert testResultsList;
        showData=true;
    }
    
    public void resultCleanUp(){
    
      List<Test_Result__c> testResultsList;
      // Here Where clause is not used as Apex Classes will not exceed the limit of 50000
        testResultsList    =  [Select Id from Test_Result__c];
        delete testResultsList;    
    }
    
    // Get the Random Integer Value    
    public Integer getRandomNumber(Integer size){        
        Double d = math.random() * size;        
        return d.intValue();    
    }
    
public PageReference mainMethod(){
String str = [select a.Body from apexClass a where a.Name='testClass'].body;

//getCountOfAll(str);

String subStr1 = ' class ';
        String subStr2 ='{get;set;}';
        String subStr3 ='(){';
         lines = str.split('\n');
        classCount = (str.length() - str.replace(subStr1, '').length()) / subStr1.length();
            for(String line : lines){
            line = line.trim();
       
            for(Integer m = 0;m<varTypes.size();m++){
                if((line.startsWith(varTypes[m]) && line.endsWith(';')) || (line.startsWith(varTypes[m].toLowerCase()) && line.endsWith(';'))){
                    count1++;
                 }
                 
                 if((line.startsWith(varTypes[m]) && line.endsWith('){')) || (line.startsWith(varTypes[m].toLowerCase()) && line.endsWith('){'))){
                    count3++;
                 }
            }
            
            for(Integer m = 0;m<varTypes.size();m++){
                   system.debug('----var type--'+varTypes[m]);
                   
                    if(
                (line.startsWith(varTypes[m]) && line.endsWith('){')) || (line.startsWith(varTypes[m].toLowerCase()) && line.endsWith('){'))
                ){
                    system.debug('[[[line]]]'+line);
                    String tempString;
                    Integer startIndexOfMethodName;
                    Integer charEndPosition;
                    Integer endIndexOfMethodName;
                    String tempStr;
                    String tempStr1;
                    String methodName;
                    Integer pos = line.indexOf('(');
                
                    String stre = line.subString(pos); 
                    String stre1 = line.replace(stre,'');
                    
                    for(Integer i =0;i<arrDataTypes.size();i++){
                    system.debug('---data types are----'+arrDataTypes[i]);
                    
                    if(stre1.contains(arrDataTypes[i])){
                        
                             
                             
                            Integer startIndexOfDatatype = stre1.indexOf(arrDataTypes[i]);
                             
                            system.debug('---line is---'+stre1+'---startIndexOfDatatype---'+arrDataTypes[i]+'--is*'+startIndexOfDatatype);
                            
                            startIndexofMethodName = startIndexOfDatatype + arrDataTypes[i].length();
                        
                            methodName = line.subString(startIndexofMethodName,pos);
                        
                            system.debug('----method name----'+methodName);
                            
                            String firstCharacter = line.subString(startIndexofMethodName,startIndexofMethodName+2);
                            
                            system.debug('---first character of method--'+methodName+'--is--'+firstCharacter );
                           
                            if(firstCharacter.equals(firstCharacter.toUpperCase())){
                                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Method name should start with the lowercase character');
                                ApexPages.addMessage(msg);
                            }
                            
                            for(Integer x = startIndexofMethodName+2;x<pos-2;x++){
                                String singleChar = line.subString(x,x+1);
                                if(!(singleChar.equals(singleChar.toUpperCase()) )){
                                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Method name should contain both Uppercase and lowercase character');
                                    ApexPages.addMessage(msg);
                                
                                }
                            }
                          }  
                    }
                    
                    
                }
                  
                
               
               
                
              }     
                   
               
               
                   count2 = (str.length() - str.replace(subStr2, '').length()) / subStr2.length();
                   variableCount = count1 + count2;
            
                   count4 = (str.length() - str.replace(subStr3, '').length()) / subStr3.length();
                   methodCount = count3 + count4;
            
                   totalMethodCount = methodCount - count4;


chkMethodName(str);
constantvarChkMethod(str);
/*chkForloopMethod(str);
chkClassNameMethod(str);*/
}

/*
showQuality = true;
return null;
}

public void getCountOfAll(String str){
    
        try{
        String subStr1 = ' class ';
        String subStr2 ='{get;set;}';
        String subStr3 ='(){';
         lines = str.split('\n');
        classCount = (str.length() - str.replace(subStr1, '').length()) / subStr1.length();
            for(String line : lines){
            line = line.trim();
       
            for(Integer m = 0;m<varTypes.size();m++){
                if((line.startsWith(varTypes[m]) && line.endsWith(';')) || (line.startsWith(varTypes[m].toLowerCase()) && line.endsWith(';'))){
                    count1++;
                 }
                 
                 if((line.startsWith(varTypes[m]) && line.endsWith('){')) || (line.startsWith(varTypes[m].toLowerCase()) && line.endsWith('){'))){
                    count3++;
                 }
            }
            
                
              }     
                   
               
               
                   count2 = (str.length() - str.replace(subStr2, '').length()) / subStr2.length();
                   variableCount = count1 + count2;
            
                   count4 = (str.length() - str.replace(subStr3, '').length()) / subStr3.length();
                   methodCount = count3 + count4;
            
                   totalMethodCount = methodCount - count4;
                }catch(Exception e)   {
                system.debug('-----Exception of getAllCountMethod--'+e);
                }
                   
           }

public void chkForloopMethod(String str){

system.debug('--method is called--'+str);
try{
Integer startIndex = 0;
        String tempContent;
        
        if(str.contains('for(')){
            startIndex = str.indexOf('for(');
            tempContent = str.substring(startIndex);
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
            chkForloopMethod(tempContent.substring(nextBlockStartIndex));
        }
       }catch(Exception e)   {
                system.debug('-----Exception of chkForloopMethod--'+e);
                } 
                
    }


    public void constantvarChkMethod(String str){
    system.debug('---constantvarChkMethod is called--');
        try{
        lines = str.split('\n');
        for(String line : lines){
        line = line.trim();

       //check apex limit methods
       for(Integer y = 0;y<apexLimitMethods.size();y++){
          Integer countOfApexMethods=0;
         
          if(line.contains(apexLimitMethods[y])){
              countOfApexMethods++;
          }
          
          system.debug('--countOfApexMethods-----'+countOfApexMethods);
          if(countOfApexMethods==0){
              //reduce the code quality percentage
              system.debug('--degrade code quality--');
          }
          
      }
      
      //chkconstant variable convention
        if(line.contains('static final')){
              system.debug('---Inside static loop--');
                   String tempString;
                   Integer startIndexOfVariableName;
                   Integer charEndPosition;
                    
                   for(Integer i =0;i<arrDataTypes.size();i++){
                    
                       if(line.contains(arrDataTypes[i])){
                            
                            Integer startIndexOfDatatype = line.indexOf(arrDataTypes[i]);
                            
                            Integer endIndexOfDataType = startIndexOfDatatype + arrDataTypes[i].length();
                            
                            startIndexOfVariableName = endIndexOfDataType + 1;
                            
                            system.debug('---variable startswith----'+startIndexOfVariableName );
                            
                            tempString = line.subString(startIndexOfVariableName );
                            
                            system.debug('-----tempString -----'+tempString);
                            
                                   if(line.contains(';') && line.contains('=')){
                                         charEndPosition = line.indexOf('=');
                                         system.debug('---Index of = -----'+charEndPosition);
                                   }else{
                                        charEndPosition = line.indexOf(';');
                                        system.debug('---Index of ; -----'+charEndPosition);
                                   }
                       }
                   }
                   
                   tempString = line.subString(startIndexOfVariableName,charEndPosition);
                   system.debug('-----final tempString -----'+tempString);
                   
                   for(Integer k=startIndexOfVariableName;k<charEndPosition;k++){
                        String chatsingle = line.subString(k,k+1);
                        system.debug('----Single character---'+chatsingle);
                        system.debug('----Single character in Uppercase---'+chatsingle.toUppercase());
                        
                        if(!(chatsingle.equals(chatsingle.toUppercase()))){
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Constant Variables should be in Uppercase');
                            ApexPages.addMessage(msg);
                        }
                    
                   }      
                   
             }
          } 
        }catch(Exception e){
                system.debug('-----Exception of constantvarChkMethod--'+e);
                } 
                   

    }//end of constantvarChkMethod
    
     
   
    //methodNameConvention
    
    public void chkMethodName(String str){
         system.debug('---constantvarChkMethod1 is called--');
         String className; 
         try{
          lines = str.split('\n');
          
          for(String line : lines){
          line = line.trim();
          system.debug('---line line----'+line);  
            
               
            
               for(Integer m = 0;m<varTypes.size();m++){
                   system.debug('----var type--'+varTypes[m]);
                   
                    if(
                (line.startsWith(varTypes[m]) && line.endsWith('){')) || (line.startsWith(varTypes[m].toLowerCase()) && line.endsWith('){'))
                ){
                    system.debug('[[[line]]]'+line);
                    String tempString;
                    Integer startIndexOfMethodName;
                    Integer charEndPosition;
                    Integer endIndexOfMethodName;
                    String tempStr;
                    String tempStr1;
                    String methodName;
                    Integer pos = line.indexOf('(');
                
                    String stre = line.subString(pos); 
                    String stre1 = line.replace(stre,'');
                    
                    for(Integer i =0;i<arrDataTypes.size();i++){
                    system.debug('---data types are----'+arrDataTypes[i]);
                    
                    if(stre1.contains(arrDataTypes[i])){
                        
                             
                             
                            Integer startIndexOfDatatype = stre1.indexOf(arrDataTypes[i]);
                             
                            system.debug('---line is---'+stre1+'---startIndexOfDatatype---'+arrDataTypes[i]+'--is*'+startIndexOfDatatype);
                            
                            startIndexofMethodName = startIndexOfDatatype + arrDataTypes[i].length();
                        
                            methodName = line.subString(startIndexofMethodName,pos);
                        
                            system.debug('----method name----'+methodName);
                            
                            String firstCharacter = line.subString(startIndexofMethodName,startIndexofMethodName+2);
                            
                            system.debug('---first character of method--'+methodName+'--is--'+firstCharacter );
                           
                            if(firstCharacter.equals(firstCharacter.toUpperCase())){
                                for(Integer x = startIndexofMethodName+2;x<pos-2;x++){
                                String singleChar = line.subString(x,x+1);
                                if(!(singleChar.equals(singleChar.toUpperCase()) )){
                                    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error, 'Method name should be in a camel case');
                                    ApexPages.addMessage(msg);
                                
                         }
                       }//end of for loop
                     }
                   }  
                 }
               }
             }   
           } 
         }catch(Exception e){
         system.debug('exception for methodName method is---'+e);
         }
         
    
    }//end of chkMethodName

    public void chkClassNameMethod(String str){
        lines = str.split('\n');
        String className;  
          for(String line : lines){
          line = line.trim();
          system.debug('---line line----'+line);  
          
          if(line.contains(' class ')){
              Integer classindex = line.indexof(' class ');
              system.debug('---clas index---'+classIndex);
              Integer startIndex = classIndex+line.indexOf(' class ');
              if(line.contains('{')){
              Integer braceIndex = line.indexOf('{');
              className = line.subString(startIndex,braceIndex );
              
              }else{
              className = line.subString(startIndex);
              
              }
          system.debug('---class name--'+className);
          String firstLetter = line.subString(startIndex+1,startIndex+2);
          if(!(firstLetter.equals(firstLetter.toUpperCase()))){
          system.debug('---first letter of a classname--'+firstLetter);
          system.debug('--degrade the percentage of code quality--');
          
          }
              
        }
        
        
                   
                   
                  
     }
     
     
     
   } 
   
   public void apexLimitMethod(String str){
try{
          lines = str.split('\n');
          
          system.debug('---line are--'+lines);
          for(String line : lines){
          line = line.trim();
       
          for(Integer y = 0;y<apexLimitMethods.size();y++){
          Integer countOfApexMethods=0;
         
          if(line.contains(apexLimitMethods[y])){
              countOfApexMethods++;
          }
          
          system.debug('--countOfApexMethods-----'+countOfApexMethods);
          if(countOfApexMethods==0){
              //reduce the code quality percentage
              system.debug('--degrade code quality--');
          }
          
      }
          
}
}catch(Exception e)   {
                system.debug('-----Exception of apexLimitMethod--'+e);
                }

}*/