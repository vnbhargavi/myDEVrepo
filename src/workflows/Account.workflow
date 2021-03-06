<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <outboundMessages>
        <fullName>Test1</fullName>
        <apiVersion>23.0</apiVersion>
        <endpointUrl>http://www.google.com</endpointUrl>
        <fields>Active__c</fields>
        <fields>BillingCountry</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>vnbhar@cap.com</integrationUser>
        <name>Test1</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>drtd</fullName>
        <apiVersion>26.0</apiVersion>
        <endpointUrl>http://www.google.co.in/</endpointUrl>
        <fields>BillingCity</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>vnbhar@cap.com</integrationUser>
        <name>drtd</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>test</fullName>
        <apiVersion>22.0</apiVersion>
        <endpointUrl>http://www.google.com</endpointUrl>
        <fields>Active__c</fields>
        <fields>BillingCountry</fields>
        <fields>Id</fields>
        <fields>TOMID__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>vnbhar@cap.com</integrationUser>
        <name>test</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Test</fullName>
        <actions>
            <name>Test1</name>
            <type>OutboundMessage</type>
        </actions>
        <actions>
            <name>drtd</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.BillingCountry</field>
            <operation>equals</operation>
            <value>India</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <timeLength>30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
