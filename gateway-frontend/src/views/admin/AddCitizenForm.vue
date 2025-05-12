<template>
  <div class="bg-white px-4 py-8 rounded min-w-[700px]">
    <div :style="{ color: props.themeColor || '#1867c0' }" class="font-semibold text-2xl pb-8 text-center">
      Register Citizen
    </div>

    <v-form class="flex flex-col gap-4 z-10">
      <div class="grid grid-cols-3 gap-2">
        <v-text-field v-model="formData.fname" variant="outlined" label="First Name" :color="props.themeColor"
          @focus="focused[0] = true" @blur="focused[0] = false">
        </v-text-field>
        <v-text-field v-model="formData.mname" variant="outlined" label="Middle Name" :color="props.themeColor"
          @focus="focused[1] = true" @blur="focused[1] = false">
        </v-text-field>

        <v-text-field v-model="formData.lname" variant="outlined" label="Surname" :color="props.themeColor"
          @focus="focused[2] = true" @blur="focused[2] = false">
        </v-text-field>
      </div>
      <div class="grid grid-cols-2 gap-2">
        <v-text-field v-model="formData.address" variant="outlined" label="Address" :color="props.themeColor"
          @focus="focused[3] = true" @blur="focused[3] = false">
        </v-text-field>
        <v-radio-group label="Gender" v-model="formData.gender" inline>

          <v-radio value="Male" label="Male"></v-radio>
          <v-radio value="Female" label="Female"></v-radio>

        </v-radio-group>
        <!-- <v-text-field v-model="formData.district" variant="outlined" label="Gender" :color="props.themeColor"
          @focus="focused[4] = true" @blur="focused[4] = false">
        </v-text-field> -->
      </div>

      <v-date-input v-model="formData.dob" label="Date of birth" variant="outlined"></v-date-input>

      <div class="py-4 w-full">
        <v-btn @click="registerCitizen()" :color="props.themeColor || 'primary'" width="100%">Add</v-btn>
      </div>
    </v-form>
  </div>
</template>

<script setup>
import { onMounted, ref, defineEmits } from 'vue'
import { getSignerContract } from '@/utils/contractService'

const focused = ref([])
const emit = defineEmits(['close'])

const formData = ref({
  fname: '',
  mname: '',
  lname: '',
  address: '',
  gender: '',
  region: '',
  district: '',
  dob: null,
})

const props = defineProps(['themeColor', 'editedCitizen'])

const convertToDateObject = (dateString) => {
  const [day, month, year] = dateString.split('/').map(Number)
  const date = new Date(year, month - 1, day) // Month is zero-based
  return date
}

onMounted(() => {
  if (props.editedCitizen) {
    formData.value.fname = props.editedCitizen.fname
    formData.value.lname = props.editedCitizen.lname
    formData.value.mname = props.editedCitizen.mname
    formData.value.gender = props.editedCitizen.gender
    formData.value.address = props.editedCitizen.address
    formData.value.region = props.editedCitizen.region
    formData.value.district = props.editedCitizen.district
    formData.value.dob = convertToDateObject(props.editedCitizen.dob)
  }
})

const registerCitizen = async () => {
  const { contract } = await getSignerContract()
  await contract.addCitizen(formData.value.fname, formData.value.mname, formData.value.lname, formData.value.address, formData.value.gender, formData.value.dob.toString());
  emit('close')

}
</script>
