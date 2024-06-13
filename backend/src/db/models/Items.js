import { DataTypes } from "sequelize";
import sequelize from "../connect.js";

const Items = sequelize.define(
  "Items",
  {
    itemGuid: {
      type: DataTypes.STRING(36),
      primaryKey: true,
      allowNull: false,
    },
    orderGuid: {
      type: DataTypes.STRING(36),
      allowNull: true,
    },
    articleGuid: {
      type: DataTypes.STRING(36),
      allowNull: true,
    },
    firstSideGuid: {
      type: DataTypes.STRING(36),
      allowNull: true,
    },
    secondSideGuid: {
      type: DataTypes.STRING(36),
      allowNull: true,
    },
    note: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
  },
  {
    timestamps: false,
    tableName: "items",
  }
);

export default Items;
