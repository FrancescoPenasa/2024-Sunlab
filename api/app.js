var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var dotenv = require('dotenv');
var dotenvExpand = require('dotenv-expand');
dotenvExpand.expand(dotenv.config())

// DB connection
// a persistent connection is good enough for this use case, so i am not going to over complicated this webapp
const mongoose = require('mongoose');
mongoose.connect(process.env.MONGODB_SUNLAB)
.then((result) => {
  console.log('connected to Mongodb');
}).catch((err) => {
  console.error(err);
});

mongoose.connection.on('connected', () => console.log('connected'));
mongoose.connection.on('open', () => console.log('open'));
mongoose.connection.on('disconnected', () => console.log('disconnected'));
mongoose.connection.on('reconnected', () => console.log('reconnected'));
mongoose.connection.on('disconnecting', () => console.log('disconnecting'));
mongoose.connection.on('close', () => console.log('close'));

// Capture the termination signal and close the connection
process.on('SIGINT', async () => {
  console.log('SIGINT received, closing MongoDB connection...');
  try {
    await mongoose.connection.close();
    console.log('MongoDB connection closed');
    process.exit(0); // Exit the process successfully
  } catch (err) {
    console.error('Error while closing MongoDB connection:', err);
    process.exit(1); // Exit the process with an error
  }
});

// Handle other termination signals (optional)
process.on('SIGTERM', async () => {
  console.log('SIGTERM received, closing MongoDB connection...');
  try {
    await mongoose.connection.close();
    console.log('MongoDB connection closed');
    process.exit(0);
  } catch (err) {
    console.error('Error while closing MongoDB connection:', err);
    process.exit(1);
  }
});




var jobRouter = require('./routes/job');
var usersRouter = require('./routes/user');
let deviceRouter = require('./routes/device');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/devices', deviceRouter);
app.use('/jobs', jobRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
