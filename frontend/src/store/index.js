import { createStore } from "vuex";
import Cookies from "js-cookie";

export default createStore({
  state: {
    currentTitle: "Orders",
    drawer: true,
    loggedIn: false,
  },
  mutations: {
    setTitle(state, title) {
      state.currentTitle = title;
    },
    SET_DRAWER(state, value) {
      state.drawer = value;
    },
    SET_LOGGED_IN(state, value) {
      state.loggedIn = value;

      // Set cookie when logged in
      if (value) {
        Cookies.set("loggedIn", "true", { expires: 7 }); // Set cookie for 7 days
      } else {
        Cookies.remove("loggedIn"); // Remove cookie when logged out
      }
    },
    LOGOUT(state) {
      state.loggedIn = false;
      Cookies.remove("loggedIn"); // Remove cookie on logout
    },
  },
  actions: {
    setTitle({ commit }, title) {
      commit("setTitle", title);
    },
    setLoggedIn({ commit }, value) {
      commit("SET_LOGGED_IN", value);
    },
    logout({ commit }) {
      commit("LOGOUT");
    },
  },
  getters: {
    currentTitle: (state) => state.currentTitle,
    drawer: (state) => state.drawer,
    loggedIn: (state) => state.loggedIn,
  },
});
