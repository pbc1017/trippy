const { MongoClient, ServerApiVersion ,ObjectId} = require('mongodb');
const express=require('express');
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

