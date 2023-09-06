
public with sharing class CSVShiftProcessingQueueable implements Queueable {
    private List<Custom_Record__c> recordsToInsert;

    public CSVShiftProcessingQueueable(List<Custom_Record__c> recordsToInsert) {
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
