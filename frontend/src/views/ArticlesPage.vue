<template>
  <div class="split-container">
    <!-- Left side: Table of articles -->
    <div class="left-side">
      <DataTable
        :headers="headers"
        :items="articles"
        :editItem="editArticle"
        :confirmDelete="confirmDelete"
      />
    </div>

    <!-- Right side: Form for creating/updating articles -->
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
        <v-textarea
          v-model="formData.description"
          label="Description"
        ></v-textarea>
        <v-btn type="submit" :color="formMode === 'create' ? 'red' : 'success'">
          {{ formMode === "create" ? "Create" : "Update" }}
        </v-btn>
      </form>
    </div>

    <!-- Confirmation Dialog -->
    <ConfirmDialog
      v-model:confirmDialog="confirmDialog"
      @delete-confirmed="deleteArticleConfirmed"
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
  name: "ArticlesPage",
  components: {
    DataTable,
    ConfirmDialog,
    SuccessDialog,
  },
  setup() {
    const articles = ref([]);
    const groups = ref([]);
    const headers = [
      { text: "Name", value: "name" },
      { text: "Price", value: "price" },
      { text: "Description", value: "description" },
      { text: "Actions", value: "actions", sortable: false },
    ];

    // Form data and mode (create/update)
    const formData = reactive({
      name: "",
      price: "",
      description: "",
      groupGuid: "",
      articlesGuid: "",
    });
    let formMode = ref("create");
    const formTitle = ref("Create Article");

    // Storing the GUID of the article being edited
    const articlesGuid = ref(null);

    // Modal states
    const confirmDialog = ref(false);
    const successDialog = ref(false);

    const fetchArticles = async () => {
      try {
        const response = await axios.get(
          `${process.env.VUE_APP_API_URL}/articles`
        );
        articles.value = response.data;
        console.log(articles.value);
      } catch (error) {
        console.error("Error fetching articles:", error);
      }
    };

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

    const editArticle = (article) => {
      formMode.value = "edit";
      formTitle.value = "Edit Article";
      articlesGuid.value = article.articlesGuid; // Set the GUID of the article being edited

      // Populate form data with the article details
      formData.name = article.name;
      formData.price = article.price;
      formData.description = article.description;
      formData.groupGuid = article.groupGuid;
      formData.articlesGuid = article.articlesGuid;
    };

    const submitForm = async () => {
      try {
        if (formMode.value === "create") {
          // Handle create action
          await axios.post(`${process.env.VUE_APP_API_URL}/articles`, formData);
        } else if (formMode.value === "edit") {
          // Handle update action
          await axios.patch(
            `${process.env.VUE_APP_API_URL}/articles/${formData.articlesGuid}`,
            formData
          );
        }

        resetForm();
        await fetchArticles(); // Refresh articles after update
        showSuccess();
      } catch (error) {
        console.error("Error submitting form:", error);
      }
    };

    const confirmDelete = (article) => {
      articlesGuid.value = article.articlesGuid;
      showConfirmation();
    };

    const deleteArticleConfirmed = async () => {
      try {
        await axios.delete(
          `${process.env.VUE_APP_API_URL}/articles/${articlesGuid.value}`
        );
        await fetchArticles(); // Refresh articles after deletion
        hideConfirmation(); // Hide confirmation dialog
        showSuccess(); // Show success message
      } catch (error) {
        console.error("Error deleting article:", error);
      }
    };

    const resetForm = () => {
      formData.name = "";
      formData.price = "";
      formData.description = "";
      formData.groupGuid = "";
      formData.articlesGuid = "";
      formMode.value = "create";
      formTitle.value = "Create Article";
      articlesGuid.value = null;
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

    onMounted(() => {
      fetchArticles();
      fetchGroups();
    });

    return {
      articles,
      groups,
      headers,
      formData,
      formMode,
      formTitle,
      editArticle,
      submitForm,
      confirmDialog,
      successDialog,
      confirmDelete,
      deleteArticleConfirmed,
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
