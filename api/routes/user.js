const express = require("express");
const router = express.Router();

// Require controller modules.
const user_controller = require("../controllers/userController");

// base route /user 

// GET request for list of all User items.
router.get("/", user_controller.index);

// C
router.get("/create", user_controller.create_get);
router.post("/create", user_controller.create_post);

// RUD
router.get("/:id", user_controller.get_id);
router.put("/:id", user_controller.put_id);
router.delete("/:id", user_controller.delete_id);

module.exports = router;
