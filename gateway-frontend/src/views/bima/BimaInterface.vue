<template>
  <div class="flex flex-col items-center">
    <nav :style="{ backgroundColor: 'rgb(125, 73, 12)' }" class="py-4 text-white w-full">
      <div class="w-[90%] mx-auto text-3xl flex justify-between">
        <div>NHIF</div>
        <v-btn 
        class=""
          @click="logout();router.push('/');"
          color="white"
          icon="mdi-logout"
          title="Logout"
          variant="outlined"
        ></v-btn>
      </div>
    </nav>
    <div class="md:w-[90%] py-8">
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
      </section>
      <div class="text-red-700" v-if=" searchedId && citizenData=='nothing' && !citizenData?.birthCertificateNo && !isLoading">
        CITIZEN DOES NOT EXIST
      </div>
    </div>
  </div>
</template>

<script setup>

import { ref,computed,watch } from 'vue'
import { useRouter } from 'vue-router'
import {logout} from "@/utils/contractService.js"
import {useGatewayStore} from "@/stores/gateway.js"

const store = useGatewayStore()

const router = useRouter()
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

</script>
