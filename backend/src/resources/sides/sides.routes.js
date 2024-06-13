import express from "express";
import {
  getSides,
  updateSides,
  createSides,
  deleteSides,
  getSingleSides,
} from "./sides.controllers.js";

const router = express.Router();

router.route("/").get(getSides).post(createSides);
router
  .route("/:sidesGuid")
  .get(getSingleSides)
  .patch(updateSides)
  .delete(deleteSides);

export default router;
