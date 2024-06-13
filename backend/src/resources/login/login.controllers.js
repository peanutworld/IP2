import Users from "../../db/models/Users.js";
import { createCustomError } from "../../errors/customErrors.js";
import { tryCatchWrapper } from "../../middlewares/tryCatchWrapper.js";
import { isPasswordCorrect } from "../../utils/helper.util.js";

/**
 * @description Validate user login
 * @route POST /login
 */
export const validateLogin = tryCatchWrapper(async function (
  req,
  res,
  next,
  t
) {
  const { username, password } = req.body;

  if (!username || !password)
    return next(createCustomError("All fields are required", 400));

  // Check if user exists
  const user = await Users.findOne({ where: { username } });
  if (!user) return next(createCustomError("User doesn't exist", 400));

  // Check if password is correct
  const passwordCorrect = await isPasswordCorrect(password, user.password);
  if (!passwordCorrect)
    return next(createCustomError("Invalid credentials", 400));

  // Check if user is an admin
  if (!user.isAdmin) return next(createCustomError("Unauthorized access", 401));

  return res.status(200).json({ success: true, message: "Login successful" });
},
true);
