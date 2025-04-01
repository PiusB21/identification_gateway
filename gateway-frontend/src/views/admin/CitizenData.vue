<template>
  <section class="bg-[var(--sec)] h-full flex flex-col items-center gap-4 pb-20">
    <div class="flex justify-between w-full md:w-[70%] py-8 rounded">
      <div class="flex flex-col">
        <div class="text-2xl">Citizen Data</div>
        <div class="text-gray-500 text-[13px]">Search and manage citizen information</div>
      </div>
      <v-btn flat color="primary">REGISTER</v-btn>
    </div>

    <div class="flex flex-col w-full md:w-[70%] rounded gap-2">
      <v-text-field
        label="Search by name, ID number, or other details..."
        prepend-inner-icon="mdi-magnify"
        variant="outlined"
      ></v-text-field>
    </div>

    <v-table height="80%" fixed-header class="md:w-[70%] rounded border min-h-[300px]">
      <thead>
        <tr class="text-lg font-bold">
          <th class="text-left">National ID</th>
          <th class="text-left">Name</th>
          <th class="text-left">Date of Birth</th>
          <th class="text-left">Gender</th>
          <th class="text-left">Location</th>
          <th class="text-left">Last Updated</th>
          <th class="text-left">Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in desserts" :key="item.name">
          <td>
            <div class="flex flex-row gap-2 items-center font-sans">
              <div
                class="bg-[var(--sec)] text-[var(--pri)] text-xl w-8 h-8 rounded p-2 flex justify-center items-center"
              >
                {{ item.name[0] }}
              </div>
              <div class="flex flex-col">
                <div class="">{{ item.name }}</div>
                <div class="text-gray-500 text-[13px]">{{ item.abbrev }}</div>
              </div>
            </div>
          </td>
          <td>
            <div
              class="h-fit w-34 border px-3 py-1 text-center rounded-full text-[12px] font-semibold"
            >
              {{ item.type }}
            </div>
          </td>
          <td>
            <div :class="item.api_access == 'enabled' ? 'text-green-700' : 'text-red-700'">
              <v-icon
                v-if="item.api_access == 'enabled'"
                variant="outlined"
                icon="mdi-check"
              ></v-icon>
              <v-icon v-else variant="outlined" icon="mdi-close"></v-icon>

              {{ item.api_access }}
            </div>
          </td>
          <td>
            <div
              :class="
                item.status == 'verified'
                  ? 'bg-green-50 text-green-700 border-green-700'
                  : 'bg-yellow-50 text-yellow-700 border-yellow-700'
              "
              class="border rounded-full text-center"
            >
              {{ item.status }}
            </div>
          </td>
          <td>{{ item.joined }}</td>
          <td>{{ item.admins }}</td>
          <td>
            <v-btn dense variant="outlined">Edit</v-btn>
            <v-btn>View</v-btn>
          </td>
        </tr>
      </tbody>
    </v-table>
  </section>
</template>

<script setup>
import { ref } from 'vue'

{
  /* <th class="text-left">National ID</th>
          <th class="text-left">Name</th>
          <th class="text-left">Date of Birth</th>
          <th class="text-left">Gender</th>
          <th class="text-left">Location</th>
          <th class="text-left">Last Updated</th> */
}

const desserts = [
  {
    name: 'National Identification Agency',
    abbrev: 'NIDA',
    type: 'Government',
    api_access: 'enabled', //enabled,disabled
    status: 'verified', //pending,verified,
    joined: '02/08/2022',
    admins: 1,
  },
  {
    name: 'Registration Insolvency and Trusteeship Agency',
    abbrev: 'RITA',
    type: 'Government',
    api_access: 'enabled',
    status: 'verified',
    joined: '03/03/2020',
    admins: 1,
  },
  {
    name: 'National Health Insurance Fund',
    abbrev: 'NHIF',
    type: 'Healthcare',
    api_access: 'enabled',
    status: 'verified',
    joined: '21/12/2010',
    admins: 1,
  },
  {
    name: 'University of Dodoma',
    abbrev: 'UDOM',
    type: 'Academic',
    api_access: 'disabled',
    status: 'verified',
    joined: '12/08/2002',
    admins: 1,
  },
]
</script>
