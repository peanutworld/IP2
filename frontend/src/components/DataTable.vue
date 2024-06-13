<template>
  <v-data-table
    :headers="headers"
    :items="items"
    :items-per-page="10"
    class="elevation-1"
  >
    <template v-slot:[`item.actions`]="{ item }">
      <v-icon small @click="editItem(item)">mdi-pencil</v-icon>
      <v-icon small @click="confirmDelete(item)">mdi-delete</v-icon>
    </template>
  </v-data-table>
</template>

<script>
export default {
  name: "DataTable",
  props: {
    headers: Array,
    items: Array,
    editItem: Function,
    confirmDelete: Function,
  },
};
</script>
