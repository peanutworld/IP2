import { DataTypes } from "sequelize";
import sequelize from "../connect.js";

const Groups = sequelize.define(
  "Groups",
  {
    groupGuid: {
      type: DataTypes.STRING(36),
      primaryKey: true,
    },
    name: {
      type: DataTypes.STRING(100),
      allowNull: true,
    },
  },
  {
    timestamps: false,
    tableName: "groups",
  }
);

export default Groups;
