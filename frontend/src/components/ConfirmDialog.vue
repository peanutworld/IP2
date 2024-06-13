<template>
  <v-dialog v-model="localConfirmDialog" max-width="500">
    <v-card>
      <v-card-title>Confirm Delete</v-card-title>
      <v-card-actions>
        <v-btn color="primary" @click="confirmDelete">Yes</v-btn>
        <v-btn @click="closeDialog">No</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  name: "ConfirmDialog",
  props: {
    confirmDialog: {
      type: Boolean,
      required: true,
    },
  },
  data() {
    return {
      localConfirmDialog: this.confirmDialog,
    };
  },
  watch: {
    confirmDialog(newVal) {
      this.localConfirmDialog = newVal;
    },
    localConfirmDialog(newVal) {
      this.$emit("update:confirmDialog", newVal);
    },
  },
  methods: {
    confirmDelete() {
      this.$emit("delete-confirmed");
      this.localConfirmDialog = false;
    },
    closeDialog() {
      this.localConfirmDialog = false;
    },
  },
};
</script>
