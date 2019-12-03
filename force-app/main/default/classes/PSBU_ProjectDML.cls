/**
* Company : DCIT
* Description : *
* This class 
*
*************************************************************************************
***
* History :
* [26.Sep.2019] Jones Yang - Code Creation */

public with sharing class PSBU_ProjectDML {
    
    public PSBU_ProjectDML() {
    }


    //find all account name.
    public static List<Account> getAccounts(){    
        List<Account> listAcccounts = [select Id, Name from Account ];
        return listAcccounts;
    }

    //Description: similar project group condition, rule include opportuinty Designing Institute, factory and Product, return group list data.
    public static List<AggregateResult> getDesigningInstituteOppProductsAgg(){    
        List<AggregateResult> groupedResults = [select count(Id), Factory__c, Product__r.Name,OpportunityName__r.DesigningInstitute__c
        from OpportunityProductLineItem__c where OpportunityName__r.DesigningInstitute__c != null and OpportunityName__r.SimilarProjectCondition__c =: true group by Factory__c,Product__r.Name,OpportunityName__r.DesigningInstitute__c];
        return groupedResults;
    }

    //Description: simalar group condition 
    public static List<OpportunityProductLineItem__c> getDesigningInstituteOppProducts(){    
        List<OpportunityProductLineItem__c> listOppProductItems = [select Id, Factory__c, Product__r.Name,OpportunityName__r.DesigningInstitute__c, OpportunityName__c 
        from OpportunityProductLineItem__c where OpportunityName__r.DesigningInstitute__c != null and OpportunityName__r.SimilarProjectCondition__c =: true ];
        return listOppProductItems;
    }

    //Description: similar project group condition, rule include opportuinty shipyard, factory and Product, return group list data.
    public static List<AggregateResult> getShipyardOppProductsAgg(){    
        List<AggregateResult> groupedResults = [select count(Id), Factory__c, Product__r.Name,OpportunityName__r.Shipyard__c 
        from OpportunityProductLineItem__c where OpportunityName__r.Shipyard__c != null and OpportunityName__r.SimilarProjectCondition__c =: true group by Factory__c,Product__r.Name,OpportunityName__r.Shipyard__c];
        return groupedResults;
    }

    //
    public static List<OpportunityProductLineItem__c> getShipyardOppProducts(){    
        List<OpportunityProductLineItem__c> listOppProductItems = [select Id, Factory__c, Product__r.Name,OpportunityName__r.Shipyard__c, OpportunityName__c 
        from OpportunityProductLineItem__c where OpportunityName__r.Shipyard__c != null and OpportunityName__r.SimilarProjectCondition__c =: true ];
        return listOppProductItems;
    }    

    //find all project name length are more than 6, and similar project condition.
    public static List<Opportunity> getOppName(){    
        List<Opportunity> listOppProjectName = [select Id, Name from Opportunity where SimilarProjectCondition__c =: true and ProjectNameConflictCondition__c =: true ];
        return listOppProjectName;
    }     
}