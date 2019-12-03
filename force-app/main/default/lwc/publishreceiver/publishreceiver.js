import {
    LightningElement,
    track,
    wire
} from 'lwc';
import {
    CurrentPageReference
} from 'lightning/navigation';
import {
    registerListener,
    unregisterAllListeners,
    // eslint-disable-next-line no-unused-vars
    fireEvent
} from 'c/pubsub';
 
export default class Publishreceiver extends LightningElement {
      @track inpVal;
      @wire(CurrentPageReference) pageRef;
 
      connectedCallback() {
          // subscribe to inputChangeEvent event
          registerListener('inputChangeEvent', this.handleChange, this);
      }
 
      disconnectedCallback() {
          // unsubscribe from inputChangeEvent event
          unregisterAllListeners(this);
      }
 
      handleChange(inpVal) {
          this.inpVal = inpVal;
      }
}