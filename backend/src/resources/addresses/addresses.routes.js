import express from "express";
import {
  getAddress,
  deleteAddress,
  addAddress,
  updateAddress,
} from "./addresses.controllers.js";

const router = express.Router();

router.route("/").post(addAddress);
router
  .route("/:userGuid")
  .get(getAddress)
  .delete(deleteAddress)
  .patch(updateAddress);

export default router;
