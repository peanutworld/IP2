<template>
  <div class="split-container">
    <!-- Left side: Table of sides -->
    <div class="left-side">
      <div class="left-side">
        <DataTable
          :headers="headers"
          :items="sides"
          :editItem="editSide"
          :confirmDelete="confirmDelete"
        />
      </div>
    </div>

    <!-- Right side: Form for creating/updating side -->
    <div class="right-side">
      <form @submit.prevent="submitForm">
        <h2>{{ formTitle }}</h2>
        <v-text-field v-model="formData.name" label="Name"></v-text-field>
        <v-text-field
          v-model="formData.price"
          label="Price"
          type="number"
          step="0.01"
        ></v-text-field>
        <v-btn type="submit" :color="formMode === 'create' ? 'red' : 'success'">
          {{ formMode === "create" ? "Create" : "Update" }}
        </v-btn>
      </form>
    </div>

    <!-- Confirmation Dialog -->
    <ConfirmDialog
      v-model:confirmDialog="confirmDialog"
      @delete-confirmed="deleteSideConfirmed"
    />

    <!-- Success Dialog -->
    <SuccessDialog v-model:successDialog="successDialog" />
  </div>
</template>

<script>
import { ref, reactive, onMounted } from "vue";
import axios from "axios";
import DataTable from "@/components/DataTable.vue";
import ConfirmDialog from "@/components/ConfirmDialog.vue";
import SuccessDialog from "@/components/SuccessDialog.vue";

export default {
  name: "SidesPage",
  components: {
    DataTable,
    ConfirmDialog,
    SuccessDialog,
  },
  setup() {
    const sides = ref([]);
    const headers = [
      { text: "Name", value: "name" },
      { text: "Price", value: "price" },
      { text: "Actions", value: "actions", sortable: false },
    ];

    // Form data and mode (create/update)
    const formData = reactive({
      name: "",
      price: "",
    });
    let formMode = ref("create");
    const formTitle = ref("Create Side");

    // Storing the GUID of the side being edited
    const sidesGuid = ref(null);

    // Modal states
    const confirmDialog = ref(false);
    const successDialog = ref(false);

    const fetchSides = async () => {
      try {
        const response = await axios.get(
          `${process.env.VUE_APP_API_URL}/sides`
        );
        sides.value = response.data;
      } catch (error) {
        console.error("Error fetching sides:", error);
      }
    };

    const editSide = (side) => {
      formMode.value = "edit";
      formTitle.value = "Edit Side";
      sidesGuid.value = side.sidesGuid; // Set the GUID of the side being edited

      // Populate form data with the side details
      formData.name = side.name;
      formData.price = side.price;
    };

    const submitForm = async () => {
      try {
        if (formMode.value === "create") {
          // Handle create action
          await axios.post(`${process.env.VUE_APP_API_URL}/sides`, formData);
        } else if (formMode.value === "edit") {
          // Handle update action
          await axios.patch(
            `${process.env.VUE_APP_API_URL}/sides/${sidesGuid.value}`,
            formData
          );
        }

        resetForm();
        await fetchSides(); // Refresh sides after update
        showSuccess();
      } catch (error) {
        console.error("Error submitting form:", error);
      }
    };

    const confirmDelete = (side) => {
      sidesGuid.value = side.sidesGuid;
      showConfirmation();
    };

    const deleteSideConfirmed = async () => {
      try {
        await axios.delete(
          `${process.env.VUE_APP_API_URL}/sides/${sidesGuid.value}`
        );
        await fetchSides(); // Refresh sides after deletion
        hideConfirmation(); // Hide confirmation dialog
        showSuccess(); // Show success message
      } catch (error) {
        console.error("Error deleting side:", error);
      }
    };

    const resetForm = () => {
      formData.name = "";
      formData.price = "";
      formMode.value = "create";
      formTitle.value = "Create Side";
      sidesGuid.value = null;
    };

    const showConfirmation = () => {
      confirmDialog.value = true;
    };

    const hideConfirmation = () => {
      confirmDialog.value = false;
    };

    const showSuccess = () => {
      successDialog.value = true;
    };

    const hideSuccess = () => {
      successDialog.value = false;
    };

    onMounted(fetchSides);

    return {
      sides,
      headers,
      formData,
      formMode,
      formTitle,
      editSide,
      submitForm,
      confirmDialog,
      successDialog,
      confirmDelete,
      deleteSideConfirmed,
      resetForm,
      showConfirmation,
      hideConfirmation,
      showSuccess,
      hideSuccess,
    };
  },
};
</script>

<style scoped>
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
