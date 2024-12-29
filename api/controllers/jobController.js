const Job = require("../models/job");
const asyncHandler = require("express-async-handler");

exports.index = asyncHandler(async (req, res, next) => {
  const jobs = await Job.find({});
  res.json(jobs);
});

exports.create_get = asyncHandler(async (req, res, next) => {
  res.send("NOT IMPLEMENTED: job create GET");
});

exports.create_post = asyncHandler(async (req, res, next) => {
  res.send("NOT IMPLEMENTED: job create POST");
});

exports.get_id = asyncHandler(async (req, res, next) => {
  res.send(`NOT IMPLEMENTED: job detail: ${req.params.id}`);
});

exports.put_id = asyncHandler(async (req, res, next) => {
  res.send(`NOT IMPLEMENTED: job update PUT: ${req.params.id}`);
});

exports.delete_id = asyncHandler(async (req, res, next) => {
  res.send(`NOT IMPLEMENTED: job delete DELETE: ${req.params.id}`);
});
