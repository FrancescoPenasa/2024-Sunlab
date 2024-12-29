var express = require('express');
var router = express.Router();

// Require controller modules.
const device_controller = require("../controllers/deviceController");

// base route /job

// GET request for list of all User items.
router.get("/", device_controller.index);

// C
router.get("/create", device_controller.create_get);
router.post("/create", device_controller.create_post);

// RUD
router.get("/:id", device_controller.get_id);
router.put("/:id", device_controller.put_id);
router.delete("/:id", device_controller.delete_id);

module.exports = router;
