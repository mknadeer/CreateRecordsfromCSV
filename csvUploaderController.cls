public with sharing class csvUploaderController {
  @AuraEnabled
  public static void createRecordsFromCSV(Id fileId) {
    try {
      Integer recordsCreated = 0;
      List < Custom_Record__c > RecordToInsert = new List < Custom_Record__c > ();
      // Fetch the uploaded CSV file content
      ContentVersion csvFile = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :fileId LIMIT 1];

      if (csvFile  != null) {
        // Convert CSV file content to String
        String csvData = csvFile.VersionData.toString();

        // Split the data by lines to process each row
        List<String> rows = csvData.split('\n');
        Id RecordTypeId = Schema.SObjectType.Custom_Record__c.getRecordTypeInfosByDeveloperName().get('Custom').getRecordTypeId();

        // Iterate through each CSV line
            for (String row : rows) {
                // Split the CSV line into fields
                List<String> tokens = row.split(',');

                // Ensure the line has the expected number of fields
                if (tokens.size() == 2) {
                    Custom_Object__c record = new Custom_Object__c();
                    record.recordTypeId = RecordTypeId;
                    record.Custom_field__1__c = tokens[0];
                    record.Custom_field__2__c = tokens[1];
                    RecordToInsert.add(record);
                } else {
                    // Handle invalid CSV lines or log an error
                }
            }
      }
        recordsCreated = Custom_Record__c.size();
        system.debug('recordsCreated ->' + recordsCreated);
        system.debug('shiftRecordsInsert ->' + Custom_Record__c);
        //Call Queueable Class 
        CSVShiftProcessingQueueable queueable = new CSVShiftProcessingQueueable(Custom_Record__c);
        System.enqueueJob(queueable);

    } catch (Exception e) {
        System.debug(e.getMessage());
        throw new AuraHandledException(e.getMessage()+e.getStackTraceString()+e.getLineNumber());
      // Handle exceptions or logging if insertion fails
    }
  }

}
