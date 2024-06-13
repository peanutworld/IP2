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

/**
 * Helper function to check if provided password matches the hashed password
 * @param {string} plainPassword - The plain password to check
 * @param {string} hashedPassword - The hashed password stored in the database
 * @returns {boolean} - True if passwords match, false otherwise
 */
export const isPasswordCorrect = async (plainPassword, hashedPassword) => {
  try {
    const isMatch = await bcrypt.compare(plainPassword, hashedPassword);
    return isMatch;
  } catch (error) {
    // Handle any errors that bcrypt may throw
    throw new Error("Error comparing passwords");
  }
};
