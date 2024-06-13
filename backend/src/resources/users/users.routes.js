import express from "express";
import {
  createUser,
  deleteUser,
  getUsers,
  getSingleUser,
  updateUser,
} from "./users.controllers.js";

const router = express.Router();

router.route("/").get(getUsers).post(createUser).patch(updateUser).delete(deleteUser);
router.route("/:userGuid").get(getSingleUser);

export default router;
