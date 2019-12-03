import {
    LightningElement,
    wire
} from 'lwc';
import {
    CurrentPageReference
} from 'lightning/navigation';
import {
    fireEvent
} from 'c/pubsub';
export default class Publishsource extends LightningElement {
    @wire(CurrentPageReference) pageRef;
 
    handleChange(event) {
        fireEvent(this.pageRef, 'inputChangeEvent', event.target.value);
    }
}