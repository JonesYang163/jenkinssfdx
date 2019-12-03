import { LightningElement } from 'lwc';
import strUserId from '@salesforce/user/Id';

export default class ShowUserDetail extends LightningElement {
    userId = strUserId;
}