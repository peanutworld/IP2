import Sides from "../../db/models/Sides.js";
import { createCustomError } from "../../errors/customErrors.js";
import { tryCatchWrapper } from "../../middlewares/tryCatchWrapper.js";
import { v4 as uuidv4 } from "uuid";

/**
 * @description Get all sides
 * @route GET /sides
 */
export const getSides = tryCatchWrapper(async function (req, res, next) {
  const sides = await Sides.findAll();
  if (!sides.length) return res.status(200).json({ message: "Empty list" });

  return res.status(200).json(sides);
});

/**
 * @description Get single side
 * @route GET /sides/:sidesGuid
 */
export const getSingleSides = tryCatchWrapper(async function (req, res, next) {
  const { sidesGuid } = req.params;

  const side = await Sides.findByPk(sidesGuid);
  if (!side) return next(createCustomError("Side not found", 404));

  return res.status(200).json(side);
});

/**
 * @description Create sides
 * @route POST /sides
 */
export const addAddress = tryCatchWrapper(async function (req, res, next, t) {
  const { name, price } = req.body;

  if (!name || !price) 
    return next(createCustomError("All fields are required", 400));

  const sidesGuid = uuidv4();

  await Sides.create({ sidesGuid, name, price }, { transaction: t });

  return res.status(201).json({ message: "Side has been created" });
}, true);

/**
 * @description Update side
 * @route PATCH /sides/:sidesGuid
 */
export const updateSides = tryCatchWrapper(async function (req, res, next, t) {
  const { sidesGuid } = req.params;
  const { name, price } = req.body;

  if (!name || !price)
    return next(createCustomError("All fields are required", 400));

  const side = await Sides.findByPk(sidesGuid, { transaction: t });
  if (!side) return next(createCustomError("Side not found", 404));

  await side.update({ name, price }, { transaction: t });

  return res.status(201).json({ message: "Side has been updated" });
}, true);

/**
 * @description Delete sides
 * @route DELETE /sides/:sidesGuid
 */
export const deleteSides = tryCatchWrapper(async function (req, res, next, t) {
  const { sidesGuid } = req.params;

  if (!sidesGuid) return next(createCustomError("Side guid is required", 400));

  const side = await Sides.findByPk(sidesGuid, { transaction: t });
  if (!side) return next(createCustomError("Side not found", 404));

  await side.destroy({ transaction: t });

  return res.status(200).json({ message: "Side has been deleted" });
}, true);
