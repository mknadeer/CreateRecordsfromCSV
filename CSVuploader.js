import { LightningElement,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createRecordsFromCSV from '@salesforce/apex/csvUploaderController.createRecordsFromCSV';

export default class CSVuploader extends LightningElement {
    @track uploadedFiles;
    handleUploadFinished(event) {
        this.uploadedFiles = event.detail.files;
        
    }

    createRecords() {
        if (this.uploadedFiles.length > 0) {
            const fileId = this.uploadedFiles[0].documentId;
            createRecordsFromCSV({ fileId })
                .then(result => {
                    const toastEvent = new ShowToastEvent({
                        title: 'Success',
                        message: 'Records are being processed in background.',
                        variant: 'success'
                    });
                    console.log('Records are being processed asynchronously.');
                    this.dispatchEvent(toastEvent);
                })
                .catch(error => {
                    const toastEvent = new ShowToastEvent({
                        title: 'Error',
                        message: `An error occurred while creating records ->  ${error}`,
                        variant: 'error'
                    });
                    this.dispatchEvent(toastEvent);
                });
        }
    }
}
