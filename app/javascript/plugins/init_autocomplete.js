// app/javascript/plugins/init_autocomplete.js
import places from 'places.js';

const initAutocomplete = () => {
  const addressInputStart = document.getElementById("home-input-start")
  const addressInputDestination = document.getElementById("home-input-destination")
  const addressInputLocation = document.getElementById("survey-input-location")

  if (addressInputStart) {
    places({ container: addressInputStart });
  }

  if (addressInputDestination) {
    places({ container: addressInputDestination });
  }

  if (addressInputLocation) {
    places({ container: addressInputLocation });
  }
};

export { initAutocomplete };
