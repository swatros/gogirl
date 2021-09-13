// Pass journey destination and start location to instance of journey using data-controller and data targets
// Find current location

import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['form', "container"];

  connect() {
    this.journeyId = this.containerTarget.dataset.journeyId
  }

  flag(event) {

    const flagButton = event.currentTarget
    flagButton.classList.add('disabled')

    this.getCurrentLocation(
      (response) => {
        console.log(response.coords.latitude)
        console.log(response.coords.longitude)
        fetch("/incidents", {
          method: 'Post',
          headers: {
            "Content-Type": "application/json",
            'Accept': "text/plain", 'X-CSRF-Token': csrfToken()},
          body: JSON.stringify({
            journey_id: this.journeyId,
            incident: {
              latitude: response.coords.latitude,
              longitude: response.coords.longitude,
            }
          })
        })
          .then(response => response.text())
          .then((data) => {
            flagButton.classList.remove('disabled');
            document.querySelector('body').insertAdjacentHTML('beforeend', data);
          })
      }
    )
  }


  async getCurrentLocation(callback) {
    navigator.geolocation.getCurrentPosition(callback)
  }
}
