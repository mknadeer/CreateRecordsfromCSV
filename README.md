# Create Salesforce records by uploading csv file

I have created a lightning web component for uploading csv file, that will create the records of objects.

[Screenshot of component ui]

[Screenshot of csv file]

Here am using a sample custom_object__c. This can be changed to any record.

For the standard fields/custom fields, I am using custom_field__1__c,custom_field__2__c. You can customize using any fields api name.

I am using a queueable class, if you want to use batch, you can extend the functionality.

