// Pass journey destination and start location to instance of journey using data-controller and data targets
// Find current location

import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['form', "container", "map", "directions", "spinnerButton", "directionButton", "arrowButton" ];

  connect() {
    this.journeyId = this.containerTarget.dataset.journeyId
  }

  flag(event) {
    const flagButton = event.currentTarget
    flagButton.classList.add('d-none')

    const spinnerButton = this.spinnerButtonTarget
    spinnerButton.classList.remove('d-none')
    fetch("/incidents", {
      method: 'Post',
      headers: {
        "Content-Type": "application/json",
        'Accept': "text/plain", 'X-CSRF-Token': csrfToken()},
      body: JSON.stringify({
        journey_id: this.journeyId,
      })
    })
    .then(response => response.text())
    .then((data) => {
      flagButton.classList.remove('d-none');
      spinnerButton.classList.add('d-none')
      document.querySelector('body').insertAdjacentHTML('beforeend', data);
    })
  }

  switch() {
    console.log("hello")
    const directionButton = this.directionButtonTarget
    const arrowButton = this.arrowButtonTarget
    this.directionsTarget.classList.toggle("directions-hide")
    this.directionsTarget.classList.toggle("directions-show")
    directionButton.classList.toggle("d-none")
    arrowButton.classList.toggle("d-none")
  }

  async getCurrentLocation(callback) {
    navigator.geolocation.getCurrentPosition(callback)
  }
}
