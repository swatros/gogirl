// app/javascript/plugins/init_autocomplete.js
import places from 'places.js';

const initAutocomplete = () => {
  ["survey-input-location", "home-input-destination", "home-input-start"].forEach((inputId) => initInput(inputId))
};

const initInput = (inputId) => {
  const input = document.getElementById(inputId)
  if (input) {
    places({
      container: input,
      appId: "plB06SJO2G6N",
      apiKey: 'e012510420a0d470f237661bc2a17af4'
    })
  }
}

export { initAutocomplete };
