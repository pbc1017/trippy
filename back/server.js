const { MongoClient, ServerApiVersion ,ObjectId} = require('mongodb');
const express=require('express');
const { spawn } = require('child_process');
const haversine = require('haversine-distance');
const path = require('path');
// const prompt=require('prompt-sync')({singint:true});

// import * as roomRepository from './data/room.js';
// import * as userRepository from './data/users.js';

var app=express();
var server=require('http').createServer(app);
app.use(express.json());
app.use(express.urlencoded({extended : false}));

app.post('/api/signin',async (req,res)=>{
  try{
    console.log(req.body);
    await client.connect();
    userdata=client.db('trippy').collection('User');
    const result=await userdata.find(req.body).toArray();
    console.log(result);
    if(result.length>0)
    {
      //return user info
      res.json(result[0]);
    }
    else
    //login false
      res.json("false");
  }
  finally
  {
    // client.close();
  }

});

app.post('/api/signup',async (req,res)=>{
  try{
    console.log(req.body);
    await client.connect();
    userdata=client.db('trippy').collection('User');
    userdata.insertOne(req.body,function(err,res){
      if (err) throw err;
    console.log("1 document inserted");
    })
  }
  catch{
    console.log("Catch");
  }
});

// req: {"email":"pbc1017@kaist.ac.kr"}
// res: [여행지,음식점 정보 18개 배열]
app.get('/api/recommand',async (req, res) => {
  try{
    console.log(req.query);
    await client.connect();
    userdata=client.db('trippy').collection('User');
    const result=await userdata.find(req.query).toArray();
    console.log(result[0]);

    const pythonScriptPath = path.join(__dirname, './modules/recommand/recommand.py');
    const { _M, _U, _O, _A, _B, _1, _2, _3 } = result[0].properties;
    const pythonProcess = spawn('python', [pythonScriptPath, _M, _U, _O, _A, _B, _1, _2, _3]);

    let scriptOutput = '';
    
    pythonProcess.stdout.on('data', (data) => {
      scriptOutput += data.toString();
    });

    pythonProcess.stderr.on('data', (data) => {
      console.error(`stderr: ${data}`);
    });

    pythonProcess.on('close', (code) => {
      if (code !== 0) {
        return res.status(500).json({ error: `Process exited with code ${code}` });
      }
      return res.status(200).json(JSON.parse(scriptOutput));
    });
  } catch {
    console.log("catch");
  }
});

app.post('/api/search', async (req, res) => {
  try {
    console.log(req.query);
    await client.connect();
    const points = req.body.points;
    let center = [0, 0];
    if (points.length > 0) {
      const totalLatitude = points.reduce((sum, point) => sum + point.latitude, 0);
      const totalLongitude = points.reduce((sum, point) => sum + point.longitude, 0);

      center = [totalLatitude / points.length, totalLongitude / points.length];
    }

    const db = client.db('trippy');
    const collections = {
      all: [db.collection('travel'), db.collection('food'), db.collection('hotel')],
      travel: [db.collection('travel')],
      food: [db.collection('food')],
      hotel: [db.collection('hotel')],
    };

    const type = req.body.type || 'all';
    console.log(type);

    const keyword = req.query.query || "";
    const keywordRegex = new RegExp(keyword, 'i');

    let results = [];
    for (let collection of collections[type]) {
      const query = keyword ? {
        $or: [
          { name: keywordRegex },
          { address: keywordRegex },
          { oneliner: keywordRegex },
          { type: keywordRegex }
        ]
      } : {};
      const result = await collection.find(query).toArray();
      
      result.forEach(item => {
        if (item.location) {
          const location = item.location.match(/[\d\.]+/g).map(Number);
          const distance = haversine(center, location) / 1000;  // Convert distance from meters to km
          if (type === 'hotel' || distance <= 5) {  // No distance limit for 'hotel'
            item.distance = distance;
            item.type = type;
            results.push(item);
          }
        }
      });
    }

    results = results.map(item => {
      const normalizedReviewNum = item.reviewNum / 500;
      const normalizedReviewRate = item.reviewRate / 5;
      const normalizedDistance = item.distance / 5;  // Assume the maximum distance of interest is 5km

      item.score = normalizedReviewNum * 0.2 + normalizedReviewRate * 0.2 + (1 - normalizedDistance) * 0.6;
      if (item.id.includes('travel')) {
        item.score += 0.2;
      }
      return item;
    });

    results.sort((a, b) => b.score - a.score);

    res.status(200).json(results);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'An error occurred while processing your request.' });
  }
});

server.listen(80,main);

//DB CODE

const uri = "mongodb+srv://knsol2:1017@cluster0.9vu4wen.mongodb.net/";
//api key E2kpU7xTXiQrNi6WEWE6p1gNFC6dCpd4ZcMEuWHgsn0NHyc86dB3pGVSSwWED7Uz

// Create a MongoClient with a MongoClientOptions object to set the Stable API version
const client = new MongoClient(uri, {
  serverApi: {
    version: ServerApiVersion.v1,
    strict: true,
    deprecationErrors: true,
  }
});

function main() {
    //await collection.updateOne(QUERYDATA},{$set:{CHANGEDATA}})
    console.log("Server On");
}

