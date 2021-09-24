// import consumer from "./consumer"

// consumer.subscriptions.create("CommentChannel", {
//   connected() {
//     // Called when the subscription is ready for use on the server
//     console.log('connected to comment channel')
//   },

//   disconnected() {
//     // Called when the subscription has been terminated by the server
//   },

//   received(data) {
//     // Called when there's incoming data on the websocket for this channel
//     if (data.sender == data.content.commenter) {
//       document.getElementById('comment_body').value = ''
//     }

//     $('#comment').append(`
//       <div class="card bg-light my-2">
//         <div class="card-body">
//           <strong class="card-title">${data.content.commenter}</strong>
//           <p>${data.content.body}</p>
//           <a href="/posts/${data.content.post_id}/comments/${data.content.id}" data-method="delete">Delete Comment</p>
//         </div>
//       </div>
//     `)
//   }
// });