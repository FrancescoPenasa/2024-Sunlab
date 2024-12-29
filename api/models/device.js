// Require Mongoose
const mongoose = require("mongoose");

// Define a schema
const Schema = mongoose.Schema;
  
const DeviceSchema = new Schema({
    name: String,
    usageTime: Number,
    lastMaintenance: Date,
  });


DeviceSchema.virtual('url').get(function() {
  return '/devices/' + this._id;
});

module.exports = mongoose.model("Device", DeviceSchema);

