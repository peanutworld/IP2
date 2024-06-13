import { DataTypes } from "sequelize";
import sequelize from "../connect.js";

const Addresses = sequelize.define(
  "Addresses",
  {
    addressGuid: {
      type: DataTypes.STRING(36),
      primaryKey: true,
    },
    userGuid: {
      type: DataTypes.STRING(36),
      allowNull: true,
    },
    streetName: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    city: {
      type: DataTypes.STRING(100),
      allowNull: true,
    },
    postCode: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
  },
  {
    timestamps: false,
    tableName: 'addresses',
  }
);

export default Addresses;
