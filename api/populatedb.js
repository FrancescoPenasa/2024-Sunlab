#! /usr/bin/env node

console.log(
    'This script populates the devices available in the sunlab' 
  );
  
  // Get arguments passed on command line
  const userArgs = process.argv.slice(2);
  
  const Device = require("./models/device");
  const User = require("./models/user");
  const Job = require("./models/job");
  
  const devices = [];
  const users = [];
  const jobs = [];
  
  const mongoose = require("mongoose");
  mongoose.set("strictQuery", false);
  
  const mongoDB = userArgs[0];
  
  main().catch((err) => console.log(err));
  
  async function main() {
    console.log("Debug: About to connect");
    await mongoose.connect(mongoDB);
    console.log("Debug: Should be connected?");
    
    await createUsers();
    await createDevices();
    await createJobs(); 

    console.log("Debug: Closing mongoose");
    mongoose.connection.close();
  }
  
  async function userCreate(index, first_name, last_name, email, level) {
    const userdetail = {
      first_name: first_name,
      last_name: last_name,
      email: email,
      level: level,
    };
  
    const user = new User(userdetail);
    await user.save();
    users[index] = user;
    console.log(`Added user: ${first_name} ${last_name}`);
  }

    async function deviceCreate(index, name, usageTime, lastMaintenance) {
        const devicedetail = {
        name: name,
        usageTime: usageTime,
        lastMaintenance: lastMaintenance,
        };

        const device = new Device(devicedetail);
        await device.save();
        devices[index] = device;
        console.log(`Added device: ${name}`);
    }

    async function jobCreate(index, startDate, endDate, device, user, state) {
        const jobdetail = {
        startDate: startDate,
        endDate: endDate,
        device: device,
        user: user,
        state: state,
        };

        const job = new Job(jobdetail);
        await job.save();
        jobs[index] = job;
        console.log(`Added job: ${job}`);
    }

    async function createUsers() {
        console.log("Adding users");
        await Promise.all([
        userCreate(0, "Francesco", "Penasa", "francesco.penasa.job@gmail.com", 0x),
        userCreate(1, "Jane", "Doe", "", 2),
        userCreate(2, "Alice", "Smith", "", 3),
        userCreate(3, "Bob", "Smith", "", 4),
        ]);
    }
    
    async function createDevices() {
        console.log("Adding devices");
        await Promise.all([
        deviceCreate(0, "Device1", 0, ""),
        deviceCreate(1, "Device2", 0, ""),
        deviceCreate(2, "Device3", 0, ""),
        deviceCreate(3, "Device4", 0, ""),
        ]);
    }

    async function createJobs() {
        console.log("Adding jobs");
        await Promise.all([
        jobCreate(0, "", "", devices[0], users[0], "pending"),
        jobCreate(1, "", "", devices[1], users[1], "accepted"),
        jobCreate(2, "", "", devices[2], users[2], "cancelled"),
        jobCreate(3, "", "", devices[3], users[3], "pending"),
        ]);
    }
  