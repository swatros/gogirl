import intlTelInput from 'intl-tel-input';

const initTelInputs = () => {
  const inputs = document.querySelectorAll(".phone-input");
  inputs.forEach((input) => {
    const phoneInput = intlTelInput(input, {
     initialCountry: "es",
      // any initialisation options go here
      utilsScript:
        "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"
    });
    const info = document.querySelector(".alert-info");

    function process(event) {
      event.preventDefault();

      const phoneNumber = phoneInput.getNumber();

      info.style.display = "";
      info.innerHTML = `Phone number in E.164 format: <strong>${phoneNumber}</strong>`;
    }
    input.addEventListener('blur', process)
  })
}

export { initTelInputs }
