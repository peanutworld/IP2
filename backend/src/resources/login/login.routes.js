import express from "express";
import { validateLogin } from "./login.controllers.js";

const router = express.Router();

router.route("/").post(validateLogin);

export default router;
