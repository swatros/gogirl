// Pass journey destination and start location to instance of journey using data-controller and data targets
// Find current location

import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ['form', "container"];

  connect() {
    this.journeyId = this.containerTarget.dataset.journeyId
  }

  flag() {
    this.getCurrentLocation(
      (response) => {
        console.log(response)
        fetch("/incidents", {
          method: 'Post',
          headers: {
            "Content-Type": "application/json",
            'Accept': "application/json", 'X-CSRF-Token': csrfToken()},
          body: JSON.stringify({
            journey_id: this.journeyId
          })
        })
          .then(response => {
            if (response.status === 200) {
              console.log("Location and time saved. We'll ask for more info later.")
            }
          })
      }
    )
  }


  async getCurrentLocation(callback) {
    navigator.geolocation.getCurrentPosition(callback)
  }
}
