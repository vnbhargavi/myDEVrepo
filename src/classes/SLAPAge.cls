global class SLAPAge
{
/*
<apex:page standardController="Account" extensions="Integrations_GetSLAReports_VFCExt" sidebar="false" showHeader="false">
<style type="text/css">
        .custPopup{
            background-color: #F8F8F8;
            border-width: 2px;
            border-style: solid;
            z-index: 9999;
            left: 50%;
            padding:10px;
            position: absolute;
            width: 250px;
            margin-left: -125px; // this has to be half of the width
            top:200px; // determines the distance from the top of screen
        }
        .popupBackground{
            background-color:black;
            opacity: 0.20;
            filter: alpha(opacity = 20);
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 9998;
        }

    </style>
<script type="text/javascript">

function displayAlert()
{
alert("Session Timed out, Kindly try after a few minutes");
callCloseMethod();
}

function callCloseMethod()
{
    window.close();
}


</script>
<apex:form >
   <apex:pageMessages /> 
   <apex:pageBlock >
      <apex:pageBlockSection title="SLA Reports">
          Choose a Month
             <apex:selectList value="{!month}" size="1" id="month"> 
                   <apex:selectOptions value="{!months}"/>
              </apex:selectList>
           Choose a Year   
              <apex:selectList value="{!year}" size="1" id="year">
                   <apex:selectOptions value="{!years}"/>
              </apex:selectList>  
        </apex:pageBlockSection>
           <apex:pageBlockButtons location="bottom">            
           <apex:commandButton value="Fetch Report" action="{!fetchReport}"  onclick="setTimeout('displayAlert()',45000)" rerender="tstpopup,ErrorWindow,TimeOutError,HttpMessageError" />  
           </apex:pageBlockButtons>
    </apex:pageBlock>

    <apex:outputPanel id="tstpopup">
        <apex:outputPanel styleClass="popupBackground" layout="block" rendered="{!displayPopUp}"/> 
        <apex:outputPanel styleClass="custPopup" layout="block" rendered="{!displayPopUp}">
            <center><img src="{!URLFOR($Resource.Waiting_dots)}" border="0" height="20px" width="196px" />
                <br />Getting Report, please wait....
            </center>
        </apex:outputPanel>
    </apex:outputPanel>
  
    <apex:outputPanel id="ErrorWindow">
        <apex:outputPanel layout="block" rendered="{!IF(displayErrorPopup=true,true,false)}">
            <center><font color = "Red">You can get SLA reports only from {!prevoiusMonthStr} {!previousYearInt} to {!currentMonthStr} {!showCurrentYearInt}</font></center>
        </apex:outputPanel>   
    </apex:outputPanel>

    <apex:outputPanel id="TimeOutError">
        <apex:outputPanel layout="block" rendered="{!TimeOutErrorStr != null}"> 
            <center><font color = "Red">{!TimeOutErrorStr}</font></center>
        </apex:outputPanel>   
    </apex:outputPanel>   
    
        <apex:outputPanel id="HttpMessageError">
        <apex:outputPanel layout="block" rendered="{!HttpMessageStr != null}"> 
            <center><font color = "Red">{!HttpMessageStr}</font></center>
        </apex:outputPanel>   
    </apex:outputPanel> 

        <apex:outputPanel id="PDF" rendered="{!IF(isEnabledBoolean=true,true,false)}"></apex:outputPanel>
        <apex:actionPoller action="{!pollingForAttachment}" rerender="PDF,tstpopup" interval="10" enabled="{!IF(TimeOutErrorStr != null,false,true)}"/>
      <!--  <apex:actionFunction name="sessionTimeOut" action="{!sessionTimeOut}" rerender="tstpopup,ErrorWindow,TimeOutError,HttpMessageError" /> -->
    </apex:form>  
</apex:page>
*/
}