<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Email</fullName>
        <ccEmails>bhargavi.v@autorabit.com</ccEmails>
        <description>Send Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CustomerPortalNewUserEmail</template>
    </alerts>
    <alerts>
        <fullName>test</fullName>
        <description>test</description>
        <protected>false</protected>
        <recipients>
            <recipient>vnbhar@cap.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>vadlamani.bhargavi@gmail.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Autorabit_DF1</template>
    </alerts>
    <fieldUpdates>
        <fullName>update_Primary</fullName>
        <field>Primary__c</field>
        <literalValue>No</literalValue>
        <name>update Primary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>New Lead Notification</fullName>
        <actions>
            <name>Send_Email</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Company</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Value YEs</fullName>
        <actions>
            <name>test</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>update_Primary</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Primary__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
