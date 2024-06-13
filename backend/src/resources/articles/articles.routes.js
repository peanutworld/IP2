import express from "express";
import {
  getArticles,
  getSingleArticle,
  createArticle,
  updateArticle,
  deleteArticle,
} from "./articles.controllers.js";

const router = express.Router();

router.route("/").get(getArticles).post(createArticle);
router
  .route("/:articlesGuid")
  .get(getSingleArticle)
  .patch(updateArticle)
  .delete(deleteArticle);

export default router;
