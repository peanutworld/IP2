import Orders from "../../db/models/Orders.js";
import Items from "../../db/models/Items.js";
import Users from "../../db/models/Users.js";
import Addresses from "../../db/models/Addresses.js";
import Articles from "../../db/models/Articles.js";
import Sides from "../../db/models/Sides.js";
import { createCustomError } from "../../errors/customErrors.js";
import { tryCatchWrapper } from "../../middlewares/tryCatchWrapper.js";

/**
 * @description Get all orders
 * @route GET /orders
 */
export const getAllOrders = tryCatchWrapper(async function (req, res, next) {
  const orders = await Orders.findAll();

  if (!orders.length) {
    return res.status(200).json({ message: "Empty list" });
  }

  // Fetching usernames and addresses for all orders
  const userGuids = orders.map((order) => order.userGuid);
  const addressGuids = orders.map((order) => order.addressGuid);

  // Fetching usernames
  const usernames = await Users.findAll({
    where: { userGuid: userGuids },
  });

  // Fetching addresses
  const addresses = await Addresses.findAll({
    where: { addressGuid: addressGuids },
  });

  // Mapping usernames and addresses to respective orders
  orders.forEach((order) => {
    const username = usernames.find((user) => user.userGuid === order.userGuid);
    const address = addresses.find(
      (addr) => addr.addressGuid === order.addressGuid
    );

    order.dataValues.username = username ? username.username : null;
    order.dataValues.address = address
      ? `${address.streetName} ${address.city} ${address.postCode}`
      : null;
  });

  return res.status(200).json(orders);
});

/**
 * @description Get order details
 * @route GET /orders/:orderGuid
 */
export const getOrderDetails = tryCatchWrapper(async function (req, res, next) {
  const { orderGuid } = req.params;

  const order = await Orders.findByPk(orderGuid);
  if (!order) {
    return next(createCustomError("Order not found", 404));
  }

  // Find all items related to the order
  const items = await Items.findAll({ where: { orderGuid } });

  // Prepare an array to store item details with article and side names
  const orderItems = [];

  // Loop through each item to fetch article and side names
  for (const item of items) {
    const { articleGuid, firstSideGuid, secondSideGuid, ...itemDetails } =
      item.dataValues;

    // Find article name using articleGuid from Articles model
    const article = await Articles.findByPk(articleGuid);
    if (!article) {
      return next(createCustomError("Article not found", 404));
    }
    const articleName = article.name;

    // Find first side name using firstSideGuid from Sides model (if firstSideGuid exists)
    let firstSideName = null;
    if (firstSideGuid) {
      const firstSide = await Sides.findByPk(firstSideGuid);
      if (!firstSide) {
        return next(createCustomError("First Side not found", 404));
      }
      firstSideName = firstSide.name;
    }

    // Find second side name using secondSideGuid from Sides model (if secondSideGuid exists)
    let secondSideName = null;
    if (secondSideGuid) {
      const secondSide = await Sides.findByPk(secondSideGuid);
      if (!secondSide) {
        return next(createCustomError("Second Side not found", 404));
      }
      secondSideName = secondSide.name;
    }

    // Add article and side names to item details
    orderItems.push({
      ...itemDetails,
      articleName,
      firstSideName,
      secondSideName,
    });
  }

  return res.status(200).json(orderItems);
});

/**
 * @description Update finish status
 * @route PATCH /orders/:orderGuid
 */
export const finishOrder = tryCatchWrapper(async function (req, res, next, t) {
  const { orderGuid } = req.params;
  const { status } = req.body;

  const order = await Orders.findByPk(orderGuid, { transaction: t });
  if (!order) return next(createCustomError("Order not found", 404));

  await order.update({ status }, { transaction: t });

  return res.status(201).json({ message: "Order has been updated" });
}, true);
