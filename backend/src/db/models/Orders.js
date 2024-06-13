import { DataTypes } from "sequelize";
import sequelize from "../connect.js";

const Orders = sequelize.define(
  "Orders",
  {
    orderGuid: {
      type: DataTypes.STRING(36),
      primaryKey: true,
    },
    userGuid: {
      type: DataTypes.STRING(36),
      allowNull: true,
    },
    addressGuid: {
      type: DataTypes.STRING(36),
      allowNull: true,
    },
    dateCreated: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    dateDelivered: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    status: {
      type: DataTypes.INTEGER,
      defaultValue: 0,
    },
    note: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
  },
  {
    timestamps: false,
    tableName: "orders",
  }
);

export default Orders;
