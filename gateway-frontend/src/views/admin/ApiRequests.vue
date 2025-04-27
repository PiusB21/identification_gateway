<template>
  <section class="bg-[var(--sec)] h-full flex flex-col items-center gap-4 pb-20">
    <div class="flex justify-between w-full md:w-[80%] py-8 rounded">
      <div class="flex flex-col">
        <div class="text-2xl">API Requests</div>
        <div class="text-gray-500 text-[13px]">Monitor and audit API request activity</div>
      </div>
    </div>

    <div class="flex flex-col w-full md:w-[80%] rounded gap-2">
      <div class="flex flex-row gap-8 bg-gray-200 w-fit px-2 py-2 rounded">
        <div
          @click="switchInst('all')"
          :class="instFilter.all ? 'bg-white px-1 rounded shadow' : ''"
          class="cursor-pointer transition-all duration-200 ease-in"
        >
          All Requests
        </div>
        <div
          @click="switchInst('successful')"
          :class="instFilter.successful ? 'bg-white px-1 rounded shadow' : ''"
          class="cursor-pointer transition-all duration-200 ease-in"
        >
          Successful
        </div>
        <div
          @click="switchInst('failed')"
          :class="instFilter.failed ? 'bg-white px-1 rounded shadow' : ''"
          class="cursor-pointer transition-all duration-200 ease-in"
        >
          Failed
        </div>
        <div
          @click="switchInst('unauthorized')"
          :class="instFilter.unauthorized ? 'bg-white px-1 rounded shadow' : ''"
          class="cursor-pointer transition-all duration-200 ease-in"
        >
          Unauthorized
        </div>
      </div>
      <div class="grid grid-cols-3 gap-8">
        <v-autocomplete
          cols="4"
          density="compact"
          label="All Institutions"
          :items="['NIDA', 'NHIF', 'RITA']"
          variant="outlined"
        ></v-autocomplete>
        <v-select
          label="All Methods"
          :items="['GET', 'POST', 'PUT', 'DELETE']"
          variant="outlined"
        ></v-select>
        <v-select
          label="Day(s)"
          :items="['Today', 'Past week', 'Past Month']"
          variant="outlined"
        ></v-select>
      </div>
    </div>

    <v-table height="80%" fixed-header class="md:w-[80%] rounded border min-h-[300px]">
      <thead>
        <tr class="text-lg font-bold">
          <th class="text-left">Institution</th>
          <th class="text-left">Endpoint</th>
          <th class="text-left">Method</th>
          <th class="text-left">Status</th>
          <th class="text-left">Time</th>
        </tr>
      </thead>
      <tbody>
        <tr class="text-[15px] lg:text-lg" v-for="item in desserts" :key="item.name">
          <td>
            <div class="flex flex-row gap-2 items-center font-sans">
              <div class="">{{ item.name }}</div>
              <div class="text-gray-500 text-[13px]">{{ item.abbrev }}</div>
            </div>
          </td>
          <td>
            <div class="text-[12px] text-gray-700 font-semibold">
              {{ item.endpoint }}
            </div>
          </td>
          <td>
            <div
              :class="[
                item.method == 'get' ? 'bg-blue-50 text-blue-700 border-blue-700' : '',
                item.method == 'post' ? 'bg-green-50 text-green-700 border-green-700' : '',
                item.method == 'put' ? 'bg-yellow-50 text-yellow-700 border-yellow-700' : '',
                item.method == 'delete' ? 'bg-red-50 text-red-700 border-red-700' : '',
              ]"
              class="border rounded-full text-center w-[80px] px-2 font-medium uppercase text-[15px]"
            >
              {{ item.method }}
            </div>
          </td>
          <td>
            <div
              :class="[
                item.status == 'success' ? 'text-green-700' : '',
                item.status == 'failed' ? 'text-red-700' : '',
                item.status == 'unauthorized' ? 'text-yellow-700' : '',
              ]"
            >
              <v-icon v-if="item.status == 'success'" variant="outlined" icon="mdi-check"></v-icon>
              <v-icon v-if="item.status == 'failed'" variant="outlined" icon="mdi-close"></v-icon>
              <v-icon
                v-if="item.status == 'unauthorized'"
                variant="outlined"
                icon="mdi-exclamation"
              ></v-icon>

              {{ item.status }}
            </div>
          </td>

          <td>{{ item.time }}</td>
        </tr>
      </tbody>
    </v-table>
  </section>
</template>

<script setup>
import { ref } from 'vue'

const instFilter = ref({
  all: true,
  successful: false,
  failed: false,
  unauthorized: false,
})

const switchInst = (inst) => {
  ;(instFilter.value.all = false),
    (instFilter.value.successful = false),
    (instFilter.value.failed = false),
    (instFilter.value.unauthorized = false)

  if (inst == 'all') instFilter.value.all = true
  if (inst == 'successful') instFilter.value.successful = true
  if (inst == 'failed') instFilter.value.failed = true
  if (inst == 'unauthorized') instFilter.value.unauthorized = true
}

const desserts = [
  {
    name: 'National Identification Agency',
    abbrev: 'NIDA',
    endpoint: '/api/citizen/{id}/basic',
    method: 'delete',
    status: 'success',
    time: '02/08/2022, 12:03',
  },
  {
    name: 'Registration Insolvency and Trusteeship Agency',
    abbrev: 'RITA',
    endpoint: '/api/citizen/{id}/birth_records',
    method: 'post',
    status: 'failed',
    time: '02/08/2022, 16:40',
  },
  {
    name: 'National Health Insurance Fund',
    abbrev: 'NHIF',
    endpoint: '/api/citizen/{id}/health',
    method: 'get',
    status: 'success',
    time: '02/08/2022, 15:30',
  },
  {
    name: 'University of Dodoma',
    abbrev: 'UDOM',
    endpoint: '/api/citizen/academic',
    method: 'post',
    status: 'success',
    time: '02/08/2022, 08:11',
  },
  {
    name: 'Vodacom Company',
    abbrev: 'Vodacom',
    endpoint: '/api/citizen/{id}/death_records',
    method: 'put',
    status: 'unauthorized',
    time: '02/08/2022, 06:40',
  },
]
</script>
