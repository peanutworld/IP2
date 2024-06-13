import { DataTypes } from "sequelize";
import sequelize from "../connect.js";

const Users = sequelize.define(
  "Users",
  {
    userGuid: {
      type: DataTypes.STRING(36),
      primaryKey: true,
    },
    username: {
      type: DataTypes.STRING(100),
    },
    email: {
      type: DataTypes.STRING(100),
    },
    password: {
      type: DataTypes.STRING(255),
    },
    phoneNumber: {
      type: DataTypes.STRING(100),
    },
    isAdmin: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
    },
  },
  {
    timestamps: false,
    tableName: 'users',
  }
);

export default Users;
