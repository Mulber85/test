public with sharing class GoodsVFController {

    public string Result { get; set; }

    public PageReference whatever() {
        PageReference pageRef = null;
        return new PageReference('/a05/e?retURL=/apex/{!$CurrentPage.Name}');
    }

    public PageReference callout() {
        return null;
    }

    public Integer noOfRecords {get; set;}
    public Integer size {get;set;}
    public List<SelectOption> paginationSizeOptions{get;set;}

    public List<Product__c> Goods { get{
        return (List<Product__c>) setCon.getRecords();
    } set; }

    public static Date parseDate(String inDate) {
        Date    dateRes    = null;
        try {
            String candDate    = inDate.substring(0,Math.min(10,inDate.length()));
            dateRes    = Date.parse(candDate);
        }
        catch (Exception e) {}
     
        if (dateRes == null) {
            try {
                String candDate    = inDate.substring(0,10);
                dateRes            = Date.valueOf(candDate);
            }
            catch (Exception e) {}
        }    
        return dateRes;
    }

    public String SearchDateStr { get; set; }
    
    public PageReference cancel() {
        return null;
    }
    
    public void SearchGoods() {
        setCon = null;
        setCon.setPageNumber(1);
    }
    
    //sdjshdksd
    
    public ApexPages.StandardSetController setCon {
        get{
        system.debug(LoggingLevel.Error, '>> SelectedRecordId = "'+SelectedRecordId+'"');
        if(setCon == null){
            String SearchQuery = SearchGoodsStr == null ? '%%' : '%'+SearchGoodsStr+'%';    
            if (SearchDateStr == null) {SearchDateStr = '';}
            if (SearchDateStr == '') {
                AvailableGoods = [SELECT Id, Name, Price__c, Quantity__c, Type__c, Date_added__c, Release_date__c, Available__c FROM Product__c WHERE Name LIKE :SearchQuery];                                
                setCon = new ApexPages.StandardSetController(AvailableGoods );
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();       
        } else {            
            Date SearchQuery1 = parseDate(SearchDateStr);       
            AvailableGoods = [SELECT Id, Name, Price__c, Quantity__c, Type__c, Date_added__c, Release_date__c, Available__c FROM Product__c WHERE Date_added__c = :SearchQuery1 and Name LIKE :SearchQuery]; 
            setCon = new ApexPages.StandardSetController(AvailableGoods );
            setCon.setPageSize(size);
            noOfRecords = setCon.getResultSize();}
        }
        records = new Map<Id, Product__c>((list<Product__c>)setCon.getRecords());
        system.debug(LoggingLevel.Error, '>>SETCON RECS: '+setCon.getRecords());
        return setCon;                         
    } set; }       
 
    public String SearchGoodsStr { get; set; }     
         
    public String selectedRecordId { get; set; }      
    
    public String edtLnk4Debug { get; set; }    
       
    public List<Product__c> AvailableGoods { get; set; }      

    public Map<Id, Product__c> records {get; private set;}
       
    public GoodsVFController() {
        size=10;
        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('5','5'));
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('20','20'));
        paginationSizeOptions.add(new SelectOption('50','50'));
        paginationSizeOptions.add(new SelectOption('100','100'));               
    }
        
    public PageReference DeleteGoods() {
        try {
            Product__c item = [select Id from Product__c where Id = :selectedRecordId];
            system.debug(LoggingLevel.Error, '>>OUTPUT (before del): '+setCon.getRecords());
            delete item;            
            records.remove(selectedRecordId);
            setCon = null;
            system.debug(LoggingLevel.Error, '>>OUTPUT (after del): '+setCon.getRecords());
        } catch (Exception ex) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return null;
    }      

    public PageReference refreshPageSize() {
         setCon.setPageSize(size);
         return null;
    }    

}