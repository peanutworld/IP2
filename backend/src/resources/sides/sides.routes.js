import express from "express";
import {
  getSides,
  updateSides,
  createSides,
  deleteSides,
  getSingleSides,
} from "./sides.controllers.js";

const router = express.Router();

router.route("/").get(getSides).post(createSides).delete(deleteSides);
router.route("/:sidesGuid").get(getSingleSides).update(updateSides);

export default router;
