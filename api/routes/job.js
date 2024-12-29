var express = require('express');
var router = express.Router();

// Require controller modules.
const job_controller = require("../controllers/jobController");

// base route /job

// GET request for list of all User items.
router.get("/", job_controller.index);

// C
router.get("/create", job_controller.create_get);
router.post("/create", job_controller.create_post);

// RUD
router.get("/:id", job_controller.get_id);
router.put("/:id", job_controller.put_id);
router.delete("/:id", job_controller.delete_id);

module.exports = router;
