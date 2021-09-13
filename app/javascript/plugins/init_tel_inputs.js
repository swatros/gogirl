import intlTelInput from 'intl-tel-input';

const initTelInputs = () => {
  const wrappers = document.querySelectorAll(".phone-wrapper");
  wrappers.forEach((wrapper) => {
    const input = wrapper.querySelector(".phone-input")
    const phoneValue = wrapper.querySelector(".phone-value")
    const phoneInput = intlTelInput(input, {
     initialCountry: "es",
      // any initialisation options go here
      utilsScript:
        "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js"
    });
    const info = document.querySelector(".alert-info");
    info.addEventListener("click", () => {
      info.style.display = "none";
    })

    function process(event) {
      event.preventDefault();

      const valid = phoneInput.isValidNumber()
      if (valid) {
        const phoneNumber = phoneInput.getNumber();
        phoneValue.value = phoneNumber
        info.style.display = "none";
      } else {
        info.style.display = "";
        phoneValue.value = "";
      }
    }
    input.addEventListener('blur', process)
  })
}

export { initTelInputs }
