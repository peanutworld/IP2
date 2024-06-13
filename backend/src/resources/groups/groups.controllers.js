import Groups from "../../db/models/Groups.js";
import { createCustomError } from "../../errors/customErrors.js";
import { tryCatchWrapper } from "../../middlewares/tryCatchWrapper.js";
import { v4 as uuidv4 } from "uuid";

/**
 * @description Get all groups
 * @route GET /groups
 */
export const getGroups = tryCatchWrapper(async function (req, res, next) {
  const groups = await Groups.findAll();
  if (!groups.length) return res.status(200).json({ message: "Empty list" });

  return res.status(200).json(groups);
});

/**
 * @description Get single group
 * @route GET /groups/:groupGuid
 */
export const getSingleGroup = tryCatchWrapper(async function (req, res, next) {
  const { groupGuid } = req.params;

  const group = await Groups.findByPk(groupGuid);
  if (!group) return next(createCustomError("Group not found", 404));

  return res.status(200).json(group);
});

/**
 * @description Create group
 * @route POST /groups
 */
export const createGroup = tryCatchWrapper(async function (req, res, next, t) {
  const { name } = req.body;

  if (!name) return next(createCustomError("All fields are required", 400));

  const groupGuid = uuidv4();

  await Groups.create({ groupGuid, name }, { transaction: t });

  return res.status(201).json({ message: "Group has been created" });
}, true);

/**
 * @description Update group
 * @route PATCH /groups/:groupGuid
 */
export const updateGroup = tryCatchWrapper(async function (req, res, next, t) {
  const { groupGuid } = req.params;
  const { name } = req.body;

  if (!name) return next(createCustomError("All fields are required", 400));

  const group = await Groups.findByPk(groupGuid, { transaction: t });
  if (!group) return next(createCustomError("Group not found", 404));

  await group.update({ name }, { transaction: t });

  return res.status(201).json({ message: "Group has been updated" });
}, true);

/**
 * @description Delete group
 * @route DELETE /groups/:groupGuid
 */
export const deleteGroup = tryCatchWrapper(async function (req, res, next, t) {
  const { groupGuid } = req.params;

  if (!groupGuid) return next(createCustomError("Group guid is required", 400));

  const group = await Groups.findByPk(groupGuid, { transaction: t });
  if (!group) return next(createCustomError("Group not found", 404));

  await group.destroy({ transaction: t });

  return res.status(200).json({ message: "Group has been deleted" });
}, true);
