<template>
  <v-overlay v-model="overlay" class="flex items-center justify-center">
    <AddInstitutionForm @close="reload()" />
  </v-overlay>
  <section class="bg-[var(--sec)] h-full flex flex-col items-center gap-4 pb-20">
    <div class="flex justify-between w-full md:w-[80%] py-8 rounded">
      <div class="flex flex-col">
        <div class="text-2xl">Institutions</div>
        <div class="text-gray-500 text-[13px]">Manage registered institutions and their access</div>
      </div>
      <v-btn @click="overlay = true" flat prepend-icon="mdi-bank-plus" color="primary">ADD Institution</v-btn>
    </div>

    <div class="flex flex-col w-full md:w-[80%] rounded gap-2">

      <v-text-field v-model="search" label="Search institutions" prepend-inner-icon="mdi-magnify" variant="outlined"></v-text-field>
    </div>

    <v-table height="80%" fixed-header class="md:w-[80%] rounded border min-h-[50vh] relative">
      <thead>
        <tr class="text-lg font-bold">
          <th class="text-left">Institution</th>
          <th class="text-left">Address</th>
          <th class="text-left">Type</th>
          <!-- <th class="text-left">Joined</th>
          <th class="text-left">Operators</th> -->
          <th class="text-left">Actions</th>
        </tr>
      </thead>
      <Loader class=" w-full absolute flex items-center justify-center" v-if="isLoading" :color="'stroke-blue-600'" />
      <tbody>
        <tr v-for="item in filteredInstitutions" :key="item.instutionName">
          <td>
            <div class="flex flex-row gap-2 items-center font-sans">
              <div
                class="bg-[var(--sec)] text-[var(--pri)] text-xl w-8 h-8 rounded p-2 flex justify-center items-center text-nowrap">
                {{ item.instutionName[0] }}
              </div>
              <div class="flex flex-col">
                <div class="whitespace-nowrap">{{ item.instutionName }}</div>
                <div class="text-gray-500 text-[13px]">{{ item.abbreviation }}</div>
              </div>
            </div>
          </td>
          <td>{{ item.orgAddress }}</td>
          <td>
            <div class="h-fit w-34 border px-3 py-1 text-center rounded-full text-[12px] font-semibold">
              {{ item.orgType }}
            </div>
          </td>

          <!-- <td>{{ item.joined }}</td> -->
          <!-- <td>{{ item.admins }}</td> -->
          <td class="flex">
            <v-btn variant="text" icon="mdi-pen" title="Edit"></v-btn>
            <v-btn color="red" @click="confirmAlert(`Are you sure you want to delete institution ${item.abbrev}?`)"
              variant="text" icon="mdi-delete" title="View"></v-btn>
          </td>
        </tr>
      </tbody>
    </v-table>
  </section>
</template>

<script setup>
import { computed, onMounted, ref, watch } from 'vue'
import AddInstitutionForm from './AddInstitutionForm.vue'
import Loader from '@/components/Loader.vue'
import {useGatewayStore} from "@/stores/gateway.js"

const isLoading = ref(false)
const store = useGatewayStore()
const overlay = ref(false)
const institutions = computed(()=>store.state.institutions)
const filteredInstitutions = ref([])

const search = ref('')

const reload = () => {
  overlay.value = false
  setTimeout(() => store.getInstitutions(), 3000)
}

const matchesSearch = (objectValue)=>{
  return objectValue.toLowerCase().includes(search.value.toLowerCase())
}

const filterInstitutions = ()=>{
  if(!search.value){
    filteredInstitutions.value = institutions.value
    return
  }

  filteredInstitutions.value = institutions.value.filter(
    inst => matchesSearch(inst.instutionName) || matchesSearch(inst.abbreviation) || matchesSearch(inst.orgAddress) || matchesSearch(inst.orgType)
  )
}

watch(search,()=>filterInstitutions())

onMounted(async () => {
  isLoading.value = true
  await store.getInstitutions()
  isLoading.value = false

  filterInstitutions()
})
</script>
