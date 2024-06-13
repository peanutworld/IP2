import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import { notFound } from "./src/middlewares/notFound.js";
import { handleError } from "./src/middlewares/handleError.js";
import usersRoute from "./src/resources/users/users.routes.js";
import groupsRoute from "./src/resources/groups/groups.routes.js";
import articlesRoute from "./src/resources/articles/articles.routes.js";
import addressesRoute from "./src/resources/addresses/addresses.routes.js";
import sidesRoute from "./src/resources/sides/sides.routes.js";
import loginRoute from "./src/resources/login/login.routes.js";
import ordersRoute from "./src/resources/orders/orders.routes.js";

dotenv.config();

const app = express();
const port = process.env.API_PORT || 3000;

// Middleware
app.use(express.json());

// CORS Configuration for all domains
const corsOptions = {
  origin: "http://localhost:8080",
  credentials: true,
  optionSuccessStatus: 200,
};
app.use(cors(corsOptions));

// API routes
app.use("/users", usersRoute);
app.use("/groups", groupsRoute);
app.use("/articles", articlesRoute);
app.use("/addresses", addressesRoute);
app.use("/sides", sidesRoute);
app.use("/login", loginRoute);
app.use("/orders", ordersRoute);

app.use(notFound);
app.use(handleError);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
