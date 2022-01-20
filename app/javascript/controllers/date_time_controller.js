import {Controller} from "@hotwired/stimulus"
import flatpickr from 'flatpickr'

export default class extends Controller {
    static get targets() {
        return ["element", "timezone"]
    }

    static get values() {
        return {
            default: String
        }
    }

    connect(){
        let datetime = this.defaultValue ? Date.parse(this.defaultValue) : Date.now()
        document.head.insertAdjacentHTML('beforeend', '<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">')
        flatpickr(this.elementTarget, {enableTime: true, defaultDate: datetime})
        this.timezoneTarget.innerText = "Timezone: " + new Intl.DateTimeFormat().resolvedOptions().timeZone
    }


}