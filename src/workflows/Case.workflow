<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert</fullName>
        <description>Email Alert</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CommunityWelcomeEmailTemplate</template>
    </alerts>
    <alerts>
        <fullName>Send_Email</fullName>
        <description>Send Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>user.test1@cap.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Autorabit_DF1</template>
    </alerts>
    <fieldUpdates>
        <fullName>Field_Update</fullName>
        <field>Status</field>
        <literalValue>Escalated</literalValue>
        <name>Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update1</fullName>
        <field>Type</field>
        <literalValue>Electronic</literalValue>
        <name>Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status</fullName>
        <field>Reason</field>
        <literalValue>Equipment Complexity</literalValue>
        <name>Update Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Send_outbound_msg</fullName>
        <apiVersion>34.0</apiVersion>
        <endpointUrl>http://www.google.com</endpointUrl>
        <fields>CaseNumber</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>vnbhar@cap.com</integrationUser>
        <name>Send outbound msg</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Send_outbound_msg1</fullName>
        <apiVersion>34.0</apiVersion>
        <endpointUrl>http://www.google.com</endpointUrl>
        <fields>CaseNumber</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>vnbhar@cap.com</integrationUser>
        <name>Send outbound msg</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <tasks>
        <fullName>Approval_Action</fullName>
        <assignedTo>bvadlamani@dell.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>30</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Contact.LastCURequestDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Approval Action</subject>
    </tasks>
    <tasks>
        <fullName>Case_Approver_Task2</fullName>
        <assignedTo>sbg@sf.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>25</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Asset.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Case Approver Task2</subject>
    </tasks>
    <tasks>
        <fullName>Case_Rejected_Task</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>25</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Entitlement.EndDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Case Rejected Task</subject>
    </tasks>
    <tasks>
        <fullName>Request_for_approval</fullName>
        <assignedTo>icbcuser@sf.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>15</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.ClosedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Request for approval</subject>
    </tasks>
</Workflow>
