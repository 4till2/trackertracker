import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static get targets() {
        return ["newOption", "selectedOptions"]
    }

    static get values() {
        return {
            name: String
        }
    }
    
    addSelection(event) {
        let option = this.newOptionTarget.value.toUpperCase()
        if (!option || this.getSelection(option)) {
            this.newOptionTarget.value = ''
            return;
        }
        this.selectedOptionsTarget.insertAdjacentHTML('afterbegin', this.createSelection(option))
        this.newOptionTarget.value = ''
    }

    getSelection(option) {
        let node = document.getElementById(`smart-select-selection-${option}`)
        return node
    }

    removeSelection(event) {
        let toRemove = this.getSelection(event.params.selection)
        console.log(toRemove)
        toRemove && toRemove.remove()
    }

    removeAllSelections() {
        this.selectedOptionsTarget.innerHTML = ''
    }

    createSelection(option) {
        let selection = `
            <div class="" id="smart-select-selection-${option}">
            <div class="-m-1 flex items-center">
                <span class="m-1 inline-flex whitespace-nowrap rounded-md bg-gray-500/80 text-gray-50 items-center py-1.5 pl-3 pr-2 text-sm font-medium">
                  <span>${option}</span>
                  <input type="hidden" name="${this.nameValue}" value="${option}"/>
                  <button type="button" data-action="smart-select#removeSelection" data-smart-select-selection-param="${option}" class="flex-shrink-0 ml-1 h-4 w-4 p-1 rounded-full inline-flex text-gray-200/50 hover:bg-gray-200 hover:text-gray-500">
                    <span class="sr-only">Remove selection</span>
                    <svg class="h-2 w-2" stroke="currentColor" fill="none" viewBox="0 0 8 8">
                      <path stroke-linecap="round" stroke-width="1.5" d="M1 1l6 6m0-6L1 7"/>
                    </svg>
                  </button>
                </span>
            </div>
          </div>
        `
        return selection
    }

}