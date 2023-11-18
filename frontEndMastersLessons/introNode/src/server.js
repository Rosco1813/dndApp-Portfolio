import fs from 'node:fs/promises'
import http from 'node:http'
import open from 'open'

const ws_uri = "ws://[your-domain]:9600";
const websocket = new WebSocket(ws_uri);


// on websocket open:
websocket.onopen = function(event) {
	MessageAdd('<div class="message green">You have entered the chat room.</div>');
};

// on websocket close:
websocket.onclose = function(event) {
	MessageAdd('<div class="message blue">You have been disconnected.</div>');
};

// on websocket error:
websocket.onerror = function(event) {
	MessageAdd('<div class="message red">Connection to chat failed.</div>');
};

websocket.onmessage = function(event) {
	var data = JSON.parse(event.data);

	if (data.type == "message") {
		MessageAdd('<div class="message">' + data.username + ': ' + data.message + '</div>');
 	}
};

document.getElementById("chat-form").addEventListener("submit", function(event) {
	event.preventDefault();

	var message_element = document.getElementsByTagName("input")[0];
	var message = message_element.value;

	if (message.toString().length) {
		var username = localStorage.getItem("username");

		var data = {
			type: "message",
			username: username,
			message: message
		};

		websocket.send(JSON.stringify(data));
		message_element.value = "";
	}
}, false);


function Username() {
	var username = window.prompt("Enter your username:", "");

	if (username.toString().length > 2) {
		localStorage.setItem("username", username);
	}
	else {
		alert("Your username must be at least two characters.");
		Username();
	}
}

Username();

function MessageAdd(message) {
	var chat_messages = document.getElementById("chat-messages");

	chat_messages.insertAdjacentHTML("beforeend", message);
	chat_messages.scrollTop = chat_messages.scrollHeight;
}
// const server = http.createServer((req, res) =>{
//     res.statusCode=200;
//     //what type of data i am sending back
//     //mime type is a file type but for internet / data
//     res.setHeader('Content-Type', 'text/plain')
//     res.end ('hello there')
// })
// //ports and sockets 
// server.listen(4000, ()=>{
//     console.log('server running on port http://localhost:4000')
// })

const interpolate = (html, data) => {
  return html.replace(/\{\{\s*(\w+)\s*\}\}/g, (match, placeholder) => {
    return data[placeholder] || '';
  });
}

const formatNotes = (notes) => {
  return notes.map(note => {
    return `
      <div class="note">
        <p>${note.content}</p>
        <div class="tags">
          ${note.tags.map(tag => `<span class="tag">${tag}</span>`).join('')}
        </div>
      </div>
    `
  }).join('\n')
}

const createServer = (notes) => {
  return http.createServer(async (req, res) => {
    const HTML_PATH = new URL('./template.html', import.meta.url)
    const template = await fs.readFile(HTML_PATH, 'utf-8')
    const html = interpolate(template, {notes: formatNotes(notes)})
    
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end(html);
  });
}

export const start = (notes, port) => {
  const server = createServer(notes)
  server.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
  });
  open(`http://localhost:${port}`)
}