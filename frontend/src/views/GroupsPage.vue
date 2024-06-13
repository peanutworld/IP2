<template>
  <div class="split-container">
    <!-- Left side: Table of groups -->
    <div class="left-side">
      <div class="left-side">
        <DataTable
          :headers="headers"
          :items="groups"
          :editItem="editGroup"
          :confirmDelete="confirmDelete"
        />
      </div>
    </div>

    <!-- Right side: Form for creating/updating groups -->
    <div class="right-side">
      <form @submit.prevent="submitForm">
        <h2>{{ formTitle }}</h2>
        <v-text-field v-model="formData.name" label="Name"></v-text-field>
        <v-btn type="submit" :color="formMode === 'create' ? 'red' : 'success'">
          {{ formMode === "create" ? "Create" : "Update" }}
        </v-btn>
      </form>
    </div>

    <!-- Confirmation Dialog -->
    <ConfirmDialog
      v-model:confirmDialog="confirmDialog"
      @delete-confirmed="deleteGroupConfirmed"
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
  name: "GroupsPage",
  components: {
    DataTable,
    ConfirmDialog,
    SuccessDialog,
  },
  setup() {
    const groups = ref([]);
    const headers = [
      { text: "Name", value: "name" },
      { text: "Actions", value: "actions", sortable: false },
    ];

    // Form data and mode (create/update)
    const formData = reactive({
      name: "",
    });
    let formMode = ref("create");
    const formTitle = ref("Create Group");

    // Storing the GUID of the group being edited
    const groupGuid = ref(null);

    // Modal states
    const confirmDialog = ref(false);
    const successDialog = ref(false);

    const fetchGroups = async () => {
      try {
        const response = await axios.get(
          `${process.env.VUE_APP_API_URL}/groups`
        );
        groups.value = response.data;
      } catch (error) {
        console.error("Error fetching groups:", error);
      }
    };

    const editGroup = (group) => {
      formMode.value = "edit";
      formTitle.value = "Edit Group";
      groupGuid.value = group.groupGuid; // Set the GUID of the group being edited

      // Populate form data with the group details
      formData.name = group.name;
    };

    const submitForm = async () => {
      try {
        if (formMode.value === "create") {
          // Handle create action
          await axios.post(`${process.env.VUE_APP_API_URL}/groups`, formData);
        } else if (formMode.value === "edit") {
          // Handle update action
          await axios.patch(
            `${process.env.VUE_APP_API_URL}/groups/${groupGuid.value}`,
            formData
          );
        }

        resetForm();
        await fetchGroups(); // Refresh groups after update
        showSuccess();
      } catch (error) {
        console.error("Error submitting form:", error);
      }
    };

    const confirmDelete = (side) => {
      groupGuid.value = side.groupGuid;
      showConfirmation();
    };

    const deleteGroupConfirmed = async () => {
      try {
        await axios.delete(
          `${process.env.VUE_APP_API_URL}/groups/${groupGuid.value}`
        );
        await fetchGroups(); // Refresh groups after deletion
        hideConfirmation(); // Hide confirmation dialog
        showSuccess(); // Show success message
      } catch (error) {
        console.error("Error deleting group:", error);
      }
    };

    const resetForm = () => {
      formData.name = "";
      formMode.value = "create";
      formTitle.value = "Create Group";
      groupGuid.value = null;
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

    onMounted(fetchGroups);

    return {
      groups,
      headers,
      formData,
      formMode,
      formTitle,
      editGroup,
      submitForm,
      confirmDialog,
      successDialog,
      confirmDelete,
      deleteGroupConfirmed,
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
