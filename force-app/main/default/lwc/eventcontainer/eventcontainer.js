/* eslint-disable no-console */
import {
    LightningElement,
    track
} from 'lwc';


export default class Eventcontainer extends LightningElement {
     @track valueInp;
     handleSelect(event) {

         const textVal = event.detail;
         this.valueInp = textVal;
         console.log('textVaal' + textVal);
     }
}