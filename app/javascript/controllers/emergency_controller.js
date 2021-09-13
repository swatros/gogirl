import { Controller } from "stimulus";
import { csrfToken } from "@rails/ujs";

export default class extends Controller {
  static targets = ["button"];

  connect() {
    console.log("You are connected")
    this.getEmergencyISO()
    this.getEmergencyNumber()
  }

  async getCurrentLocation(callback) {
    navigator.geolocation.getCurrentPosition(callback)
  }

  async getEmergencyISO() {
    return await fetch("https://ipinfo.io/json?token=440715bb34d53c").then(
      (response) => response.json()
    ).then(
      (jsonResponse) => jsonResponse.country
    )
  }

  async getEmergencyNumber() {
    fetch(`/emergency_number/${await this.getEmergencyISO()}`).then(
      (response) => response.json()
    ).then(
       (jsonResponse) => this.buttonTarget.innerText = jsonResponse.data.police.all[0]
    )
  }


}
