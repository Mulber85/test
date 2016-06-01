public with sharing class GoodsListController {

    public GoodsListController(ApexPages.StandardSetController controller) {
        product = new Product__c();
        showList = false;
    }

    public Product__c product{get;set;}
    
    public String selType{get;set;}
    
    public Boolean showList {get;set;}
    
    public String errorMessage = '';
    
    public pagereference save(){
        product.Type__c = selType;
        try{
            insert product;             
            String id = ApexPages.CurrentPage().getparameters().get('id');
            pagereference ref = new pageReference('/'+product.id);
            ref.setRedirect(true);            
            return ref;
        
        }
            catch(Exception errMsg){
                ApexPages.addMessages(errMsg);
                showList = true;
        }
            product = new Product__c();
//            product = null;
            return null;        
        }
}