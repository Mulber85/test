trigger AvailableCheckTrigger on Product__c (before insert, before update) {
    for (Product__c rec : Trigger.new) {
        rec.Available__c = rec.Quantity__c > 0 ? true : false;
    }
}