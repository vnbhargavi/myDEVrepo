<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Insert_merchandise_Price</fullName>
        <field>Unit_Price__c</field>
        <formula>Merchandise__r.Price__c</formula>
        <name>Insert merchandise Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stock_Inventory</fullName>
        <field>Total_Inventory__c</field>
        <formula>IF (
ISNEW(),
Merchandise__r.Total_Inventory__c - Unit_Sold__c ,
Merchandise__r.Total_Inventory__c - (Unit_Sold__c - PRIORVALUE(Unit_Sold__c))
)</formula>
        <name>Update Stock Inventory</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Merchandise__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Line Item Created</fullName>
        <actions>
            <name>Insert_merchandise_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Line Item Updated</fullName>
        <actions>
            <name>Update_Stock_Inventory</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice__c.Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
