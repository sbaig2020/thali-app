const http = require('http');
const fs = require('fs');
const url = require('url');
const { v4: uuidv4 } = require('uuid');

const DB_FILE = __dirname + '/db.json';

function readDb() {
  try {
    const raw = fs.readFileSync(DB_FILE);
    return JSON.parse(raw);
  } catch (e) {
    return { requests: [] };
  }
}

function writeDb(db) {
  fs.writeFileSync(DB_FILE, JSON.stringify(db, null, 2));
}

function sendJson(res, code, obj) {
  const body = JSON.stringify(obj);
  res.writeHead(code, {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type'
  });
  res.end(body);
}

const server = http.createServer((req, res) => {
  if (req.method === 'OPTIONS') {
    res.writeHead(204, {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type'
    });
    res.end();
    return;
  }

  const parsed = url.parse(req.url, true);
  const path = parsed.pathname;
  const db = readDb();

  if (path === '/requests' && req.method === 'GET') {
    const name = parsed.query.name;
    const list = name ? db.requests.filter(r => r.name === name) : db.requests;
    sendJson(res, 200, list);
    return;
  }

  if (path === '/requests' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const obj = JSON.parse(body);
        const newReq = {
          id: uuidv4(),
          name: obj.name || 'Unknown',
          location: obj.location || '',
          urgency: obj.urgency || 'Low',
          description: obj.description || '',
          timestamp: Date.now(),
          status: 'pending'
        };
        db.requests.unshift(newReq);
        writeDb(db);
        sendJson(res, 201, newReq);
      } catch (e) {
        sendJson(res, 400, { error: 'Invalid JSON' });
      }
    });
    return;
  }

  const idMatch = path.match(/^\/requests\/([^\/]+)/);
  if (idMatch) {
    const id = idMatch[1];
    if (req.method === 'PUT') {
      let body = '';
      req.on('data', c => body += c);
      req.on('end', () => {
        try {
          const obj = JSON.parse(body);
          const idx = db.requests.findIndex(r => r.id === id);
          if (idx === -1) return sendJson(res, 404, { error: 'Not found' });
          db.requests[idx] = { ...db.requests[idx], ...obj };
          writeDb(db);
          sendJson(res, 200, db.requests[idx]);
        } catch (e) {
          sendJson(res, 400, { error: 'Invalid JSON' });
        }
      });
      return;
    }
    if (req.method === 'DELETE') {
      const idx = db.requests.findIndex(r => r.id === id);
      if (idx === -1) return sendJson(res, 404, { error: 'Not found' });
      const removed = db.requests.splice(idx, 1)[0];
      writeDb(db);
      sendJson(res, 200, removed);
      return;
    }
  }

  sendJson(res, 404, { error: 'Unknown route' });
});

const PORT = 3000;
server.listen(PORT, () => console.log('Thali Help backend running on http://localhost:' + PORT));
