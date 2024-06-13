<template>
  <v-container fluid class="background">
    <v-row justify="center" align="center" style="height: 100vh">
      <v-col cols="12" sm="8" md="6">
        <!-- Logo -->
        <v-img src="@/assets/logo.png" contain class="logo"></v-img>

        <v-card class="login-container">
          <v-card-title class="headline">Login</v-card-title>
          <v-card-text>
            <v-form @submit.prevent="login">
              <!-- Username -->
              <v-text-field
                v-model="username"
                label="Username"
                outlined
                required
              ></v-text-field>

              <!-- Password -->
              <v-text-field
                v-model="password"
                label="Password"
                type="password"
                outlined
                required
              ></v-text-field>

              <!-- Remember Me -->
              <v-checkbox v-model="rememberMe" label="Remember Me"></v-checkbox>

              <!-- Login Button -->
              <v-btn color="primary" dark type="submit">Login</v-btn>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { ref } from "vue";
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import Cookies from "js-cookie";
import axios from "axios";

export default {
  name: "LoginPage",
  setup() {
    const store = useStore();
    const router = useRouter();

    const username = ref("");
    const password = ref("");
    const rememberMe = ref(false);

    const login = async () => {
      try {
        const response = await axios.post(
          `${process.env.VUE_APP_API_URL}/login`,
          {
            username: username.value,
            password: password.value,
          },
          {
            withCredentials: true,
          }
        );

        if (response.data.success) {
          store.commit("SET_LOGGED_IN", true); // Set logged in state in Vuex
          router.push("/");
        } else {
          alert("Invalid username or password");
        }
      } catch (error) {
        alert(error.response.data.message || "An error occurred");
        console.error(error);
      }
    };

    // Check if user is already logged in using cookies
    if (Cookies.get("loggedIn") === "true") {
      store.commit("SET_LOGGED_IN", true); // Set logged in state in Vuex
      router.push("/");
    }

    return {
      username,
      password,
      rememberMe,
      login,
    };
  },
};
</script>

<style scoped>
.background {
  background-color: #f0f0f0;
  background-size: cover;
  background-position: center;
}

.logo {
  max-width: 200px;
  margin-bottom: 20px;
}

.login-container {
  padding: 20px;
  background-color: white;
  border-radius: 10px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}
</style>
