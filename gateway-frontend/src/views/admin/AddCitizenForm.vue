<template>
  <div class="bg-white px-4 py-8 rounded min-w-[700px]">
    <div
      :style="{ color: props.themeColor || '#1867c0' }"
      class="font-semibold text-2xl pb-8 text-center"
    >
      Register Citizen
    </div>

    <v-form class="flex flex-col gap-4 z-10">
      <div class="grid grid-cols-3 gap-2">
        <v-text-field
          variant="outlined"
          label="First Name"
          :color="props.themeColor"
          @focus="focused[0] = true"
          @blur="focused[0] = false"
        >
        </v-text-field>
        <v-text-field
          variant="outlined"
          label="Middle Name"
          :color="props.themeColor"
          @focus="focused[1] = true"
          @blur="focused[1] = false"
        >
        </v-text-field>

        <v-text-field
          variant="outlined"
          label="Surname"
          :color="props.themeColor"
          @focus="focused[2] = true"
          @blur="focused[2] = false"
        >
        </v-text-field>
      </div>
      <div class="grid grid-cols-2 gap-2">
        <v-text-field
          variant="outlined"
          label="Region"
          :color="props.themeColor"
          @focus="focused[3] = true"
          @blur="focused[3] = false"
        >
        </v-text-field>
        <v-text-field
          variant="outlined"
          label="District"
          :color="props.themeColor"
          @focus="focused[4] = true"
          @blur="focused[4] = false"
        >
        </v-text-field>
      </div>

      <v-date-input label="Date of birth" variant="outlined"></v-date-input>

      <div class="py-4 w-full">
        <v-btn :color="props.themeColor || 'primary'" width="100%">Add</v-btn>
      </div>
    </v-form>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const focused = ref([])

const props = defineProps(['themeColor'])
</script>
