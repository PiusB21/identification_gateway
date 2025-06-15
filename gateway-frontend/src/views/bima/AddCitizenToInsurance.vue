<template>
  <div class="bg-white px-4 py-8 rounded min-h-[80vh] max-h-[94vh] overflow-y-auto min-w-[700px] lg:w-[700px]">
    <div :style="{ color: 'rgb(125, 73, 12)' }" class="font-semibold text-2xl pb-4 text-center">
      {{ props.editedCitizen?'Edit Member':'Register Member' }} 
    </div>

    <div class="mb-2">
        <v-alert
            text="The number will be used to fetch the citizen's information, a non-existent citizen Id will be flagged"
            title="Add member's citizen Id"
            type="info"
            variant="tonal"
        ></v-alert>
    </div>

    <div class="flex gap-16">
        <v-text-field
          color="rgb(125, 73, 12)"
          v-model="citizenId"
          variant="outlined"
          label="Citizen ID"
        >
          <template v-slot:append>
            <v-btn  :disabled="!citizenId" :loading="isLoading" @click="getCitizenData()" size="x-large" color="rgb(125, 73, 12)">
              <div class="lowercase text-md">Fetch</div>
            </v-btn>
          </template>
        </v-text-field>
    </div>

    <section v-if="citizenData?.birthCertificateNo" class="flex flex-col gap-4 py-4">
        <div class="grid grid-cols-8">
          <div class="col-span-2 text-gray-600">Citizen Id</div>
          <div class="col-span-5 text-lg">{{citizenData.citizenId}}</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-2 text-gray-600 text-nowrap">Birth Certificate No.</div>
          <div class="col-span-5 text-lg">{{citizenData.birthCertificateNo}}</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-2 text-gray-600">Name</div>
          <div class="col-span-5 text-lg">{{citizenData.firstName}}&nbsp;{{citizenData.middleName}}&nbsp;{{citizenData.lastName}}</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-2 text-gray-600 text-nowrap">Date of Birth</div>
          <div class="col-span-5 text-lg">{{ new Date(citizenData.dateofBirth).toDateString() }}</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-2 text-gray-600 text-nowrap">Life Status</div>
          <div class="col-span-5 text-lg">
            <div 
            :class="citizenData.citizenStatus?'!border-green-700 text-green-700':'!border-red-700 text-red-700'"
            class="w-fit px-4 py-1 border-2 rounded-md font-semibold font-sans">{{citizenData.citizenStatus?'ALIVE':'DECEASED'}}</div>
          </div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-2 text-gray-600 text-nowrap">Health Insurance</div>
          <div class="col-span-6 text-lg flex">
            <div 
            :class="citizenData.healthInsuarance?' text-green-700':' text-red-700'"
            class="w-fit py-1 rounded-md font-semibold font-sans">{{citizenData.healthInsuarance? citizenData.healthInsuarance : 'Has No Insurance'}}</div>

            <v-btn :loading="isIssuing" @click="issueInsurance()" v-if="!citizenData.healthInsuarance" class=" ml-auto text-white" color="var(--nhif)" variant="flat">ISSUE INSURANCE</v-btn>
            <v-btn :loading="isIssuing" v-else @click="revokeInsurance()" class=" ml-auto text-white" color="red" variant="flat">REVOKE INSURANCE</v-btn>   
          </div>
        </div>
        
    </section>
    <div class="text-red-700" v-if=" citizenId && citizenData=='nothing' && !citizenData?.birthCertificateNo && !isLoading">
        CITIZEN DOES NOT EXIST
    </div>   

    <!-- <v-form class="flex flex-col gap-4 z-10">
        <v-text-field v-model="formData.fname" variant="outlined" label="Citizen Id" :color="props.themeColor"
            @focus="focused[0] = true" @blur="focused[0] = false">
        </v-text-field>
        <div class="flex flex-col gap-4">
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
                <v-date-input readonly :max="today" v-model="formData.dob" label="Date of birth" variant="outlined"></v-date-input>

                <v-radio-group readonly label="Gender" v-model="formData.gender" inline>
                <v-radio value="Male" label="Male"></v-radio>
                <v-radio value="Female" label="Female"></v-radio>
                </v-radio-group>
            </div>
        </div>
      <div class="py-4 w-full">
        <v-btn :loading="isLoading" @click="registerCitizen()" color="rgb(125, 73, 12)" width="100%">Add</v-btn>
      </div>
    </v-form> -->
  </div>
</template>

<script setup>
import { onMounted, ref,watch,computed, defineEmits } from 'vue'
import {useGatewayStore} from "@/stores/gateway.js"
import { confirmAlert } from '@/utils/notificationService'

const store = useGatewayStore()


const citizens = computed(()=>store.state.citizens)

const citizenData = ref(null)
const citizenId = ref(null)

watch(citizenId,()=>citizenData.value=null)

const today = new Date().toISOString().split('T')[0]
const focused = ref([])
const emit = defineEmits(['close'])
const isLoading = ref(false)
const isIssuing = ref(false)

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

const getCitizenData = async()=>{
  isLoading.value = true

  await store.getCitizens()

  citizenData.value = citizens.value.find(citizen=>{
   return  citizen[5]==citizenId.value
  })

  if(!citizenData.value) citizenData.value = 'nothing'

  isLoading.value = false

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

const issueInsurance = async()=>{
    isIssuing.value = true
   let randomInteger = Math.floor(Math.random() * 100000000)
   await store.issueInsurance(citizenData.value.birthCertificateNo,`BIMA-${randomInteger.toString()}`).then(()=>{
     emit('close')
   })
   isIssuing.value = false
   
}


const revokeInsurance = async()=>{
    isIssuing.value = true
    const res = await confirmAlert(`You are revoking the Health Insurance for ${citizenData.value.firstName} ${citizenData.value.lastName} \n citizen Id : ${citizenData.value.citizenId}`)
    if(res.isConfirmed)
    store.revokeInsurance(citizenData.value.healthInsuarance)

    else emit("close")
    isIssuing.value = false
}



</script>
