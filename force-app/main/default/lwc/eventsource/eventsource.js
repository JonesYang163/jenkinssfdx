import {
    LightningElement
} from 'lwc';


export default class Eventsource extends LightningElement {
    handleChange(event) {
        event.preventDefault();
        const name = event.target.value;
        const selectEvent = new CustomEvent('inptext', {
            detail: name
        });
        this.dispatchEvent(selectEvent);
    }
}