<template>
  <section class="bg-[var(--sec)] h-full flex flex-col items-center gap-4 pb-20">
    <div class="flex justify-between w-full md:w-[90%] py-8 rounded">
      <div class="flex flex-col">
        <div class="text-2xl">Action Logs</div>
        <div class="text-gray-500 text-[13px]">Monitor and audit all gateway activity</div>
      </div>
    </div>

    <div class="flex flex-col w-full md:w-[90%] rounded gap-2">
      <div class="grid grid-cols-3 gap-8">
        <v-select  density="compact" v-model="search" label="Institutions" :items="['All','NIDA', 'NHIF', 'RITA']"
        variant="outlined"></v-select>
      </div>
    </div>

    <v-table height="80%" fixed-header class="md:w-[90%] rounded border min-h-[300px] relative">
      <thead>
        <tr class="text-lg font-bold">
          <th class="text-left">Institution</th>
          <th class="text-left">Action</th>
          <!-- <th class="text-left">Method</th> -->
          <th class="text-left">Status</th>
          <th class="text-left">Time</th>
        </tr>
      </thead>
      <Loader class=" w-full absolute flex items-center justify-center" v-if="isLoading" :color="'stroke-blue-600'" />
      <tbody>
        <tr class="text-[15px] lg:text-lg" v-for="(item, index) in filteredLogs" :key="index">
          <td>
            <div class="flex flex-col gap-[0.5] text-[13px] justify-center font-sans">
              <div class="">{{ item.name }}</div>
              <div class="text-gray-500 text-[13px]">{{ item.performedBy }}</div>
            </div>
          </td>
          <td>
            <div class="text-[12px] text-gray-700 font-semibold">
              {{ item.action }}
            </div>
          </td>
          <td>
            <div :class="[
              item.status ? 'text-green-700' : 'text-red-700',
            ]">
              <v-icon v-if="item.status" variant="outlined" icon="mdi-check"></v-icon>
              <v-icon v-else variant="outlined" icon="mdi-close"></v-icon>
              {{ item.status ? 'Successful' : 'Failed' }}
            </div>
          </td>

          <td>{{ getDate(item.timestamp) }}</td>
        </tr>
      </tbody>
    </v-table>
  </section>
</template>

<script setup>
import { computed, onMounted, ref, watch } from 'vue'
import { getDate, getViewerContract } from '@/utils/contractService'
import Loader from '@/components/Loader.vue'
import {useGatewayStore} from "@/stores/gateway.js"

const store = useGatewayStore()
const isLoading = ref(false)
const logs = computed(()=>store.state.logs)
const restructuredLogs = ref([])
const institutions = computed(()=>store.state.institutions)
const filteredLogs = ref([])
const search = ref('All')

const getInstitutionName = (address)=>{
  if(address=='0x7cE5Dc33aF6aC085df443252d8a17AC1AC4E9a97') return 'admin'
  return institutions.value.find(inst=>inst.orgAddress==address)?.abbreviation
}



watch(search,()=>{
  if(search.value=='All'){
    filteredLogs.value = restructuredLogs.value
  }
  filteredLogs.value = restructuredLogs.value.filter(log=>{
    return log.name.toLowerCase()==search.value.toLowerCase()
  })
})


onMounted(async() => {

  isLoading.value = true
  await store.getLogs()

  if(institutions.value.length==0){
    await store.getInstitutions()
  }

  restructuredLogs.value = logs.value.map(log=>{
      return {...log,name:getInstitutionName(log.performedBy)}
  })

  filteredLogs.value = restructuredLogs.value

  isLoading.value = false
})

const status = ref({
  all: true,
  successful: false,
  failed: false,
  unauthorized: false,
})

</script>
