var http = require('http');

console.log("starting server at port 8080");

http.createServer(function (req, res) {
  res.write('Hello World!');
  res.end();
}).listen(8080);
