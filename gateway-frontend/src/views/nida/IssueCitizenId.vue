<template>
  <div class="bg-white px-4 py-8 rounded min-w-[700px]">
    <div :style="{ color: props.themeColor || '#1867c0' }" class="font-semibold text-2xl pb-8 text-center">
      {{ props.editedCitizen?'Edit Citizen Details':'Register Citizen' }} 
    </div>

    <v-form class="flex flex-col gap-4 z-10">
      <div class="grid grid-cols-3 gap-2">
        <v-text-field readonly v-model="formData.fname" variant="outlined" label="First Name" :color="props.themeColor"
          @focus="focused[0] = true" @blur="focused[0] = false">
        </v-text-field>
        <v-text-field readonly v-model="formData.mname" variant="outlined" label="Middle Name" :color="props.themeColor"
          @focus="focused[1] = true" @blur="focused[1] = false">
        </v-text-field>

        <v-text-field readonly v-model="formData.lname" variant="outlined" label="Surname" :color="props.themeColor"
          @focus="focused[2] = true" @blur="focused[2] = false">
        </v-text-field>
      </div>
      <div class="grid grid-cols-2 gap-2">
        <v-date-input readonly v-model="formData.dob" label="Date of birth" variant="outlined"></v-date-input>

        <v-radio-group readonly label="Gender" v-model="formData.gender" inline>

          <v-radio value="Male" label="Male"></v-radio>
          <v-radio value="Female" label="Female"></v-radio>

        </v-radio-group>
        <!-- <v-text-field v-model="formData.district" variant="outlined" label="Gender" :color="props.themeColor"
          @focus="focused[4] = true" @blur="focused[4] = false">
        </v-text-field> -->
      </div>


      <div class="py-4 w-full grid grid-cols-2 gap-5">
        <v-text-field readonly v-model="formData.citizenId" variant="outlined" label="Citizen ID Number" :color="props.themeColor"
          @focus="focused[2] = true" @blur="focused[2] = false">
        </v-text-field>
        <v-btn :variant="formData.citizenId?'flat':'outlined'" :loading="isLoading" @click="registerCitizen()" :color="props.themeColor || 'primary'" size="x-large">{{ !formData.citizenId?'GENERATE CITIZEN ID':'ISSUE CITIZEN iD' }}</v-btn>
      </div>
    </v-form>
  </div>
</template>

<script setup>
import { onMounted, ref, defineEmits } from 'vue'
import { getSignerContract } from '@/utils/contractService'
import {useGatewayStore} from "@/stores/gateway.js"

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
  citizenId:''
})

const generateCitizenId = ()=>{
      let randomInteger = Math.floor(Math.random() * 100000000)  
      let dateString = getDateNumbersString(convertToDateObject(props.editedCitizen.dateofBirth))
      formData.value.citizenId = `T-${dateString}-${randomInteger}`
}

const props = defineProps(['themeColor', 'editedCitizen'])

const convertToDateObject = (dateString) => {
  const date = new Date(dateString)
  return date
}

const getDateNumbersString = (date)=>{
    const day = String(date.getDate()).padStart(2, '0');       
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();                           

    return `${day}${month}${year}`;   
}

onMounted(() => {
  console.log(props.editedCitizen.dateofBirth);
  
  if (props.editedCitizen) {
    formData.value.fname = props.editedCitizen.firstName
    formData.value.lname = props.editedCitizen.lastName
    formData.value.mname = props.editedCitizen.middleName
    formData.value.gender = props.editedCitizen.gender
    formData.value.citizenId = props.editedCitizen.citizenId
    formData.value.dob = convertToDateObject(props.editedCitizen.dateofBirth)
  }
})

const registerCitizen = async () => {
    if(!formData.value.citizenId){
        generateCitizenId()
        return
    } else {
        isLoading.value = true
        await store.issueCitizenId(props.editedCitizen.birthCertificateNo, formData.value.citizenId)
        isLoading.value = false
        emit('close')
    }
}

</script>
