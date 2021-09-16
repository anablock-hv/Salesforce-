/**
* @name         TestingUtils
* @author       Sanjay Paryani
* @date         08/14/2018
* @description  Testdata factory for test classes
* @revisions	Date ------------ Name ------------ Comments 
**/
@isTest
public class TestingUtils {
     
	//Variables & Collections
	public static Profile profileStdUser {get; set;}
	public static Profile profileAdmin {get; set;}
	public static Profile profileIntegration {get; set;}
	public static User usrIntegration {get; set;}
	public static User usrAdmin {get; set;}
	public static User usrStdUser {get; set;}
    public static ID stdPricebookID {get; set;}
    public static Product2 prod1 {get; set;} 
    public static Zuora__UnitOfMeasure__c uom1 {get; set;}
    public static Zuora__UnitOfMeasure__c uom2 {get; set;}
    public static Zuora__UnitOfMeasure__c uom3 {get; set;}
    public static Zuora__UnitOfMeasure__c uom4 {get; set;}
    public static Map<Id, Contract> quoteToContractMap {get; set;}
    public static PricebookEntry stdPBE1 {get; set;}
    
	/**
	* @Description - This utility method will build a query for the given object
	* @param - sObjectName (String): accepts Object name.
	*
	* @Example with WHERE clause - acc = database.Query('SELECT ' + BuildQuery('Account') + ' WHERE Name = \'abcd\'');	
	* @Example with SELECT keyword - opp = database.Query('SELECT owner.email, owner.name, ' + BuildQuery('Opportunity'));	
	*/
	public static string buildQuery(String sObjectName) {
		Map<String, Schema.SObjectField> SobjtField = Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
		String qry = '';
		for(Schema.SObjectField s : SobjtField.values()) {
			qry += s + ',';
		}
		qry = qry.removeend(',');
		qry = qry + ' from ' + sObjectName;
		
		return qry;
	}  
     
	/**
	* @Description - This utility method returns the record type for given sObject and Record Type Name
	* @param - sObjectName (String): accepts sObject name. 
	* @param - recordTypeName (String): accepts record type name.
	* @return - Id for RecordType
	*/ 
    public static Id getRecordTypeId(String sObjectName, String recordTypeName) {
        RecordType recType = [SELECT Id FROM RecordType WHERE Name = :recordTypeName AND SobjectType = :sObjectName];
        return recType.Id;
    }

    /*Added by Mandeep
	* @Description - This method creates Customer_App__c.
	* @return - Customer_App__c object
	*/
    public static Customer_App__c createCustomerApp(Account  acc) {
    	Customer_App__c CustomerApp = new Customer_App__c();
        CustomerApp.Account__c = acc.Id;
        CustomerApp.Unity_App_IDs__c = 'unityId1';
        CustomerApp.Store_Id__c = 'store_id';
        return CustomerApp;
    }
    
    /*Added by Mandeep
	* @Description - This method creates Custom_Transaction__c.
	* @return - Customer_App__c object
	*/
    public static Custom_Transaction__c createcustomTransaction(list<Account> acc) {
    	Custom_Transaction__c ct = new Custom_Transaction__c();
        ct.Account_Id__c = acc[0].Id;
        ct.type__c='Prepaid';
        ct.Approval_Status__c = 'Pending';
        return ct;
    }
    
    
    /*Added by Mandeep
	* @Description - This method creates Opportunity_App__c.
	* @return - Opportunity_App__c object
	*/
    public static Opportunity_App__c createOpportunityApp(Opportunity opp, Customer_App__c app ) {
    	Opportunity_App__c OpportunityApp = new Opportunity_App__c();
        OpportunityApp.Opportunity__c = opp.Id;
        OpportunityApp.Customer_App__c = app.Id;
        return OpportunityApp;
    }
    
    /**
	* @Description - This method creates Incentive. 
    * @param - oppAppId (Id): Id of Opportunity App object.
	* @return - Incentive__c object
	*/	
    public static Incentive__c createIncentive(Id oppAppId) {
        
        Incentive__c incentive = new Incentive__c();
        incentive.Opportunity_App__c = oppAppId;
        incentive.Priority__c = 'None';
        incentive.Country_Condition__c = 'Global';
        incentive.Date_Begins__c = Date.today();
        incentive.Date_Ends__c = Date.today();
        incentive.Incentive_Type__c = 'Earnings Bonus';
        incentive.Calculation_Schedule__c = 'Annual';
        incentive.Value_currency__c = 1000;
        incentive.Value_percent__c = 10;
        
        return incentive;
    }

    /**
	* @Description - This method creates Indirect Bonus Incentive. 
    * @return - Incentive__c object
	*/	
    public static Incentive__c createIndBonusIncentive() {
        
        Incentive__c incentive = new Incentive__c();
        incentive.Priority__c = 'None';
        incentive.Country_Condition__c = 'Global';
        incentive.Date_Begins__c = Date.today();
        incentive.Date_Ends__c = Date.today();
        incentive.Incentive_Type__c = 'Earnings Bonus';
        incentive.Calculation_Schedule__c = 'Annual';
        incentive.Value_currency__c = 1000;
        incentive.Value_percent__c = 10;
        
        return incentive;
    }

    /**
	* @Description - This method creates Incentive Tier. 
    * @param - incentiveId (Id): Id of Incentive object.
	* @return - Incentive_Tier__c object
	*/	
    public static Incentive_Tier__c createIncentiveTier(Id incentiveId) {
        
        Incentive_Tier__c tier = new Incentive_Tier__c();
        tier.Incentive__c = incentiveId;
        tier.Eligibility_Timeframe__c = 'TBD';
        tier.Tier_Amount__c = 1000;
        tier.Tier_Percentage__c = 10;
        
        return tier;
    }

    /**
	* @Description - This method creates Earnings. 
    * @param - incentiveId (Id): Id of Incentive object.
    * @param - customerAppId (Id): Id of Customer App object.
	* @return - Earnings__c object
	*/	
    public static Earnings__c createEarning(Id incentiveId, Id customerAppId) {
        
        Earnings__c earn = new Earnings__c();
        earn.RELATED_INCENTIVE__C = incentiveId;
        earn.RELATED_APP__C = customerAppId;
        earn.PERIOD_BEGINS__C = Date.today();
        earn.PERIOD_ENDS__C = Date.today();
        earn.CALCULATED_BEGINS__C = Date.today();
        earn.CALCULATED_ENDS__C = Date.today();
        earn.SOURCE_REVENUE__C = 5000;
        earn.SOURCE_SPEND__C = 1;
        earn.CALCULATED_AMOUNT__C = 1000;
        earn.STATUS__C = 'Pending';
        earn.CALCULATION_ERROR__C = 'Other';
        earn.STATUS_REASON__C = 'Fraud Review';
        earn.DATE_ESCALATED__C = Date.today();
        earn.DATE_APPROVED__C = Date.today();
        earn.DATE_ON_HOLD__C = Date.today();
        earn.DATE_REJECTED__C = Date.today();
        earn.ON_HOLD_REASON__C = 'Fraud Review';
        earn.Earnings_Type__c = 'Standard';
        
        return earn;
    }
      
	/**
	* @Description - This method calls all of the other methods.
	* Note: Must be used within @testSetup method.
	*/	
    public static void insertDefaultObjects() {
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        List<SBQQ__Quote__c> cpqQuoteList = new List<SBQQ__Quote__c>();
        List<SBQQ__QuoteLine__c> cpqQLIList = new List<SBQQ__QuoteLine__c>();
        
        Test.startTest();
        insertUsers();
        insertProducts();
        insertPricebookAndPricebookEntries();
        //insertCustomSettings();
        // Parameters for createAccounts(): Integer numAccts
        accList = createAccounts(1);
        insert accList;
        // Parameters for createOpportunities(): List<Account> objects, String recordTypeName, Date closeDate, String stage, Integer numOpps
        oppList = createOpportunities(accList, 'Core Sales', date.today(), 'Qualification', 1);
        insert oppList;
        // Parameters for createOpportunityLineItems(): List<Opportunity> objects 
        oliList = createOpportunityLineItems(oppList);
        insert oliList;
        // Parameters for createCPQQuotes(): List<Opportunity> objects, String recordTypeName, Integer term, Integer numQuotes	
        cpqQuoteList = createCPQQuotes(oppList, 'Core Sales', 12, 1);
        insert cpqQuoteList;
        // Parameters for createCPQQuoteLineItems(): List<SBQQ__Quote__c> objects, Integer quantity	
        cpqQLIList = createCPQQuoteLineItems(cpqQuoteList, 1);
        insert cpqQLIList;
        Test.stopTest();
    }	

	/**
	* @Description - This method creates Accounts. 
	* @param - numAccts (Integer): accepts number of accounts.
	* @return - List<Account> objects
	*/	
    public static List<Account> createAccounts(Integer numAccts) {
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='testAccount' + i,BillingCountry='United States',BillingCity='Santa Clara',BillingStreet='111 West California Avenue',Num_of_Active_Contracts__c=0);  
            accList.add(a);
        }
        return accList;
    }
    
	/**
	* @Description - This method creates Accounts. 
	* @param RecordType (String): accepts RecordType name for accounts.
	* @param accountName (String): accepts name for accounts.
	* @param numAccts (Integer): accepts number of accounts.
	* @return - List<Account> objects
	*/	    
    public static List<Account> createAccounts(String recordTypeName, String accountName, Integer numAccts) {
        List<Account> accList = new List<Account>();
        Id recordTypeID = getRecordTypeId('Account', recordTypeName);
        
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(
                Name = accountName + i,
            	RecordTypeId = recordTypeID
            );  
            accList.add(a);
        }
        return accList; 
    }    

	/**
	* @Description - This method creates Contacts. 
	* @param accList (List): accepts list of accounts.
	* @param numContacts (Integer): accepts number of contacts.
	* @return - List<Contact> objects
	*/	
    public static List<Contact> createContacts(List<Account> accList, Integer numContacts) {
        List<Contact> ctList = new List<Contact>();
        for(Integer i=0; i<accList.size(); i++) {
            for(Integer j=0;j<numContacts;j++) {
                Contact c = new Contact(
                    FirstName = 'FName' + '-' + i + '-' + j,
                    LastName = 'LName' + '-' + i + '-' + j,
                    AccountId = accList[i].Id,
                    Email = i + '_' + j + '_' + 'testEmail_' + '@testunity.com'
                );
                ctList.add(c);            	    
            }
        }
        return ctList;
    }
    
	/**
	* @Description - This method creates Contacts. 
	* @param - accList (List): accepts list of accounts.
	* @param - FirstName (String): accepts first name of Contact as string.
	* @param - LastName (String): accepts last name of Contact as string.
	* @return - List<Contact> objects
	*/	
    public static List<Contact> createContacts(List<Account> accList, String fName, String lName, String email, Integer numContacts) {
		List<Contact> ctList = new List<Contact>();
		for(Integer i=0; i<accList.size(); i++){
            for(Integer j=0;j<numContacts;j++) {
                Contact c = new Contact(
                    AccountId = accList[i].Id,
                    FirstName= fName + '-' + i + '-' + j,
                    LastName = lName + '-' + i + '-' + j,
                    email = i + '_' + j + '_' + email
                );
                ctList.add(c);
            }
		}
        return ctList;
    }    
    
	/**
	* @Description - This method creates default User records: Admin user, SFDC user, and Standard User.
	*/	
	public static void insertUsers() {
        // Generating a Unique Name
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;        
        
		profileStdUser = [SELECT ID FROM Profile WHERE Name = 'Standard User'];
		profileAdmin = [SELECT ID FROM Profile WHERE Name = 'System Administrator'];
		profileIntegration = [SELECT ID FROM Profile WHERE Name = 'System Integration/Testing'];
		usrIntegration = new User(firstname = 'test', lastname = 'usrSFDC', email = 'usrSFDC' + uniqueName + '@test' + orgId + '.org', username =  'usrSFDC' + uniqueName + '@test' + orgId + '.org', alias = uniqueName.substring(18, 23), TimeZoneSidkey = 'GMT', LocaleSidKey = 'en_US', emailencodingKey = 'UTF-8', languagelocalekey = 'en_US', ProfileId = profileIntegration.ID);
		usrAdmin = new User(firstname = 'test', lastname = 'usrAdmin', email = 'usrAdmin' + uniqueName + '@test' + orgId + '.org', username =  'usrAdmin' + uniqueName + '@test' + orgId + '.org', alias = uniqueName.substring(18, 23), TimeZoneSidkey = 'GMT', LocaleSidKey = 'en_US', emailencodingKey = 'UTF-8', languagelocalekey = 'en_US', ProfileId = profileAdmin.ID);
		usrStdUser = new User(firstname = 'test', lastname = 'usrStdUser', email = 'usrStdUser' + uniqueName + '@test' + orgId + '.org', username =  'usrStdUser' + uniqueName + '@test' + orgId + '.org', alias = uniqueName.substring(18, 23), TimeZoneSidkey = 'GMT', LocaleSidKey = 'en_US', emailencodingKey = 'UTF-8', languagelocalekey = 'en_US', ProfileId = profileStdUser.ID);
	
		List<User> userList = new List<User> {usrIntegration, usrAdmin, usrStdUser};
		insert userList;
	}	

	/**
	* @Description - This method creates Users.
	* @param - profileName (String): accepts name for Profile.
	* @param - numUsers (Integer): accepts number of users.
	* @return - List<User> objects
	*/	
	public static List<User> createUsers(String profileName, Integer numUsers) {
        // Generating a Unique Name
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;    
        
        // Querying for the Profile record matching the input profile name.
		Profile prof = [SELECT ID FROM Profile WHERE Name = :profileName];
        List<User> usrList = new List<User>();
        for(Integer i=0;i<numUsers;i++) {
 			User usr = new User(
                firstname = 'test',
                lastname = 'usr',
                email = 'usr' + uniqueName + '@test' + orgId + '.org',
                username =  'usr' + uniqueName + '@test' + orgId + '.org',
                alias = uniqueName.substring(18, 23),
                TimeZoneSidkey = 'GMT',
                LocaleSidKey = 'en_US',
                emailencodingKey = 'UTF-8',
                languagelocalekey = 'en_US',
                ProfileId = prof.Id
            );
            usrList.add(usr);
        }
		return usrList;
	}	
    
	/**
	* @Description - This method creates Users.
	* @param - profileName (String): accepts name for Profile.
	* @param - numUsers (Integer): accepts number of users.
	* @return - List<User> objects
	*/	
	public static List<User> createUsers(String profileName, String roleName, Integer numUsers) {
        // Generating a Unique Name
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;    
        
        // Querying for the Profile record matching the input profile name.
		Profile prof = [SELECT ID FROM Profile WHERE Name = :profileName];
        // Querying for the Role record matching the input Role name.
        UserRole rol = [SELECT Id FROM UserRole WHERE DeveloperName = :roleName];
        List<User> usrList = new List<User>();
        for(Integer i=0;i<numUsers;i++) {
 			User usr = new User(
                firstname = 'test',
                lastname = 'usr',
                email = 'usr' + uniqueName + '@test' + orgId + '.org',
                username =  'usr' + uniqueName + '@test' + orgId + '.org',
                alias = uniqueName.substring(18, 23),
                TimeZoneSidkey = 'GMT',
                LocaleSidKey = 'en_US',
                emailencodingKey = 'UTF-8',
                languagelocalekey = 'en_US',
                ProfileId = prof.Id,
                UserRoleId = rol.Id
            );
            usrList.add(usr);
        }
		return usrList;
	}  

	/**
	* @Description - This method inserts any custom settings that need to be populated.
	*/	
	public static void insertOverrideRules(Boolean ovrCS, Boolean ovrTrigger, Boolean ovrValidation, Boolean ovrWF) {
		OverrideRules__c  rule = new OverrideRules__c();
        rule.OverrideCustomScripts__c = ovrCS;
        rule.OverrideTrigger__c = ovrTrigger;
        rule.OverrideValidations__c = ovrValidation;
        rule.OverrideWorkflows__c = ovrWF;
        
        insert rule;
	}
    
	/**
	* @Description - This method inserts Products.
	*/	
	public static void insertProducts() {
    	uom1 = new Zuora__UnitOfMeasure__c();  
        uom1.Name = 'License';
        uom1.Zuora__External_Id__c = '2c92c0f963004d9e01631a383b7b4605';
        insert uom1;        
		// Inserting Unity Pro product
		prod1 = new Product2();
		prod1.Name = 'Unity Pro';
        prod1.ProductCode = 'UTY-PRO';
		prod1.Family = 'License';
		prod1.IsActive = true;
        prod1.Num_of_Unity_Pro_Seats__c = '1-10;11-50;50+';
		prod1.SBQQ__PricingMethod__c = 'List';
		prod1.SBQQ__QuantityEditable__c = true;
		prod1.SBQQ__SortOrder__c = 1;
		prod1.SBQQ__BlockPricingField__c = 'Quantity';
		prod1.SBQQ__SubscriptionType__c = 'Renewable';
		prod1.SBQQ__SubscriptionPricing__c = 'Fixed Price';
		prod1.SBQQ__SubscriptionTerm__c = 1;
		prod1.SBQQ__SubscriptionBase__c = 'List';
		prod1.SBQQ__OptionSelectionMethod__c = 'Click';
		prod1.SBQQ__AssetConversion__c = 'One per quote line';
        prod1.SBQQ__BillingFrequency__c  = '';
        prod1.SBQQ__ChargeType__c = '';
		prod1.SBQQ__IncludeInMaintenance__c = false;
        prod1.SBQQ__ExcludeFromMaintenance__c = false;
        prod1.ZSB__ProductName__c = 'Unity Pro';
        prod1.ZSB__ProductEffectiveStartDate__c = Date.parse('1/1/2018');
        prod1.ZSB__ProductEffectiveEndDate__c = Date.parse('8/7/2099');
        prod1.ZSB__PRPChargeName__c = 'Unity Pro';
        prod1.ZSB__PRPChargeChargeType__c = 'Recurring';
        prod1.ZSB__PRPChargeChargeModel__c = 'Per Unit Pricing';
        prod1.ZSB__PRPChargeUOM__c = uom1.Id;
        prod1.ZSB__PRPChargeBillCycleType__c = 'Subscription Start Day';
        prod1.ZSB__PRPChargeBillingPeriodAlignment__c = 'Align To Charge';
        prod1.ZSB__PRPlanEffectiveStartDate__c = Date.parse('1/1/2018');
        prod1.ZSB__PRPlanEffectiveEndDate__c = Date.parse('8/7/2099');
        prod1.Revenue_Category__c = 'Cloud'; 
        insert prod1;
	}    

	/**
	* @Description - This method inserts Pricebooks for CPQ and Salorma. It also inserts Pricebook entries.
	*/	
	public static void InsertPricebookAndPricebookEntries() {
		stdPricebookID = Test.getStandardPricebookId();
		List<PricebookEntry> pbeList = new List<PricebookEntry>();
		List<Pricebook2> pbList = new List<Pricebook2>();
		
		stdPBE1 = new PricebookEntry(Pricebook2Id = stdPricebookID, Product2Id = prod1.Id, UnitPrice = 1500, IsActive = true);
		pbeList.add(stdPBE1);
		// Inserting PricebookEntries
        insert pbeList;
	}

	/**
	* @Description - This method creates Opportunities. 
	* @param - accList (List): accepts list of accounts.
	* @param - RecordType (String): accepts RecordType name for Opportunities.
	* @param - closeDate (Date): accepts date for Opportunity CloseDate.
	* @param - stage (String): accepts name for Opportunity Stage Name.
	* @param - numOpps (Integer): accepts number of opportunities.
	* @return - List<Opportunity> objects
	*/	    
    public static List<Opportunity> createOpportunities(List<Account> accList, String recordTypeName, Date closeDate, String stage, Integer numOpps) {
		List<Opportunity> oppList = new List<Opportunity>();
        Id recordTypeID = getRecordTypeId('Opportunity', recordTypeName);
        
		for(Integer i=0; i<accList.size(); i++) {
            for(Integer j=0; j<numOpps; j++) {
                    Opportunity oppty = new Opportunity(
                        AccountId = accList[i].Id,
                        Name = 'Test Opportunity' + '-' + i + '-' + j,
                        CloseDate = closeDate,
                        Start_Date__c = Date.today(),
                        End_Date__c = Date.today().addDays(364),
                        StageName = stage,
                        Pricebook2Id = stdPricebookID,
                        CurrencyIsoCode = 'USD',
                        SBQQ__QuotePricebookId__c = stdPricebookID,
                        RecordTypeId = recordTypeID,
                        Bill_To_Account__c = accList[i].Id,
                        PO_Number__c = '123456'
                    );                
                    oppList.add(oppty);	
            }
		}
		return oppList;    	
    }

    	/**
	* @Description - This method creates Opportunities. 
	* @param - accList (List): accepts list of accounts.
	* @param - recordTypeName (String): accepts RecordType name for Opportunities.
	* @param - opportunityType (String): accepts Type for Opportunities.
	* @param - closeDate (Date): accepts date for Opportunity CloseDate.
	* @param - stage (String): accepts name for Opportunity Stage Name.
	* @param - numOpps (Integer): accepts number of opportunities.
	* @return - List<Opportunity> objects
	*/	    
    public static List<Opportunity> createOpportunities(List<Account> accList, String recordTypeName, String opportunityType, Date closeDate, String stage, Integer numOpps) {
		List<Opportunity> oppList = new List<Opportunity>();
        Id recordTypeID = getRecordTypeId('Opportunity', recordTypeName);
        
		for(Integer i=0; i<accList.size(); i++) {
            for(Integer j=0; j<numOpps; j++) {
                if(opportunityType == 'Renewal') {
                    Opportunity oppty = new Opportunity(
                        AccountId = accList[i].Id,
                        Name = 'Test Opportunity' + '-' + i + '-' + j,
                        CloseDate = closeDate,
                        StageName = stage,
                        Start_Date__c = Date.today(),
                        End_Date__c = Date.today().addDays(364),
                        Pricebook2Id = stdPricebookID,
                        CurrencyIsoCode = 'USD',
                        SBQQ__QuotePricebookId__c = stdPricebookID,
                        RecordTypeId = recordTypeID,
                        Type = opportunityType,
                        SBQQ__Renewal__c = true
                    );                
                    oppList.add(oppty);	
                } else {
                    Opportunity oppty = new Opportunity(
                        AccountId = accList[i].Id,
                        Name = 'Test Opportunity' + '-' + i + '-' + j,
                        CloseDate = closeDate,
                        StageName = stage,
                        Start_Date__c = Date.today(),
                        End_Date__c = Date.today().addDays(364),
                        Pricebook2Id = stdPricebookID,
                        CurrencyIsoCode = 'USD',
                        SBQQ__QuotePricebookId__c = stdPricebookID,
                        RecordTypeId = recordTypeID,
                        Type = opportunityType
                    );                
                    oppList.add(oppty);	                    
                }           	    
            }
		}
		return oppList;    	
    }

    /**
	* @Description - This method creates Opportunity Line Items
	* @param - oppList (List<Opportunity>): accepts list of opportunities.
	* @return - List<OpportunityLineItem> objects
	*/	
	public static List<OpportunityLineItem> createOpportunityLineItems(List<Opportunity> oppList) {
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        for(Integer i=0; i<oppList.size(); i++) {
            OpportunityLineItem oli1 = new OpportunityLineItem(
                OpportunityId = oppList[i].Id,
                totalprice = 1500,
                Quantity = 1,
                PricebookEntryId = stdPBE1.ID,
                Product2Id = prod1.Id
            );
            oliList.add(oli1);            
        }
        return oliList; 
    }

    /**
	* @Description - This method inserts SBQQ quotes.
	* @param - oppList (List<Opportunity>): accepts list of opportunities.
	* @param - recordTypeName (String): accepts RecordType name for CPQ Quotes.
	* @param - term (Integer): accepts term in months.
	* @param - numQuotes (Integer): accepts number of CPQ Quotes.
	* @return - List<SBQQ__Quote__c> objects
	*/	
	public static List<SBQQ__Quote__c> createCPQQuotes(List<Opportunity> oppList,  String recordTypeName, Integer term, Integer numQuotes) {
    	List<SBQQ__Quote__c> quoteList = new List<SBQQ__Quote__c>();
        Id recordTypeID = getRecordTypeId('SBQQ__Quote__c', recordTypeName);
        
        for(Integer i=0; i<oppList.size(); i++) {
            for(Integer j=0; j<numQuotes; j++) {
                if(j == 0) {
                    SBQQ__Quote__c primaryCPQQuote = new SBQQ__Quote__c(
                        SBQQ__StartDate__c = Date.today(),
                        SBQQ__Account__c = oppList[i].AccountID,
                        SBQQ__Opportunity2__c = oppList[i].ID,
                        SBQQ__PriceBook__c = stdPricebookID,
                        CurrencyIsoCode = 'USD',
                        SBQQ__SubscriptionTerm__c = term,
                        SBQQ__Primary__c = TRUE,
                        SBQQ__QuoteLanguage__c = 'English',
                        RecordTypeId = recordTypeID
                    );
                    quoteList.add(primaryCPQQuote);   
                } else {
                    SBQQ__Quote__c cpqQuote = new SBQQ__Quote__c(
                        SBQQ__StartDate__c = Date.today(),
                        SBQQ__Account__c = oppList[i].AccountID,
                        SBQQ__Opportunity2__c = oppList[i].ID,
                        SBQQ__PriceBook__c = stdPricebookID,
                        CurrencyIsoCode = 'USD',
                        SBQQ__SubscriptionTerm__c = term,
                        SBQQ__QuoteLanguage__c = 'English',
                        RecordTypeId = recordTypeID
                    ); 
                    quoteList.add(cpqQuote);  
                }                          	
            }
        }
        return quoteList;
    }		

        /**
	* @Description - This method inserts SBQQ quotes.
	* @param - oppList (List<Opportunity>): accepts list of opportunities.
	* @param - recordTypeName (String): accepts RecordType name for CPQ Quotes.
	* @param - term (Integer): accepts term in months.
	* @param - quoteType (String): accepts Type for CPQ Quotes.
	* @param - numQuotes (Integer): accepts number of CPQ Quotes.
	* @return - List<SBQQ__Quote__c> objects
	*/	
	public static List<SBQQ__Quote__c> createCPQQuotes(List<Opportunity> oppList, String recordTypeName, Integer term, String quoteType, Integer numQuotes) {
    	List<SBQQ__Quote__c> quoteList = new List<SBQQ__Quote__c>();
        Id recordTypeID = getRecordTypeId('SBQQ__Quote__c', recordTypeName);
        
        for(Integer i=0; i<oppList.size(); i++) {
            for(Integer j=0; j<numQuotes; j++) {
                if(j == 0) {
                    SBQQ__Quote__c primaryCPQQuote = new SBQQ__Quote__c(
                        //SBQQ__StartDate__c = Date.newInstance(2018, 4, 9),
                        SBQQ__StartDate__c = system.today(),//AV-TEST-CHG	                        
                        SBQQ__Account__c = oppList[i].AccountID,
                        SBQQ__Opportunity2__c = oppList[i].ID,
                        SBQQ__PriceBook__c = stdPricebookID,
                        CurrencyIsoCode = 'USD',
                        SBQQ__SubscriptionTerm__c = term,
                        SBQQ__Primary__c = TRUE,
                        SBQQ__QuoteLanguage__c = 'English',
                        SBQQ__Type__c = quoteType,
                        RecordTypeId = recordTypeID
                    );
                    quoteList.add(primaryCPQQuote);   
                } else {
                    SBQQ__Quote__c cpqQuote = new SBQQ__Quote__c(
                        SBQQ__StartDate__c = Date.newInstance(2018, 4, 9),
                        SBQQ__Account__c = oppList[i].AccountID,
                        SBQQ__Opportunity2__c = oppList[i].ID,
                        SBQQ__PriceBook__c = stdPricebookID,
                        CurrencyIsoCode = 'USD',
                        SBQQ__SubscriptionTerm__c = term,
                        SBQQ__QuoteLanguage__c = 'English',
                        SBQQ__Type__c = quoteType,
                        RecordTypeId = recordTypeID
                    ); 
                    quoteList.add(cpqQuote);  
                }                          	
            }
        }
        return quoteList;
    }

    /**
	* @Description - This method inserts SBQQ quote line items for a SBQQ Quote.
	* @param - quoteList (List<SBQQ__Quote__c>): accepts list of cpq quotes.
	* @param - quantity (Integer): accepts quantity for product.
	* @return - List<SBQQ__QuoteLine__c> objects
	*/	    
	public static List<SBQQ__QuoteLine__c> createCPQQuoteLineItems(List<SBQQ__Quote__c> quoteList, Integer quantity) {
    	List<SBQQ__QuoteLine__c> cpqQLIList = new List<SBQQ__QuoteLine__c>();
        for(Integer i=0; i<quoteList.size(); i++) {
            //Prod1 - Product Family: License
            SBQQ__QuoteLine__c cpqQLI1 = new SBQQ__QuoteLine__c(
                SBQQ__Quote__c = quoteList[i].ID,
                SBQQ__Product__c = prod1.ID,
                SBQQ__PricingMethod__c='List',
                SBQQ__ListPrice__c = 1500,
                SBQQ__NetPrice__c = 1500,
                sbqq__quantity__c = quantity,
                SBQQ__ChargeType__c = 'One-Time',
                SBQQ__BillingFrequency__c = '',
                SBQQ__BillingType__c = ''            
            );
            cpqQLIList.add(cpqQLI1);
        }
    	return cpqQLIList;
    }    

    /**
	* @Description - This method inserts contracts for a SBQQ Quote.
	* @param - quoteList (List<SBQQ__Quote__c>): accepts list of SBQQ Quotes.
	* @return - List<Contract> objects
	*/	    
	public static List<Contract> createContracts(List<SBQQ__Quote__c> cpqQuoteList) {
    	List<Contract> contractList = new List<Contract>();
        quoteToContractMap = new Map<Id, Contract>();
        for(Integer i=0;i<cpqQuoteList.size();i++) {
        	Contract cntrct = new Contract(
                AccountID = cpqQuoteList[i].SBQQ__Account__c,
                SBQQ__Opportunity__c = cpqQuoteList[i].SBQQ__Opportunity2__c,
                Status  = 'Draft',
                ContractTerm = (Integer) cpqQuoteList[i].SBQQ__SubscriptionTerm__c,
                StartDate = cpqQuoteList[i].SBQQ__StartDate__c,
                SBQQ__Quote__c = cpqQuoteList[i].Id
            );	
            contractList.add(cntrct);
            quoteToContractMap.put(cpqQuoteList[i].Id, cntrct);
        }
    	return contractList;
    }

        /**
	* @Description - This method inserts contracts for a SBQQ Quote.
	* @param - quoteList (List<SBQQ__Quote__c>): accepts list of SBQQ Quotes.
	* @param - recordTypeName (String): accepts RecordType name for Contracts.
	* @return - List<Contract> objects
	*/	    
	public static List<Contract> createContracts(List<SBQQ__Quote__c> cpqQuoteList, String recordTypeName ) {
    	List<Contract> contractList = new List<Contract>();
        Id recordTypeID = getRecordTypeId('Contract', recordTypeName);        
        
        quoteToContractMap = new Map<Id, Contract>();
        for(Integer i=0;i<cpqQuoteList.size();i++) {
        	Contract cntrct = new Contract(
                AccountID = cpqQuoteList[i].SBQQ__Account__c,
                SBQQ__Opportunity__c = cpqQuoteList[i].SBQQ__Opportunity2__c,
                Status  = 'Draft',
                ContractTerm = (Integer) cpqQuoteList[i].SBQQ__SubscriptionTerm__c,
                StartDate = cpqQuoteList[i].SBQQ__StartDate__c,
                SBQQ__Quote__c = cpqQuoteList[i].Id,
                RecordTypeId = recordTypeID
            );	
            contractList.add(cntrct);
            quoteToContractMap.put(cpqQuoteList[i].Id, cntrct);
        }
    	return contractList;
    }
    
    /**
	* @Description - This method creates subscriptions for SBQQ Quote Lines.
	* @param - cpqQLIList (List<SBQQ__QuoteLine__c>): accepts list of SBQQ Quote Lines.
	* @return - List<SBQQ__Subscription__c> objects
	*/	    
	public static List<SBQQ__Subscription__c> createSubscriptions(List<SBQQ__QuoteLine__c> cpqQLIList) {
    	List<SBQQ__Subscription__c> subscriptionsList = new List<SBQQ__Subscription__c>(); 
        for(Integer i=0;i<cpqQLIList.size();i++) {
        	SBQQ__Subscription__c sub = new SBQQ__Subscription__c(
                SBQQ__QuoteLine__c = cpqQLIList[i].Id, 
                SBQQ__Product__c = cpqQLIList[i].SBQQ__Product__c,
                SBQQ__Contract__c = quoteToContractMap.get(cpqQLIList[i].SBQQ__Quote__c).Id,
                SBQQ__NetPrice__c = 100,
                SBQQ__Quantity__c = 1,
                SBQQ__SegmentQuantity__c = 1, 
                SBQQ__SegmentIndex__c = i + 1,SBQQ__SegmentKey__c = String.valueOf(i + 1)          	     
            );
            subscriptionsList.add(sub);
        }
        return subscriptionsList;
    }
	
     /**
	* @Description - This method creates Zuora Customer Account
	* @Author - Ganesh Chedella
	* @param - accountId (Id): accepts account record ID
	* @return - Zuora__CustomerAccount__c
	*/	 
    public static Zuora__CustomerAccount__c createZuoraCustomerAccount(Id accountId){
        Zuora__CustomerAccount__c zca = new Zuora__CustomerAccount__c(
            Zuora__Account__c = accountId,
            Zuora__Status__c  = 'Active',
            Zuora__AccountNumber__c  = 'SF9000045-DK-USD-001'
        );
        return zca;
    }
     /**
	* @Description - This method creates Zuora subscription
	* @Author - Ganesh Chedella
	* @param - accountId,zuoraCustomerAccountId (Id,Id): accepts account Record ID and zuora customer account Id
	* @return - Zuora__Subscription__c
	*/	 
    public static Zuora__Subscription__c createZuoraSubscription(Id accountId,Id zuoraCustomerAccountId){
        Zuora__Subscription__c zs = new Zuora__Subscription__c(
        	Zuora__Account__c = accountId,
            Zuora__CustomerAccount__c = zuoraCustomerAccountId,
            Zuora__InvoiceOwner__c = zuoraCustomerAccountId,
            Zuora__InitialTerm__c = '36 Months'
        );
        return zs;
    }
     /**
	* @Description - This method creates Zuora Product charge for Zuora Subscription
	* @Author - Ganesh Chedella
	* @param - zuoraSubscriptionId,accountId (Id,Id): accepts Zuora Subscripiton ID and account record Id
	* @return - List<SBQQ__Subscription__c> objects
	*/	 
    public static Zuora__SubscriptionProductCharge__c  createProductCharge(Id zuoraSubscriptionId,Id accountId){
        Zuora__SubscriptionProductCharge__c pc = new Zuora__SubscriptionProductCharge__c(
            Zuora__Account__c  = accountId,
            Zuora__Subscription__c = zuoraSubscriptionId
        );
        return pc;
    }

    /**
    * @Description - This method creates Business Line. 
    * @param - numLines (Integer): number of Business Lines
    * @return - List<Business_Line__c> objects
    */  
    public static List<Business_Line__c> createBusinessLines(Integer numLines) { 
        List<Business_Line__c> businessLineList = new List<Business_Line__c>();  
        for(Integer i = 0; i < numLines; i++) {
            Business_Line__c line = new Business_Line__c();
            businessLineList.add(line);
        }
        return businessLineList;
    }

    /**
    * @Description - This method creates Business Line Summary Records. 
    * @param - numLines (Integer): number of Business Line Summary
    * @param - Business_Line__c(Id): Business Line Id
    * @return - List<Business_Line_Summary__c> objects
    */  
    public static List<Business_Line_Summary__c> createBusinessLinesSummary(Integer numLines, Id businessLineId) { 
        List<Business_Line_Summary__c> businessLineSummaryList = new List<Business_Line_Summary__c>();  
        for(Integer i = 0; i < numLines; i++) {
            Business_Line_Summary__c line = new Business_Line_Summary__c();
            line.Business_Line__c = businessLineId;
            businessLineSummaryList.add(line);
        }
        return businessLineSummaryList;
    }
    //CRM-4228
    public static WorkRamp_Assignment__c createworkRampRecord(){
        WorkRamp_Assignment__c workRampRecord = new WorkRamp_Assignment__c();
        workRampRecord.Assignee__c = 'test@gmail.com';
        workRampRecord.WorkRampId__c = '33e606c4-7366-11ea-a4f1-06cf503dca07';
        workRampRecord.PercentComplete__c = 70;
        workRampRecord.AssignedDate__c = Date.newInstance(2020, 03, 31);
        workRampRecord.WorkRampTrainingType__c = 'Guide';
        workRampRecord.WorkRampTrainingId__c = '6d8d8a2c-0003-11ea-8a0f-06cf503dca07';
        return workRampRecord;
    }
    //CRM-4228

    
    /**
    * @Description - This method creates BillingSchedule__c Record. 
    * @param - Contract(Id) : Contract Id
    * @param - SBQQ__Subscription__c(Id) : SFDC_Subscription__c Id
    * @return - List<Billing_Schedule__c> object
    */  
    public static Billing_Schedule__c createBillingSchedule(Id contractId, Id subscripitonId) { 
        Billing_Schedule__c billingSchedule = new Billing_Schedule__c(
            Contract__c = contractId,
            Billing_Amount__c = 5000,
            Description__c = 'Testing',
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(1),
            SFDC_Subscription__c = subscripitonId
        );
        return billingSchedule;
    }
    
    
}