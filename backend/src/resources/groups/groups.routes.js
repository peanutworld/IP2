import express from "express";
import {
  getGroups,
  getSingleGroup,
  createGroup,
  updateGroup,
  deleteGroup,
} from "./groups.controllers.js";

const router = express.Router();

router.route("/").get(getGroups).post(createGroup);
router
  .route("/:groupGuid")
  .get(getSingleGroup)
  .patch(updateGroup)
  .delete(deleteGroup);

export default router;
