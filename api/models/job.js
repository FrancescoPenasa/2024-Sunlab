// Require Mongoose
const mongoose = require("mongoose");

// Define a schema
const Schema = mongoose.Schema;

const JobSchema = new Schema({
    startDate: Date,
    endDate: Date,
    device: { type: Schema.Types.ObjectId, ref: 'Device' },
    user: { type: Schema.Types.ObjectId, ref: 'User' },
    createdAt: {type: Date, default: Date.now() },
    state: {type: String, enum: ['pending', 'cancelled', 'accepted'] },
  });


JobSchema.virtual('is_future').get(function() {
  return this.createdAt > Date();
});

JobSchema.virtual('is_recent').get(function() {
  return this.createdAt > Date()-7; 
});

JobSchema.virtual('url').get(function() {
  return '/jobs/' + this._id;
});
  
module.exports = mongoose.model("Job", JobSchema);
