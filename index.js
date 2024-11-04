// index.js

const express = require('express');
const app = express();
const port = 3000;

// Route that greets the user by name
app.get('/hello', (req, res) => {
  const name = req.query.name || 'World';
  res.send(`Hello ${name}`);
});

// Start the server
app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
