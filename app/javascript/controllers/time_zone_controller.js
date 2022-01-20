import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static get targets() {
        return ["selector"]
    }

    connect() {
        this.autoSelectTimeZone()
    }

    getTime(timezone) {
        timezone = timezone || Intl.DateTimeFormat().resolvedOptions().timeZone;
        let options = {
            hour: 'numeric', minute: 'numeric', timezone: timezone
        };
        return new Intl.DateTimeFormat('en-US', options).format(new Date());

    }

    // Timezone difference in hours and minutes
    // String such as +5:30 or -6:00 or Z
    getCurrentTimezoneOffset() {
        let timezone_offset_min = new Date().getTimezoneOffset(),
            offset_hrs = parseInt(Math.abs(timezone_offset_min / 60)),
            offset_min = Math.abs(timezone_offset_min % 60),
            timezone_standard;

        if (offset_hrs < 10)
            offset_hrs = '0' + offset_hrs;

        if (offset_min < 10)
            offset_min = '0' + offset_min;

        // Add an opposite sign to the offset
        // If offset is 0, it means timezone is UTC
        if (timezone_offset_min <= 0)
            timezone_standard = '+' + offset_hrs + ':' + offset_min;
        else if (timezone_offset_min > 0)
            timezone_standard = '-' + offset_hrs + ':' + offset_min;
        else if (timezone_offset_min == 0)
            timezone_standard = 'Z';

        return timezone_standard;
    }

    extractOffsetFromString(str) {
        let offset = str.match(/[\-\+][0-9]{2}:[0-9]{2}/)
        return offset.length ? offset[0] : null
    }

    calcTimeFromOffset(offsetString) {
        // create Date object for current location
        let d = new Date();

        // convert to msec
        // subtract local time zone offset
        // get UTC time in msec
        let utc = d.getTime() + (d.getTimezoneOffset() * 60000);

        // replace ':' for math
        let offset = offsetString.replace(':', '.')

        // create new Date object for different city
        // using supplied offset
        let nd = new Date(utc + (3600000 * offset));

        // return time as a string
        return nd.toLocaleString();
    }

    matchOffsetToOption(offset, option) {
        switch (offset) {
            case '-08:00':
                return "Pacific Time (US & Canada)" == option.value
                break;
            case '-07:00':
                return "Mountain Time (US & Canada)" == option.value
            case '-06:00':
                return "Central Time (US & Canada)" == option.value
            case '-05:00':
                return "Eastern Time (US & Canada)" == option.value
            case '-04:00':
                return "Atlantic Time (Canada)" == option.value
            default:
                return this.extractOffsetFromString(option.textContent) == offset
        }
    }

    autoSelectTimeZone() {
        let offset = this.getCurrentTimezoneOffset()
        let timezone = new Intl.DateTimeFormat().resolvedOptions().timeZone
        for (const option of this.selectorTarget.options) {
            if (this.matchOffsetToOption(offset, option)) {
                this.selectorTarget.value = option.value
            }
        }
    }
}