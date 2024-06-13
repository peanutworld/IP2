import Addresses from "../../db/models/Addresses.js";
import { createCustomError } from "../../errors/customErrors.js";
import { tryCatchWrapper } from "../../middlewares/tryCatchWrapper.js";
import { v4 as uuidv4 } from "uuid";

/**
 * @description Get address for user
 * @route GET /addresses/:userGuid
 */
export const getAddress = tryCatchWrapper(async function (req, res, next) {
  const { userGuid } = req.params;

  const addresses = await Addresses.findAll({ where: { userGuid } });
  if (!addresses.length) return res.status(200).json({ message: "Empty list" });

  return res.status(200).json(addresses);
});

/**
 * @description Create address
 * @route POST /addresses
 */
export const addAddress = tryCatchWrapper(async function (req, res, next, t) {
  const { userGuid, streetName, city, postCode } = req.body;

  if (!userGuid || !streetName || !city || !postCode) 
    return next(createCustomError("All fields are required", 400));

  const addressGuid = uuidv4();

  await Addresses.create({ addressGuid, userGuid, streetName, city, postCode }, { transaction: t });

  return res.status(201).json({ message: "Address has been assiged to user" });
}, true);

/**
 * @description Update address
 * @route PATCH /addresses/:addressGuid
 */
export const updateAddress = tryCatchWrapper(async function (req, res, next, t) {
  const { addressGuid, streetName, city, postCode } = req.body;

  if (!streetName || !city || !postCode)
    return next(createCustomError("All fields are required", 400));

  const address = await Addresses.findByPk(addressGuid, { transaction: t });
  if (!address) return next(createCustomError("Address not found", 404));

  await address.update({ streetName, city, postCode }, { transaction: t });

  return res.status(201).json({ message: "Address has been updated" });
}, true);

/**
 * @description Delete address
 * @route DELETE /addresses/:addressGuid
 */
export const deleteAddress = tryCatchWrapper(async function (req, res, next, t) {
  const { addressGuid } = req.params;

  if (!addressGuid) return next(createCustomError("Address guid is required", 400));

  const address = await Addresses.findByPk(addressGuid, { transaction: t });
  if (!address) return next(createCustomError("Address not found", 404));

  await address.destroy({ transaction: t });

  return res.status(200).json({ message: "Address has been deleted" });
}, true);
