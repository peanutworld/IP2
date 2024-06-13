import bcrypt from "bcrypt";

/**
 * Helper function to hash password using bcrypt
 * @param {string} password - The password to hash
 * @returns {string} - The hashed password
 */
export const hashPassword = async (password) => {
  const saltRounds = 10; // Number of salt rounds to use
  const hashedPassword = await bcrypt.hash(password, saltRounds);
  return hashedPassword;
};