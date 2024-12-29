const User = require("../models/user");
const asyncHandler = require("express-async-handler");

exports.index = asyncHandler(async (req, res, next) => {
  const users = await User.find({});
  console.log(users);
  res.json(users);
});

exports.create_get = asyncHandler(async (req, res, next) => {
  res.send("NOT IMPLEMENTED: User create GET");
});

exports.create_post = asyncHandler(async (req, res, next) => {
  res.send("NOT IMPLEMENTED: User create POST");
});

exports.get_id = asyncHandler(async (req, res, next) => {
  res.send(`NOT IMPLEMENTED: User detail: ${req.params.id}`);
});

exports.put_id = asyncHandler(async (req, res, next) => {
  res.send(`NOT IMPLEMENTED: User update PUT: ${req.params.id}`);
});

exports.delete_id = asyncHandler(async (req, res, next) => {
  res.send(`NOT IMPLEMENTED: User delete DELETE: ${req.params.id}`);
});
