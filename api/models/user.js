// Require Mongoose
const mongoose = require("mongoose");

// Define a schema
const Schema = mongoose.Schema;
  
const UserSchema = new Schema({
  first_name: String,
  last_name: String,
  email: String,
  level: Number,
});

UserSchema.virtual('url').get(function() {
  return '/users/' + this._id;
});

module.exports = mongoose.model("User", UserSchema);