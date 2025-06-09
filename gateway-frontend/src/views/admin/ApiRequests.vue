<template>
  <section class="bg-[var(--sec)] h-full flex flex-col items-center gap-4 pb-20">
    <div class="flex justify-between w-full md:w-[80%] py-8 rounded">
      <div class="flex flex-col">
        <div class="text-2xl">Action Logs</div>
        <div class="text-gray-500 text-[13px]">Monitor and audit all gateway activity</div>
      </div>
    </div>

    <div class="flex flex-col w-full md:w-[80%] rounded gap-2">

      <div class="grid grid-cols-3 gap-8">
        <div class="flex flex-row gap-8 bg-gray-200 w-fit px-2 py-2 rounded h-fit">
          <div @click="switchInst('all')" :class="status.all ? 'bg-white px-1 rounded shadow' : ''"
            class="cursor-pointer transition-all duration-200 ease-in">
            All Requests
          </div>
          <div @click="switchInst('successful')" :class="status.successful ? 'bg-white px-1 rounded shadow' : ''"
            class="cursor-pointer transition-all duration-200 ease-in">
            Successful
          </div>
          <div @click="switchInst('failed')" :class="status.failed ? 'bg-white px-1 rounded shadow' : ''"
            class="cursor-pointer transition-all duration-200 ease-in">
            Failed
          </div>
          <div @click="switchInst('unauthorized')"
            :class="status.unauthorized ? 'bg-white px-1 rounded shadow' : ''"
            class="cursor-pointer transition-all duration-200 ease-in">
            Unauthorized
          </div>
        </div>
        <v-autocomplete cols="4" density="compact" label="All Institutions" :items="['NIDA', 'NHIF', 'RITA']"
          variant="outlined"></v-autocomplete>
        <!-- <v-select label="All Methods" :items="['GET', 'POST', 'PUT', 'DELETE']" variant="outlined"></v-select> -->
        <v-select label="Day(s)" :items="['Today', 'Past week', 'Past Month']" variant="outlined"></v-select>
      </div>
    </div>

    <v-table height="80%" fixed-header class="md:w-[80%] rounded border min-h-[300px] relative">
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
        <tr class="text-[15px] lg:text-lg" v-for="(item, index) in restructuredLogs" :key="index">
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
              <!-- <v-icon v-if="item.status == 'unauthorized'" variant="outlined" icon="mdi-exclamation"></v-icon> -->

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
import { computed, onMounted, ref } from 'vue'
import { getDate, getViewerContract } from '@/utils/contractService'
import Loader from '@/components/Loader.vue'
import {useGatewayStore} from "@/stores/gateway.js"

const store = useGatewayStore()
const isLoading = ref(false)
const logs = computed(()=>store.state.logs)
const restructuredLogs = ref([])
const institutions = computed(()=>store.state.institutions)

const getInstitutionName = (address)=>{
  if(address=='0x7cE5Dc33aF6aC085df443252d8a17AC1AC4E9a97') return 'admin'
  return institutions.value.find(inst=>inst.orgAddress==address)?.abbreviation
}

onMounted(async() => {

  isLoading.value = true
  await store.getLogs()

  if(institutions.value.length==0){
    await store.getInstitutions()
  }

  restructuredLogs.value = logs.value.map(log=>{
      return {...log,name:getInstitutionName(log.performedBy)}
  })

  isLoading.value = false
})

const status = ref({
  all: true,
  successful: false,
  failed: false,
  unauthorized: false,
})

const switchInst = (stat) => {
  (status.value.all = false),
  (status.value.successful = false),
  (status.value.failed = false),
  (status.value.unauthorized = false)

  if (stat == 'all') status.value.all = true
  if (stat == 'successful') status.value.successful = true
  if (stat == 'failed') status.value.failed = true
  if (stat == 'unauthorized') status.value.unauthorized = true
}


</script>
