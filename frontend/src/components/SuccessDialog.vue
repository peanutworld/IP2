<template>
  <v-dialog v-model="localSuccessDialog" max-width="500">
    <v-card>
      <v-card-title>Success</v-card-title>
      <v-card-actions>
        <v-btn color="primary" @click="closeDialog">Close</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  name: "SuccessDialog",
  props: {
    successDialog: {
      type: Boolean,
      required: true,
    },
  },
  data() {
    return {
      localSuccessDialog: this.successDialog,
    };
  },
  watch: {
    successDialog(newVal) {
      this.localSuccessDialog = newVal;
    },
    localSuccessDialog(newVal) {
      this.$emit("update:successDialog", newVal);
    },
  },
  methods: {
    closeDialog() {
      this.localSuccessDialog = false;
    },
  },
};
</script>
