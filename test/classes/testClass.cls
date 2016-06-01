@isTest
private class testClass
{   
         @isTest 
         static void testDel() 
         {
             Profile profile = [select id, Name from profile where name='System Administrator'];  
             User user = new User(alias = 'Bh69', email='bothlefthands@test.com', emailencodingkey='UTF-8', lastname='Saltushechkin', languagelocalekey='en_US', localesidkey='en_US', profileid = profile.Id, timezonesidkey='America/Los_Angeles', username='bothlefthands@test.com');     
             insert user;
             System.RunAs(user){
                    Product__c item = new Product__c ( // Name, Price__c, Quantity__c, Type__c, Date_added__c, Release_date__c, Available__c
                        Name = 'Pencil',
                        Price__c =250,
                        Quantity__c = 4,
                        Type__c = 'ПС',
                        Date_added__c = Date.TODAY(),
                        Release_date__c = Date.TODAY());
                        insert item;
                 
                    Product__c item_w_err = new Product__c ( // Name, Price__c, Quantity__c, Type__c, Date_added__c, Release_date__c, Available__c
                        Name = 'Pen',
                        Price__c =133,
                        Quantity__c = 0,
                        Type__c = 'ПС',
                        Date_added__c = Date.TODAY(),
                        Release_date__c = Date.TODAY());
                        insert item_w_err;
                 
                   test.startTest();                      
                        delete item;
                 		delete item_w_err;
                   test.stopTest();  
                   List<Product__c> resultGoods = [select Id from Product__c];
                   System.assertEquals(0, resultGoods.size(), 'Goods not deleted');               
               }  
          }  
}