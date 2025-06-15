<template>
  <v-overlay v-model="add_overlay" class="flex items-center justify-center">
    <AddCitizenForm @close="add_overlay = false" :editedCitizen="editedCitizen" :themeColor="props.themeColor" />
  </v-overlay>
  <v-overlay v-model="id_overlay" class="flex items-center justify-center">
    <IssueCitizenId @close="id_overlay = false" :editedCitizen="editedCitizen" :themeColor="props.themeColor" />
  </v-overlay>  
  <v-overlay v-model="issue_overlay" class="flex items-center justify-center">
    <IssueDeathCertificate @close="issue_overlay = false" :editedCitizen="editedCitizen" :themeColor="props.themeColor" />
  </v-overlay>
  <section :class="route.path == '/citizen-data' ? 'bg-[var(--sec)]' : ''"
    class="h-full flex flex-col items-center gap-4 pb-20">
    <div class="flex justify-between w-full py-8 rounded">
      <div class="flex flex-col">
        <div class="text-2xl">Insurance Members</div>
        <div class="text-gray-500 text-[13px]">Search and manage insurance members</div>
      </div>
      <v-btn  @click="editedCitizen=null;add_overlay = true" flat color="rgb(125, 73, 12)" prepend-icon="mdi-account-plus">
        ADD MEMBER
      </v-btn>
    </div>

    <div class="flex flex-col w-full rounded gap-2">
      <v-text-field v-model="search" label="Search by name, ID number, or other details..." prepend-inner-icon="mdi-magnify"
        variant="outlined"></v-text-field>
    </div>

    <v-table height="80%" fixed-header class="w-full rounded border min-h-[300px]">
      <thead>
        <tr class="text-lg font-bold text-[var(--nhif)]">
          <th class="text-left">National ID</th>
          <th v-if="getState('role')=='rita'" class="text-left">Birth Cert Id</th>
          <th class="text-left">Insurance No</th>
          <th class="text-left">Name</th>
          <th class="text-left text-nowrap">Date of Birth</th>
          <th class="text-left">Gender</th>
          <th class="text-left">Life Status</th>
          <th v-if="getState('role')=='rita' || getState('role')=='nida'" class="text-left">Actions</th>
        </tr>
      </thead>
      <Loader class=" w-full absolute flex items-center justify-center" v-if="isLoading" :color="'stroke-[var(--nhif)]'" />
      <tbody>
        <tr class="text-[15px] lg:text-lg" v-for="item in filteredCitizens" :key="item.citizenId">
          <td class="font-semibold text-gray-700">
            {{ item.citizenId || '-' }}
          </td>
          <td  v-if="getState('role')=='rita'" class="font-semibold text-gray-700">
            TZ-{{ item.birthCertificateNo || '-' }}
          </td>
          <td>{{ item.healthInsuarance }}</td>

          <td>{{ item.firstName }}&nbsp;{{ item.lastName }}</td>
          <td>
            {{ formatDate(item.dateofBirth) }}
          </td>
          <td>
            {{ item.gender }}
          </td>
          <td class="tracking-wide">
            <div v-if="item.citizenStatus" class="flex gap-2">
              <v-icon class="bg-green-700" icon="mdi-check" color="white"></v-icon>
              <div class="text-green-700">ALIVE</div>
            </div>
            <div v-else class="flex gap-2">
              <v-icon class="bg-red-700" icon="mdi-close" color="white"></v-icon>
              <div class="text-red-700">DECEASED</div>
            </div>
          </td>
          <td v-if="getState('role')=='rita' || getState('role')=='nida'" class="flex">

            <v-btn v-if="getState('role')=='nida'" @click="issueCitizenId(item)" :color="props.themeColor || 'primary'" variant="text" icon="mdi-certificate-outline"
              title="Issue Citizen Id"></v-btn>

            <v-btn v-if="item.citizenStatus && route.path == '/rita-interface'" @click="certifyDeath(item)"
              :color="'red'" variant="text" icon="mdi-certificate-outline"
              title="Issue Death Certificate"></v-btn>
          </td>
        </tr>
      </tbody>
    </v-table>
  </section>
</template>

<script setup>
import { onMounted, ref,computed,watch } from 'vue'
import { useRoute } from 'vue-router'
import AddCitizenForm from './AddCitizenToInsurance.vue'
import { confirmAlert } from '@/utils/notificationService'
import { getViewerContract,getState } from '@/utils/contractService'
import Loader from '@/components/Loader.vue'
import {useGatewayStore} from "@/stores/gateway.js"
import IssueDeathCertificate from "../rita/IssueDeathCertificate.vue"
import IssueCitizenId from '../nida/IssueCitizenId.vue'

const store = useGatewayStore()
const isLoading = ref(false)
const add_overlay = ref(false)
const issue_overlay = ref(false)
const id_overlay = ref(false)
const search = ref('')

const citizens = computed(()=>store.state.citizens.filter(citizen=>citizen.healthInsuarance)) 

const filteredCitizens = ref([])

const route = useRoute()

const props = defineProps(['themeColor'])

const editedCitizen = ref(null)

const editCitizen = (citizen) => {
  editedCitizen.value = citizen
  add_overlay.value = true
}

const issueCitizenId = (citizen)=>{
    editedCitizen.value = citizen
    id_overlay.value = true
}

const certifyDeath = (citizen)=>{
  editedCitizen.value = citizen
  issue_overlay.value = true
}

const matchesSearch = (objectValue)=>{
  return objectValue.toLowerCase().includes(search.value.toLowerCase())
}

const filterCitizens = ()=>{
  if(!search.value){
    filteredCitizens.value = citizens.value
    return
  }

  filteredCitizens.value = citizens.value.filter(
    citizen => matchesSearch(citizen.citizenId) || 
    matchesSearch(citizen.firstName) || matchesSearch(citizen.lastName)|| matchesSearch(citizen.birthCertificateNo)
  )
}

watch(search,()=>filterCitizens())

onMounted(async () => {
  isLoading.value = true
  await store.getCitizens()
  filterCitizens()
  isLoading.value = false
})


const formatDate = (dateString) => {
  const date = new Date(dateString);
  const formatted = date.toDateString().split(' ').slice(1).join(' ');
  return formatted
}

</script>
