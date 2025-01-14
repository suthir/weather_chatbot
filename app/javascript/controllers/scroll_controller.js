import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {

  connect() {
    // console.log(`scroll controller connected`);
    this.scrollToBottom(); // Initial scroll when connected

    // Create a MutationObserver instance
    this.observer = new MutationObserver(() => {
      this.scrollToBottom();
    });

    // Configuration for observing changes
    const config = { childList: true, subtree: true };

    // Start observing the element for changes
    this.observer.observe(this.element, config);
  }

  disconnect() {
    // console.log(`scroll controller - disconnected`);
    // Disconnect the observer when the controller is disconnected
    this.observer.disconnect();
  }

  scrollToBottom() {
    // console.log(`scroll controller - scrollToBottom`);
    this.element.scrollTop = this.element.scrollHeight;
  }
}
