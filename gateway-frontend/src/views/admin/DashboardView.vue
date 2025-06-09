<script setup>
import {
  Chart,
  Title,
  Tooltip,
  Legend,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  CategoryScale,
  LinearScale,
} from 'chart.js'

import { Bar } from 'vue-chartjs'
import { onMounted,computed,ref } from 'vue'
import {useGatewayStore} from "@/stores/gateway.js"
import Loader from "@/components/Loader.vue"
import { getDate } from '@/utils/contractService'

const store = useGatewayStore()

//PointElement,LineElement for line chart
//BarElement is necessary for bar chart
//ArcElement for doughnut
Chart.register(
  CategoryScale,
  LinearScale,
  BarElement,
  ArcElement,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
)

const data = {
  labels: ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'],
  datasets: [
    {
      label: 'Requests',
      data: [40, 20, 12, 30, 40, 20, 12],
      backgroundColor: ['rgb(24, 103, 192,0.9)'],
      borderColor: ['rgb(24, 103, 192)'],
      borderWidth: 1,
    },
  ],
}

const options = {
  responsive: true,
}
const isLoading = computed(()=>store.state.isLoading)
const institutions = computed(()=>store.state.institutions)
const citizens = computed(()=>store.state.citizens)
const logs = computed(()=>store.state.logs)


const getInstitutionName = (address)=>{
  if(address=='0x7cE5Dc33aF6aC085df443252d8a17AC1AC4E9a97') return 'admin'
  return institutions.value.find(inst=>inst.orgAddress==address).abbreviation
}

onMounted(async()=>{  
  
  if(institutions.value.length==0 || citizens.value.length==0 || logs.value.length==0){
    store.toggleLoading(true)

    await store.getCitizens()
    await store.getInstitutions()
    await store.getLogs()

    store.toggleLoading(false)
  }
})
</script>

<template>
  <section class="bg-[var(--sec)] h-full py-8">
    <div class="md:w-[70%] mx-auto flex flex-col gap-4 h-full">
      <div class="flex flex-col">
        <div class="text-2xl">Dashboard</div>
        <div class="text-gray-500 text-[13px]">Welcome back to The Gateway-Portal</div>
      </div>
      <div class="grid grid-cols-3 gap-2">
        <div class=" rounded bg-white grid grid-cols-4 border border-gray-600 px-6 py-6">
          <div class="col-span-3 flex flex-col gap-2">
            <div class="text-gray-500 text-md">Total Citizens</div>
            <div v-if="!isLoading" class="font-semibold text-2xl">{{citizens.length}}</div>
            <Loader v-else class=" w-[50%] flex items-center justify-center" :color="'stroke-blue-600'" />

            <Loader :color="'stroke-blue'"/>
          </div>
          <div class="col-span-1 flex justify-end">
            <div class="bg-[var(--sec)] w-8 h-8 rounded p-2 flex justify-center items-center">
              <v-icon
                variant="outlined"
                color="primary"
                icon="mdi-account-multiple-outline"
              ></v-icon>
            </div>
          </div>
        </div>
        <div class=" rounded bg-white grid grid-cols-4 border border-gray-600 px-6 py-6">
          <div class="col-span-3 flex flex-col gap-2">
            <div class="text-gray-500 text-md">Total Institutions</div>
            <div v-if="!isLoading" class="font-semibold text-2xl">{{institutions.length}}</div>
            <Loader v-else class=" w-[50%] flex items-center justify-center" :color="'stroke-blue-600'" />

          </div>
          <div class="col-span-1 flex justify-end">
            <div class="bg-[var(--sec)] w-8 h-8 rounded p-2 flex justify-center items-center">
              <v-icon variant="outlined" color="primary" icon="mdi-bank-outline"></v-icon>
            </div>
          </div>
        </div>
        <div class=" rounded bg-white grid grid-cols-4 border border-gray-600 px-6 py-6">
          <div class="col-span-3 flex flex-col gap-2">
            <div class="text-gray-500 text-md">Actions Called</div>
            <div v-if="!isLoading" class="font-semibold text-2xl">{{logs.length}}</div>
            <Loader v-else class=" w-[50%] flex items-center justify-center" :color="'stroke-blue-600'" />
          </div>
          <div class="col-span-1 flex justify-end">
            <div class="bg-[var(--sec)] w-8 h-8 rounded p-2 flex justify-center items-center">
              <v-icon variant="outlined" color="primary" icon="mdi-link-variant"></v-icon>
            </div>
          </div>
        </div>

      </div>
      <div class="grid grid-cols-5 gap-2">
        <div class="col-span-3 border border-gray-600 px-6 py-6 rounded bg-white max-h-fit">
          <div class="text-gray-900 text-lg">API Requests (Last 7 days)</div>
          <Bar :data="data" :options="options" />
        </div>
        <div class="col-span-2 border border-gray-600 px-6 py-6 rounded bg-white">
          <div class="text-gray-900 text-lg">Recent Activity</div>
          <Loader v-if="isLoading" class=" w-[50%] flex items-center justify-center my-4" :color="'stroke-blue-600'" />

          <div v-for="(log,index) in [...logs].reverse().slice(0, 3)" :key="index" class="grid grid-cols-6 min-w-fit my-4 border-b border-gray-400 py-2">
            <div class="col-span-1">
              <div
                class="bg-[var(--sec)] w-9 h-9 rounded-full p-2 flex justify-center items-center"
              >
                <v-icon icon="mdi-chevron-right"></v-icon>
              </div>
            </div>
            <div class="col-span-3">
              <div>{{log.action}}</div>
              <div class="col-span-2 text-gray-500 text-[13px]">By&nbsp;{{ getInstitutionName(log.performedBy)  }}</div>
            </div>
            <div class="col-span-2 text-gray-500 text-[13px]">{{getDate(log.timestamp)}}</div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
