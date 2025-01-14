// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

Turbo.StreamActions.scroll_to = function () {
    console.log(`scroll_to connected`)
    // console.log(`target dd : ${document.getElementsByName("chat_message")[0]}`)
    // const target = this.targetElements[0];
    const target = document.getElementsByName("chat_messages")[0];
    console.log(`target: ${target}`)
    // target.scrollIntoView({behavior: "smooth"});
    if (target) {
        // target.scrollTop = target.scrollHeight;
        // target.scrollTop = target.scrollHeight - target.clientHeight;
        console.log(`target scroll to end - ${target.scrollTop} - ${target.scrollHeight}`)
      }

    // const elements = document.getElementsByName("elementName");

    // // Access the first element with the specified name
    // if (elements.length > 0) {
    // const firstElement = elements[0]; 
    // // Do something with the element
    // console.log(firstElement.value);
    // }

    // const element = document.getElementById('chat_messages');
    // console.log(`element: ${element}`)
    // if (element) {
    //   element.scrollT = element.scrollHeight;
    //   console.log(`scroll bottom : ${element.scrollHeight}`)
    // }
};

// document.addEventListener('turbo:load', function() {
//     const element = document.getElementById('messages');
//     if (element) {
//       element.scrollTop = element.scrollHeight;
//     }
//   });