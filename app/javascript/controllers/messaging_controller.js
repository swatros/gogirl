import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = [""];

  connect() {
    console.log("You are connected")
  }

  send() {
    this.getCurrentLocation(
      (response) => {
        console.log(response.coords.latitude)
        console.log(response.coords.longitude)
        fetch("/messages", {
          method: 'Post',
          headers: {
            "Content-Type": "application/json",
            'Accept': "text/plain", 'X-CSRF-Token': csrfToken()
          },
          body: JSON.stringify({
            latitude: response.coords.latitude,
            longitude: response.coords.longitude,
          })
        })
          .then(response => response.text())
          .then((data) => {
            document.querySelector('body').insertAdjacentHTML('beforeend', data);
          })
      }
    )
  }


  async getCurrentLocation(callback) {
    navigator.geolocation.getCurrentPosition(callback)
  }
}
