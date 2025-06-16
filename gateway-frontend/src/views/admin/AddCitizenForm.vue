<template>
  <div class="bg-white px-4 py-8 rounded min-w-[700px]">
    <div :style="{ color: props.themeColor || '#1867c0' }" class="font-semibold text-2xl pb-8 text-center">
      {{ props.editedCitizen?'Edit Citizen Details':'Register Citizen' }} 
    </div>

    <v-form ref="formRef" @submit.prevent="registerCitizen()" class="flex flex-col gap-4 z-10">
      <div class="grid grid-cols-3 gap-2">
        <v-text-field :rules="[v => !!v || 'Field is required']" required v-model="formData.fname" variant="outlined" label="First Name" :color="props.themeColor"
          @focus="focused[0] = true" @blur="focused[0] = false">
        </v-text-field>
        <v-text-field :rules="[v => !!v || 'Field is required']" required v-model="formData.mname" variant="outlined" label="Middle Name" :color="props.themeColor"
          @focus="focused[1] = true" @blur="focused[1] = false">
        </v-text-field>

        <v-text-field :rules="[v => !!v || 'Field is required']" required v-model="formData.lname" variant="outlined" label="Surname" :color="props.themeColor"
          @focus="focused[2] = true" @blur="focused[2] = false">
        </v-text-field>
      </div>
      <div class="grid grid-cols-2 gap-2">
        <v-date-input :rules="[v => !!v || 'Field is required']" required :max="today" v-model="formData.dob" label="Date of birth" variant="outlined"></v-date-input>

        <v-radio-group :rules="[v => !!v || 'Field is required']" required label="Gender" v-model="formData.gender" inline>
          <v-radio value="Male" label="Male"></v-radio>
          <v-radio value="Female" label="Female"></v-radio>
        </v-radio-group>
        <!-- <v-text-field v-model="formData.district" variant="outlined" label="Gender" :color="props.themeColor"
          @focus="focused[4] = true" @blur="focused[4] = false">
        </v-text-field> -->
      </div>


      <div class="py-4 w-full">
        <v-btn :loading="isLoading" type="submit" :color="props.themeColor || 'primary'" width="100%">Add</v-btn>
      </div>
    </v-form>
  </div>
</template>

<script setup>
import { onMounted, ref, defineEmits } from 'vue'
import { getSignerContract } from '@/utils/contractService'
import {useGatewayStore} from "@/stores/gateway.js"


const formRef = ref(null)
const today = new Date().toISOString().split('T')[0]
const store = useGatewayStore()
const focused = ref([])
const emit = defineEmits(['close'])
const isLoading = ref(false)
const formData = ref({
  fname: '',
  mname: '',
  lname: '',
  gender: '',
  region: '',
  district: '',
  dob: null,
})

const props = defineProps(['themeColor', 'editedCitizen'])

const convertToDateObject = (dateString) => {
  const date = new Date(dateString)
  return date
}

onMounted(() => {
  if (props.editedCitizen) {
    formData.value.fname = props.editedCitizen.firstName
    formData.value.lname = props.editedCitizen.lastName
    formData.value.mname = props.editedCitizen.middleName
    formData.value.gender = props.editedCitizen.gender
    formData.value.dob = convertToDateObject(props.editedCitizen.dateofBirth)
  }
})

const registerCitizen = async () => {

  const res = await formRef.value?.validate()
  
  
  if (!res.valid) {
    console.log('not valid');
    return
  }

  isLoading.value = true
  const randomInteger = Math.floor(Math.random() * 100000000)  
  await store.addCitizen(formData.value.fname, formData.value.mname,randomInteger.toString(), formData.value.lname, formData.value.gender, formData.value.dob.toString() );
  isLoading.value = false
  emit('close')

}

</script>
