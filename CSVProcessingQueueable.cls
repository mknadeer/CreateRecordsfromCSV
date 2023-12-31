
public with sharing class CSVProcessingQueueable implements Queueable {
    private List<Custom_Record__c> recordsToInsert;

    public CSVProcessingQueueable(List<Custom_Record__c> recordsToInsert) {
        this.recordsToInsert = recordsToInsert;
    }

    public void execute(QueueableContext context) {
        try{
            if (!recordsToInsert.isEmpty()) {
                insert recordsToInsert;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
