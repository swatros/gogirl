import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ["journey"];

  connect() {
    console.log("You are connected")
  }

  send() {
    fetch("/messages", {
      method: 'Post',
      headers: {
        "Content-Type": "application/json",
        'Accept': "text/plain", 'X-CSRF-Token': csrfToken()
      },
      body: JSON.stringify({
        journey: this.journeyTarget.dataset.journeyId
      })
    })
    .then(response => response.text())
    .then((data) => {
      document.querySelector('body').insertAdjacentHTML('beforeend', data);
    })
  }

  async getCurrentLocation(callback) {
    navigator.geolocation.getCurrentPosition(callback)
  }
}
