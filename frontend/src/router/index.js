import { createRouter, createWebHistory } from "vue-router";
import SidesPage from "../views/SidesPage.vue";
import LoginPage from "../views/LoginPage.vue";
import GroupsPage from "../views/GroupsPage.vue";
import ArticlesPage from "../views/ArticlesPage.vue";
import OrdersPage from "../views/OrdersPage.vue";
import store from "../store";
import Cookies from "js-cookie";

const routes = [
  {
    path: "/",
    name: "Home",
    component: OrdersPage,
    meta: { requiresAuth: true },
  },
  {
    path: "/sides",
    name: "Sides",
    component: SidesPage,
    meta: { requiresAuth: true },
  },
  {
    path: "/groups",
    name: "Groups",
    component: GroupsPage,
    meta: { requiresAuth: true },
  },
  {
    path: "/articles",
    name: "Articles",
    component: ArticlesPage,
    meta: { requiresAuth: true },
  },
  {
    path: "/orders",
    name: "Orders",
    component: OrdersPage,
    meta: { requiresAuth: true },
  },
  { path: "/login", name: "Login", component: LoginPage },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

router.beforeEach((to, from, next) => {
  // Check if route requires authentication and user is not logged in
  if (
    to.meta.requiresAuth &&
    !store.getters.loggedIn &&
    Cookies.get("loggedIn") !== "true"
  ) {
    next("/login"); // Redirect to login page if trying to access a protected route without logging in
  } else {
    next();
  }
});

export default router;
