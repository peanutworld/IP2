import { DataTypes } from "sequelize";
import sequelize from "../connect.js";

const Articles = sequelize.define(
  "Articles",
  {
    articlesGuid: {
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
    description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    groupGuid: {
      type: DataTypes.STRING(36),
      allowNull: true,
    },
  },
  {
    timestamps: false,
    tableName: "articles",
  }
);

export default Articles;
