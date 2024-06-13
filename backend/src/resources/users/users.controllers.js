import Users from "../../db/models/Users.js";
import Addresses from "../../db/models/Addresses.js";
import { createCustomError } from "../../errors/customErrors.js";
import { tryCatchWrapper } from "../../middlewares/tryCatchWrapper.js";
import { v4 as uuidv4 } from "uuid";
import { hashPassword } from "../../utils/helper.util.js";

/**
 * @description Get all users
 * @route GET /users
 */
export const getUsers = tryCatchWrapper(async function (req, res, next) {
  const users = await Users.findAll();
  if (!users.length) return res.status(200).json({ message: "Empty list" });

  return res.status(200).json(users);
});

/**
 * @description Get single user
 * @route GET /users/:userGuid
 */
export const getSingleUser = tryCatchWrapper(async function (req, res, next) {
  const { userGuid } = req.params;

  const user = await Users.findByPk(userGuid);
  if (!user) return next(createCustomError("User not found", 404));

  return res.status(200).json(user);
});

/**
 * @description Create user
 * @route POST /users
 */
export const createUser = tryCatchWrapper(async function (req, res, next, t) {
  const { username, email, password, phoneNumber, isAdmin } = req.body;

  if (!username || !email || !password || !phoneNumber || !isAdmin) 
    return next(createCustomError("All fields are required", 400));

  const userGuid = uuidv4();
  const hashedPassword = await hashPassword(password);

  await Users.create({ userGuid, username, email, hashedPassword, phoneNumber, isAdmin }, { transaction: t });

  return res.status(201).json({ message: "User has been created" });
}, true);

/**
 * @description Update user
 * @route PATCH /users
 */
export const updateUser = tryCatchWrapper(async function (req, res, next, t) {
  const { userGuid, username, email, password, phoneNumber, isAdmin } = req.body;

  if (!userGuid || !username || !email || !password || !phoneNumber || !isAdmin)
    return next(createCustomError("All fields are required", 400));

  const user = await Users.findByPk(userGuid, { transaction: t });
  if (!user) return next(createCustomError("User not found", 404));

  const hashedPassword = await hashPassword(password);

  await user.update({ username, email, hashedPassword, phoneNumber, isAdmin }, { transaction: t });

  return res.status(201).json({ message: "User has been updated" });
}, true);

/**
 * @description Delete user
 * @route DELETE /users
 */
export const deleteUser = tryCatchWrapper(async function (req, res, next, t) {
  const { userGuid } = req.params;

  if (!userGuid) return next(createCustomError("User guid is required", 400));

  const user = await Users.findByPk(userGuid, { transaction: t });
  if (!user) return next(createCustomError("User not found", 404));

  // Delete addresses related to that user
  const addresses = await Addresses.findAll({ where: { userGuid }, transaction: t });
  if (addresses.length) {
    await Addresses.destroy({ where: { userGuid }, transaction: t });
  }

  await user.destroy({ transaction: t });

  return res.status(200).json({ message: "User and his addresses have been deleted" });
}, true);
