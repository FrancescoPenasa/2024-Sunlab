const Device = require("../models/device");
const asyncHandler = require("express-async-handler");

exports.index = asyncHandler(async (req, res, next) => {
  const devices = await Device.find({});
  res.json(devices);
});

exports.create_get = asyncHandler(async (req, res, next) => {
  res.send("NOT IMPLEMENTED: device create GET");
});

exports.create_post = asyncHandler(async (req, res, next) => {
  res.send("NOT IMPLEMENTED: device create POST");
});

exports.get_id = asyncHandler(async (req, res, next) => {
  res.send(`NOT IMPLEMENTED: device detail: ${req.params.id}`);
});

exports.put_id = asyncHandler(async (req, res, next) => {
  res.send(`NOT IMPLEMENTED: device update PUT: ${req.params.id}`);
});

exports.delete_id = asyncHandler(async (req, res, next) => {
  res.send(`NOT IMPLEMENTED: device delete DELETE: ${req.params.id}`);
});
