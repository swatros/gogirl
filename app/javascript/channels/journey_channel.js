import consumer from "./consumer";

const initJourneyChannel = (journeyId, callback) => {
  consumer.subscriptions.create({ channel: "JourneyChannel", id: journeyId }, {
    received(data) {
      callback(data)
    }
  });
}

export { initJourneyChannel }
