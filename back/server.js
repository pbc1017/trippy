const { MongoClient, ServerApiVersion ,ObjectId} = require('mongodb');
const express=require('express');
const { spawn } = require('child_process');
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

