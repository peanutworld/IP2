<template>
  <v-app>
    <template v-if="loggedIn">
      <!-- Navigation Drawer -->
      <v-navigation-drawer app v-model="drawer">
        <!-- Logo Section -->
        <v-container class="logo-container">
          <v-row>
            <v-col cols="12">
              <img
                :src="require('@/assets/logo.png')"
                alt="Logo"
                class="logo-img"
              />
            </v-col>
          </v-row>
        </v-container>

        <v-list color="transparent">
          <router-link
            v-for="(item, index) in items"
            :key="index"
            :to="item.route"
            class="router-link-custom"
          >
            <v-list-item
              :prepend-icon="item.icon"
              :title="item.title"
            ></v-list-item>
          </router-link>
        </v-list>

        <template v-slot:append>
          <div class="pa-2">
            <v-btn block @click="logout" color="primary"> Logout </v-btn>
          </div>
        </template>
      </v-navigation-drawer>

      <!-- App Bar with Burger Icon -->
      <v-app-bar app color="primary">
        <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
        <v-toolbar-title>{{ currentTitle }}</v-toolbar-title>
      </v-app-bar>

      <!-- Main Content -->
      <v-main>
        <router-view />
      </v-main>
    </template>
    <template v-else>
      <LoginPage />
    </template>
  </v-app>
</template>

<script>
import { computed } from "vue";
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import LoginPage from "./views/LoginPage.vue";

export default {
  name: "App",
  components: {
    LoginPage,
  },
  setup() {
    const store = useStore();
    const router = useRouter();

    const items = [
      { title: "Orders", route: "/orders", icon: "mdi-cart" },
      { title: "Sides", route: "/sides", icon: "mdi-account-box" },
      { title: "Groups", route: "/groups", icon: "mdi-account-group" },
      { title: "Articles", route: "/articles", icon: "mdi-newspaper" },
    ];

    const currentTitle = computed(() => store.getters.currentTitle);
    const loggedIn = computed(() => store.getters.loggedIn);

    // State for navigation drawer
    const drawer = computed({
      get() {
        return store.state.drawer;
      },
      set(value) {
        store.commit("SET_DRAWER", value);
      },
    });

    const logout = () => {
      store.dispatch("logout");
      router.push("/login");
    };

    return {
      items,
      currentTitle,
      drawer,
      loggedIn,
      logout,
    };
  },
};
</script>

<style>
body {
  background-color: black;
}
.router-link-custom {
  text-decoration: none;
  color: inherit;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.router-link-custom:hover,
.router-link-custom:focus,
.router-link-custom:active {
  color: #1867c0;
  background-color: #f0f0f0;
}

.logo-container {
  text-align: center;
  padding: 20px 0;
}

.logo-img {
  max-width: 60%;
  height: auto;
}
</style>
