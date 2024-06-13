<template>
  <div>
    <div class="main-table">
      <v-data-table
        :headers="headers"
        :items="orders"
        :items-per-page="5"
        class="elevation-1"
      >
        <template v-slot:[`item.actions`]="{ item }">
          <v-icon small @click="viewOrder(item)">mdi-eye</v-icon>
        </template>
        <template v-slot:[`item.status`]="{ item }">
          <span :style="{ color: item.status === 1 ? 'green' : 'orange' }">
            {{ item.status === 1 ? "Finished" : "Pending" }}
          </span>
        </template>
      </v-data-table>
    </div>
    <div class="split-container">
      <!-- Left side: Table of orders -->
      <div class="left-side">
        <h2>View Order</h2>
        <v-text-field
          v-model="formData.username"
          label="Username"
          readonly
        ></v-text-field>
        <v-text-field
          v-model="formData.address"
          label="Address"
          readonly
        ></v-text-field>
        <v-text-field
          v-model="formData.dateCreated"
          label="Date Created"
          readonly
        ></v-text-field>
        <v-text-field
          v-model="formData.dateDelivered"
          label="Date Delivered"
          readonly
        ></v-text-field>
        <v-textarea v-model="formData.note" label="Note" readonly></v-textarea>
      </div>
      <!-- Right side: Form for viewing order -->
      <div class="right-side">
        <h2>Order Details</h2>
        <v-card v-if="selectedOrderItems.length > 0">
          <v-list-item-group>
            <v-list-item
              v-for="item in selectedOrderItems"
              :key="item.itemGuid"
            >
              <v-list-item-content>
                <v-list-item-title>{{ item.articleName }}</v-list-item-title>
                <v-list-item-subtitle>{{ item.note }}</v-list-item-subtitle>
                <v-list-item-subtitle v-if="item.firstSideName">{{
                  item.firstSideName
                }}</v-list-item-subtitle>
                <v-list-item-subtitle v-if="item.secondSideName">{{
                  item.secondSideName
                }}</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
          </v-list-item-group>
        </v-card>
        <v-alert v-else>No items found for the selected order.</v-alert>

        <!-- Button to mark as pending/finished -->
        <v-btn @click="toggleStatus" v-if="formData.status !== null">
          {{ formData.status === 1 ? "Mark as Pending" : "Mark as Finished" }}
        </v-btn>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, reactive, onMounted } from "vue";
import axios from "axios";

export default {
  name: "OrdersPage",
  setup() {
    const orders = ref([]);
    const headers = [
      { text: "Username", value: "username" },
      { text: "Address", value: "address" },
      { text: "Date created", value: "dateCreated" },
      { text: "Date delivered", value: "dateDelivered" },
      { text: "Status", value: "status" },
      { text: "Actions", value: "actions", sortable: false },
    ];

    const formData = reactive({
      username: "",
      address: "",
      dateCreated: "",
      dateDelivered: "",
      note: "",
      status: null,
    });

    const selectedOrderItems = ref([]);

    const fetchOrders = async () => {
      try {
        const response = await axios.get(
          `${process.env.VUE_APP_API_URL}/orders`
        );
        orders.value = response.data;
      } catch (error) {
        console.error("Error fetching orders:", error);
      }
    };

    const viewOrder = async (order) => {
      // Populate form data with the order details
      formData.username = order.username;
      formData.address = order.address;
      formData.dateCreated = order.dateCreated;
      formData.dateDelivered = order.status === 1 ? order.dateDelivered : null;
      formData.note = order.note;
      formData.status = order.status;

      try {
        const response = await axios.get(
          `${process.env.VUE_APP_API_URL}/orders/${order.orderGuid}`
        );
        selectedOrderItems.value = response.data;
      } catch (error) {
        console.error("Error fetching order details:", error);
      }
    };
    const toggleStatus = async () => {
      try {
        const newStatus = formData.status === 1 ? 0 : 1;
        formData.status = newStatus;

        const orderGuid =
          selectedOrderItems.value.length > 0
            ? selectedOrderItems.value[0].orderGuid
            : null;

        await axios.patch(
          `${process.env.VUE_APP_API_URL}/orders/${orderGuid}`,
          {
            status: newStatus,
          }
        );

        fetchOrders();
      } catch (error) {
        console.error("Error toggling order status:", error);
      }
    };

    const resetForm = () => {
      formData.username = "";
      formData.address = "";
      formData.dateCreated = "";
      formData.dateDelivered = "";
      formData.note = "";
      selectedOrderItems.value = [];
    };

    onMounted(() => {
      fetchOrders();
    });

    return {
      orders,
      headers,
      formData,
      viewOrder,
      resetForm,
      toggleStatus,
      selectedOrderItems,
    };
  },
};
</script>

<style scoped>
.main-table {
  padding: 20px;
}
.split-container {
  display: flex;
}
.left-side {
  flex: 1;
  padding: 20px;
}
.right-side {
  flex: 1;
  padding: 20px;
}
</style>
