<template>
       <div :style="{ color: 'rgb(125, 73, 12)' }" class="text-2xl font-semibold pb-4">
        Fetch data
      </div>
      <div class="flex gap-16">
        <v-text-field
          color="rgb(125, 73, 12)"
          v-model="searchedId"
          variant="outlined"
          label="Citizen ID"
        >
          <template v-slot:append>
            <v-btn  :disabled="!searchedId" :loading="isLoading" @click="getCitizenData()" size="x-large" color="rgb(125, 73, 12)">
              <div class="lowercase text-md">Fetch</div>
            </v-btn>
          </template>
        </v-text-field>
      </div>

      <section v-if="citizenData?.birthCertificateNo" class="flex flex-col gap-4 py-4">
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Citizen Id</div>
          <div class="col-span-7 text-lg">{{citizenData.citizenId}}</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Birth Certificate No.</div>
          <div class="col-span-7 text-lg">{{citizenData.birthCertificateNo}}</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Name</div>
          <div class="col-span-7 text-lg">{{citizenData.firstName}}&nbsp;{{citizenData.middleName}}&nbsp;{{citizenData.lastName}}</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Date of Birth</div>
          <div class="col-span-7 text-lg">{{ new Date(citizenData.dateofBirth).toDateString() }}</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Life Status</div>
          <div class="col-span-7 text-lg">
            <div 
            :class="citizenData.citizenStatus?'!border-green-700 text-green-700':'!border-red-700 text-red-700'"
            class="w-fit px-4 py-1 border-2 rounded-md font-semibold font-sans">{{citizenData.citizenStatus?'ALIVE':'DECEASED'}}</div>
          </div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600 text-nowrap">Health Insurance</div>
          <div class="col-span-7 text-lg flex">
            <div 
            :class="citizenData.healthInsuarance?' text-[var(--nhif)]':' text-red-700'"
            class="w-fit py-1 rounded-md font-semibold font-sans">{{citizenData.healthInsuarance? citizenData.healthInsuarance : 'Has No Insurance'}}</div>

            <v-btn :loading="isIssuing" @click="issueInsurance()" v-if="!citizenData.healthInsuarance" class=" ml-auto text-white" color="var(--nhif)" variant="flat">ISSUE INSURANCE</v-btn>
            <v-btn :loading="isIssuing" v-else @click="revokeInsurance()" class=" ml-auto text-white" color="red" variant="flat">REVOKE INSURANCE</v-btn>   
          </div>
        </div>
      </section>
      <div class="text-red-700" v-if=" searchedId && citizenData=='nothing' && !citizenData?.birthCertificateNo && !isLoading">
        CITIZEN DOES NOT EXIST
      </div>   
</template>

<script setup>
import { ref,computed,watch } from 'vue'
import {useGatewayStore} from "@/stores/gateway.js"
import { confirmAlert } from '@/utils/notificationService'

const store = useGatewayStore()

const isIssuing = ref(false)
const searchedId = ref('')
const isLoading = ref(false)
const citizenData = ref(null)
const citizens = computed(()=>store.state.citizens)

watch(searchedId,()=>citizenData.value=null)

const getCitizenData = async()=>{
  isLoading.value = true

  await store.getCitizens()

  citizenData.value = citizens.value.find(citizen=>{
   return  citizen[5]==searchedId.value
  })

  if(!citizenData.value) citizenData.value = 'nothing'

  console.log('citizen Data ', citizenData.value);
  

  isLoading.value = false

}

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
    await store.revokeInsurance(citizenData.value.healthInsuarance)
    isIssuing.value = false
}
</script>