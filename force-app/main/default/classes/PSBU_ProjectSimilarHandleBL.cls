/**
* Company : DCIT
* Description : *
* This class 
*
*************************************************************************************
***
* History :
* [26.Sep.2019] Jones Yang - Code Creation */

public with sharing class PSBU_ProjectSimilarHandleBL {

    public PSBU_ProjectSimilarHandleBL() {
    }

    //
    private map<string, string> getAccountName( List<Account> listAccount ) {
        map<string, string> mapAccountName = new map<string, string>();
        for(Account acc : listAccount){
            mapAccountName.put(acc.Id, acc.Name);
        }
        return mapAccountName;
    }

    //
    public void handleDesigningInstituteCondition () {
        if( !PSBU_ProjectDML.getDesigningInstituteOppProductsAgg().isEmpty() && !PSBU_ProjectDML.getDesigningInstituteOppProducts().isEmpty() ){
            //map<string, OpportunityProductLineItem__c> mapOppProductLines = new map<string, OpportunityProductLineItem__c>();        
            List<SimilarProjectGroup__c> listSimilarProGroup = new List<SimilarProjectGroup__c>();
            for( AggregateResult ar : PSBU_ProjectDML.getDesigningInstituteOppProductsAgg() ) {
                if( integer.valueof(ar.get('expr0')) > 1 ) {
                    SimilarProjectGroup__c objSimilarProGroup = new SimilarProjectGroup__c();
                    objSimilarProGroup.Name = getAccountName(PSBU_ProjectDML.getAccounts()).get(string.valueof(ar.get('OpportunityName__r.DesigningInstitute__c'))) + string.valueof(ar.get('Factory__c')) + string.valueof(ar.get('Product__r.Name'));
                    objSimilarProGroup.SimilarType__c = '设计院/工厂/机型';
                    listSimilarProGroup.add(objSimilarProGroup);
                }
            }

            try {
                insert listSimilarProGroup;
            } catch(DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
            }

            List<SimilarProject__c> listSimilarPros = new List<SimilarProject__c>();
            for( SimilarProjectGroup__c spg : listSimilarProGroup) {   
                for(OpportunityProductLineItem__c opli : PSBU_ProjectDML.getDesigningInstituteOppProducts() ){
                    SimilarProject__c objSimilarPro = new SimilarProject__c();
                    string sGroupNamePro = getAccountName(PSBU_ProjectDML.getAccounts()).get(opli.OpportunityName__r.DesigningInstitute__c) + opli.Factory__c + opli.Product__r.Name;
                    if( spg.Name == sGroupNamePro ){
                        objSimilarPro.SimilarProjectGroup__c = spg.Id;
                        objSimilarPro.Project__c = opli.OpportunityName__c;
                        listSimilarPros.add(objSimilarPro);
                    }
                }
            }

            try {
                insert listSimilarPros;
            } catch(DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
        }

    }

    //
    public void handleShipyardCondition () {
        
    }
}