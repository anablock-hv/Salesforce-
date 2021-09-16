@isTest
public with sharing class BillingScheduleTriggerHandlerTest{
    private static List<SBQQ__Subscription__c> subsList = new List<SBQQ__Subscription__c>();
    private static List<Contract> contractsList = new List<Contract>();
    private static Billing_Schedule__c billingSchedule = new Billing_Schedule__c();
    private static List<Account> accList = new List<Account>();
    private static List<Opportunity> oppList = new List<Opportunity>();
    private static List<SBQQ__Quote__c> cpqQuoteList = new List<SBQQ__Quote__c>();
    private static List<SBQQ__QuoteLine__c> cpqQLIList = new List<SBQQ__QuoteLine__c>();
    private static List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
    @testSetup static void testSetup(){
        
        accList = TestingUtils.createAccounts(1);
        insert accList;
        
        oppList = TestingUtils.createOpportunities(accList, 'Core Sales', Date.today(), 'Qualification', 1);
        oppList[0].Bypass_Process__c = true;
        insert oppList;
        
        TestingUtils.insertProducts();
        
        TestingUtils.insertPricebookAndPricebookEntries();
        
        cpqQuoteList = TestingUtils.createCPQQuotes(oppList, 'Core Sales', 12, 1);
        QuoteTriggerHandler.skipTrigger = true;
        insert cpqQuoteList;
        
        cpqQLIList = TestingUtils.createCPQQuoteLineItems(cpqQuoteList, 1);
        QuoteLineTriggerHandler.skipTrigger = true;
        insert cpqQLIList;
        
        QuoteLineTriggerHandler.skipTrigger = false;
        oliList = TestingUtils.createOpportunityLineItems(oppList);
        insert oliList;
        
        QuoteTriggerHandler.skipTrigger = false;
        contractsList = TestingUtils.createContracts(cpqQuoteList, 'Core Sales');
        insert contractsList;
        
        subsList = TestingUtils.createSubscriptions(cpqQLIList);
        insert subsList;
        
    }
    static testmethod void billingScheduleAfterUpdate(){
        test.startTest();
        
        subsList = [SELECT Id FROM SBQQ__Subscription__c];
        contractsList = [SELECT Id FROM Contract];
        
        billingSchedule = TestingUtils.createBillingSchedule(contractsList.get(0).Id,  subsList.get(0).Id);
        billingSchedule.Billing_Amount__c = -100000; //to skip the validation rule
        insert billingSchedule;
        
        billingSchedule.Approved__c = true;
        update billingSchedule;
        
        test.stopTest();
    }
}