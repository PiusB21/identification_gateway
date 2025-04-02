<template>
  <section class="bg-[var(--sec)] h-full flex flex-col items-center gap-4 pb-20 overflow-y-auto">
    <div class="flex justify-between w-full md:w-[75%] md:py-8 rounded">
      <div class="flex flex-col px-1">
        <div class="text-2xl">API Keys</div>
        <div class="text-gray-500 text-[13px]">Manage institution keys and permissions</div>
      </div>
      <v-btn flat prepend-icon="mdi-key" color="primary">create new key</v-btn>
    </div>

    <div class="flex flex-col w-full md:w-[75%] rounded gap-2">
      <div class="grid grid-cols-3 sm:gap-8 max-sm:grid-cols-1 mx-2">
        <v-autocomplete
          density="compact"
          cols="4"
          label="All Institutions"
          :items="['NIDA', 'NHIF', 'RITA']"
          variant="outlined"
        ></v-autocomplete>
        <v-select
          density="compact"
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
      <div class="flex flex-wrap gap-2 items-center max-md:justify-center">
        <div
          v-for="i in 10"
          class="border border-gray-400 rounded px-4 py-4 bg-white flex flex-col w-[24%] min-w-fit max-sm:w-[90%]"
        >
          <div class="flex justify-between">
            <div class="flex items-center gap-2">
              <v-icon
                class="-rotate-45"
                variant="outlined"
                color="primary"
                icon="mdi-key-outline"
              ></v-icon>
              <div class="text-lg">NIDA Main API key</div>
            </div>
            <div
              :class="
                true
                  ? 'bg-green-50 text-green-700 border-green-700'
                  : 'bg-yellow-50 text-yellow-700 border-yellow-700'
              "
              class="border rounded text-center h-fit text-sm px-1"
            >
              Active
            </div>
          </div>

          <div class="bg-gray-100 flex justify-between px-1 py-2 my-1">
            <div>dsfasf**********fgfsd</div>
            <v-btn density="compact" class="elevation-0" icon="mdi-content-copy"></v-btn>
          </div>

          <div class="grid grid-cols-2 pb-4 mb-2 border-b">
            <div class="text-gray-500 text-[14px] flex flex-col gap-2">
              <h4>Permissions</h4>
              <div class="flex flex-col gap-1">
                <div class="px-1 bg-[var(--sec)] text-[var(--pri)] w-fit">read:basic</div>
                <div class="px-1 bg-[var(--sec)] text-[var(--pri)] w-fit">read:address</div>
                <div class="px-1 bg-[var(--sec)] text-[var(--pri)] w-fit">write:basic</div>
                <div class="px-1 bg-[var(--sec)] text-[var(--pri)] w-fit">write:address</div>
              </div>
            </div>
            <div class="text-gray-500 text-[14px] flex flex-col gap-2">
              <h4>Last Used</h4>
              <div class="text-black">
                15/07/2025,<br />
                02:30
              </div>
            </div>
          </div>
          <div class="grid grid-cols-2">
            <div class="text-gray-500 text-[14px] flex flex-col gap-2">
              <h4>Created</h4>
              <div class="text-black">
                15/07/2025,<br />
                02:30
              </div>
            </div>
            <div class="text-gray-500 text-[14px] flex flex-col gap-2">
              <h4>Expires</h4>
              <div class="text-black">
                15/07/2025,<br />
                02:30
              </div>
            </div>
          </div>
          <div class="flex justify-between my-4 gap-4">
            <v-btn size="small" color="grey-lighten-4" class="elevation-0 border"
              >Manage Permissions</v-btn
            >
            <v-btn size="small" color="red-darken-1" class="elevation-0">Revoke</v-btn>
          </div>
        </div>
      </div>
    </div>
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

{
  /*  <th class="text-left">Endpoint</th>
            <th class="text-left">Method</th>
            <th class="text-left">Status</th>
            <th class="text-left">Time</th> */
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
