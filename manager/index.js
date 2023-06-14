const express = require('express');
const Docker = require('dockerode');

const app = express();
const port = 80;

// Connect to the Docker daemon
const docker = new Docker();

app.get('/', async (req, res) => {
  try {
    const containers = await getRunningContainers();
    res.send(`
      <html>
        <head>
          <title>Docker Container Manager</title>
        </head>
        <body>
          <h1>Docker Container Manager</h1>
          <h2>Running Containers:</h2>
          <ul>
            ${containers.map(container => `<li>${container.name} - <a href="/stop/${container.id}">Stop</a> | <a href="/start/${container.id}">Start</a></li>`).join('')}
          </ul>
        </body>
      </html>
    `);
  } catch (error) {
    console.error('Error retrieving containers:', error);
    res.status(500).send('Error retrieving containers');
  }
});

app.get('/stop/:containerId', (req, res) => {
  const containerId = req.params.containerId;
  stopContainer(containerId)
    .then(() => {
      res.redirect('/');
    })
    .catch(error => {
      console.error('Error stopping container:', error);
      res.status(500).send('Error stopping container');
    });
});

app.get('/start/:containerId', (req, res) => {
  const containerId = req.params.containerId;
  startContainer(containerId)
    .then(() => {
      res.redirect('/');
    })
    .catch(error => {
      console.error('Error starting container:', error);
      res.status(500).send('Error starting container');
    });
});

async function getRunningContainers() {
  const containers = await docker.listContainers({ all: true });
  return containers.filter(container => container.State === 'running');
}

function stopContainer(containerId) {
  const container = docker.getContainer(containerId);
  return container.stop();
}

function startContainer(containerId) {
  const container = docker.getContainer(containerId);
  return container.start();
}

app.listen(port, () => {
  console.log(`Web interface running on port ${port}`);
});
