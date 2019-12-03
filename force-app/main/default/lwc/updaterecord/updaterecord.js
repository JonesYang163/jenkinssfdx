/* eslint-disable no-console */
import {
    LightningElement,
    // eslint-disable-next-line no-unused-vars
    track,api,wire
    } from 'lwc';
    import {
    ShowToastEvent
    } from 'lightning/platformShowToastEvent';
    //import ACCOUNT_OBJECT from '@salesforce/schema/Account';
    //import NAME_FIELD from '@salesforce/schema/Account.Name';
    //import ID_FIELD from '@salesforce/schema/Account.ID';
    
    //import ANNUALREV_FIELD from '@salesforce/schema/Account.AnnualRevenue';
    //import Fax_FIELD from '@salesforce/schema/Account.Fax';
    //import PHONE_FIELD from '@salesforce/schema/Account.Phone';
    
    
    import {
    //getRecord,
    updateRecord,
    //generateRecordInputForUpdate,
    //getFieldValue,
    } from 'lightning/uiRecordApi';
    import {
    //CurrentPageReference
    } from 'lightning/navigation';
    
    
    export default class Updaterecord extends LightningElement {
    @api recordId;
    @track accountId;
    @track name = 'Demo Account';
    @track annualrev = 0;
    @track fax = '1231234345345';
    @track phone = '1231234345345';
    
    handleNameChange(event) {
        this.accountId = undefined;
        console.log('label values --->>' + event.target.label);
        if (event.target.label === 'Name') {
            this.name = event.target.value;
        }
        if (event.target.label === 'Annual Revenue') {
            this.annualrev = event.target.value;
        }
        if (event.target.label === 'Fax') {
            this.fax = event.target.value;
        }
        if (event.target.label === 'Phone') {
            this.phone = event.target.value;
        }
    
    }
    
    
    updateAccount() {
        let record = {
            fields: {
                Id: this.recordId,
                Name: this.name,
                AnnualRevenue:this.annualrev ,
                Fax:this.fax ,
                Phone:this.phone,
            },
        };
        updateRecord(record)
            // eslint-disable-next-line no-unused-vars
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record Is Updated',
                        variant: 'sucess',
                    }),
                );
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error on data save',
                        message: error.message.body,
                        variant: 'error',
                    }),
                );
            });
    
    
    }
    
    }