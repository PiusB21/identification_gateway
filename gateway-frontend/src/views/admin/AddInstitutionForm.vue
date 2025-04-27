<template>
  <div class="bg-white px-4 py-8 rounded min-w-[700px]">
    <div
      :style="{ color: props.themeColor || '#1867c0' }"
      class="font-semibold text-2xl pb-8 text-center"
    >
      Register Institution
    </div>

    <v-form class="flex flex-col gap-4 z-10">
      <div class="grid grid-cols-2 gap-2">
        <v-text-field
          v-model="formData.region"
          variant="outlined"
          label="Institution Name"
          :color="props.themeColor"
          @focus="focused[3] = true"
          @blur="focused[3] = false"
        >
        </v-text-field>

        <v-text-field
          v-model="formData.region"
          variant="outlined"
          label="Abbreviation"
          :color="props.themeColor"
          @focus="focused[3] = true"
          @blur="focused[3] = false"
        >
        </v-text-field>
      </div>

      <v-select
        label="Type"
        :items="['Government', 'Health', 'Private', 'Academic']"
        variant="outlined"
      ></v-select>

      <div class="py-4 w-full">
        <v-btn :color="props.themeColor || 'primary'" width="100%">Add</v-btn>
      </div>
    </v-form>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'

const focused = ref([])

const formData = ref({
  name: '',
  mname: '',
  lname: '',
  region: '',
  district: '',
  dob: null,
})

const props = defineProps(['themeColor', 'editedCitizen'])

const convertToDateObject = (dateString) => {
  const [day, month, year] = dateString.split('/').map(Number) //for DD/MM/YYYY
  const date = new Date(year, month - 1, day) // Month is zero-based
  return date
}

onMounted(() => {
  if (props.editedCitizen) {
    formData.value.fname = props.editedCitizen.fname
    formData.value.lname = props.editedCitizen.lname
    formData.value.mname = props.editedCitizen.mname
    formData.value.region = props.editedCitizen.region
    formData.value.district = props.editedCitizen.district
    formData.value.dob = convertToDateObject(props.editedCitizen.dob)
  }
})
</script>
