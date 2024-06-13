import express from "express";
import {
  getAllOrders,
  getOrderDetails,
  finishOrder,
} from "./orders.controllers.js";

const router = express.Router();

router.route("/").get(getAllOrders);
router.route("/:orderGuid").get(getOrderDetails).patch(finishOrder);

export default router;
