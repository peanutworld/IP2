import Articles from "../../db/models/Articles.js";
import { createCustomError } from "../../errors/customErrors.js";
import { tryCatchWrapper } from "../../middlewares/tryCatchWrapper.js";
import { v4 as uuidv4 } from "uuid";

/**
 * @description Get all articles
 * @route GET /articles
 */
export const getArticles = tryCatchWrapper(async function (req, res, next) {
  const articles = await Articles.findAll();
  if (!articles.length) return res.status(200).json({ message: "Empty list" });

  return res.status(200).json(articles);
});

/**
 * @description Get single article
 * @route GET /articles/:articlesGuid
 */
export const getSingleArticle = tryCatchWrapper(async function (
  req,
  res,
  next
) {
  const { articlesGuid } = req.params;

  const article = await Articles.findByPk(articlesGuid);
  if (!article) return next(createCustomError("Article not found", 404));

  return res.status(200).json(article);
});

/**
 * @description Create article
 * @route POST /articles
 */
export const createArticle = tryCatchWrapper(async function (
  req,
  res,
  next,
  t
) {
  const { name, price, description, groupGuid } = req.body;

  if (!name || !price || !description)
    return next(createCustomError("All fields are required", 400));

  const articlesGuid = uuidv4();

  await Articles.create(
    { articlesGuid, name, price, description },
    { transaction: t }
  );

  return res.status(201).json({ message: "Article has been created" });
},
true);

/**
 * @description Update article
 * @route PATCH /articles/:articlesGuid
 */
export const updateArticle = tryCatchWrapper(async function (
  req,
  res,
  next,
  t
) {
  const { articlesGuid } = req.params;
  const { name, price, description } = req.body;

  if (!name || !price || !description)
    return next(createCustomError("All fields are required", 400));

  const article = await Articles.findByPk(articlesGuid, { transaction: t });
  if (!article) return next(createCustomError("Article not found", 404));

  await article.update({ name, price, description }, { transaction: t });

  return res.status(201).json({ message: "Article has been updated" });
},
true);

/**
 * @description Delete article
 * @route DELETE /articles/:articlesGuid
 */
export const deleteArticle = tryCatchWrapper(async function (
  req,
  res,
  next,
  t
) {
  const { articlesGuid } = req.params;

  if (!articlesGuid)
    return next(createCustomError("Article guid is required", 400));

  const article = await Articles.findByPk(articlesGuid, { transaction: t });
  if (!article) return next(createCustomError("Article not found", 404));

  await article.destroy({ transaction: t });

  return res.status(200).json({ message: "Article has been deleted" });
},
true);
