import { DataTypes } from "sequelize";
import sequelize from "../connect.js";

const Sides = sequelize.define(
  "Sides",
  {
    sidesGuid: {
      type: DataTypes.STRING(36),
      primaryKey: true,
    },
    name: {
      type: DataTypes.STRING(100),
      allowNull: true,
    },
    price: {
      type: DataTypes.DECIMAL(20, 2),
      allowNull: true,
    },
  },
  {
    timestamps: false,
    tableName: 'sides',
  }
);

export default Sides;
