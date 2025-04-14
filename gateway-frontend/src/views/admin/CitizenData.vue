<template>
  <v-overlay v-model="overlay" class="flex items-center justify-center">
    <AddCitizenForm :themeColor="props.themeColor" />
  </v-overlay>

  <section
    :class="route.path == '/citizen-data' ? 'bg-[var(--sec)]' : ''"
    class="h-full flex flex-col items-center gap-4 pb-20"
  >
    <div class="flex justify-between w-full md:w-[70%] py-8 rounded">
      <div class="flex flex-col">
        <div class="text-2xl">Citizen Data</div>
        <div class="text-gray-500 text-[13px]">Search and manage citizen information</div>
      </div>
      <v-btn
        @click="overlay = true"
        flat
        :color="props.themeColor || 'primary'"
        prepend-icon="mdi-account-plus"
      >
        ADD CITIZEN
      </v-btn>
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
            {{ item.national_id }}
          </td>
          <td>
            {{ item.name }}
          </td>
          <td>
            {{ item.dob }}
          </td>
          <td>
            {{ item.gender }}
          </td>
          <td>{{ item.location }}</td>
          <td>{{ item.last_updated }}</td>
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
import { useRoute } from 'vue-router'
import AddCitizenForm from './AddCitizenForm.vue'

const overlay = ref(false)

const route = useRoute()

const props = defineProps(['themeColor'])

const desserts = [
  {
    national_id: 'TZ-1232-12315-2322-001',
    name: 'Pius Baraka',
    dob: '21/08/2001',
    gender: 'male',
    location: 'Arusha,Arusha',
    last_updated: '02/08/2022',
  },
  {
    national_id: 'TZ-9876-54321-6789-002',
    name: 'Amina Juma',
    dob: '14/05/1995',
    gender: 'female',
    location: 'Dar es Salaam, Kinondoni',
    last_updated: '10/03/2023',
  },
  {
    national_id: 'TZ-4567-89012-3456-003',
    name: 'John Mwenda',
    dob: '30/11/1988',
    gender: 'male',
    location: 'Dodoma, Dodoma',
    last_updated: '15/09/2021',
  },
  {
    national_id: 'TZ-2345-67890-1234-004',
    name: 'Fatma Hassan',
    dob: '07/02/1999',
    gender: 'female',
    location: 'Mwanza, Ilemela',
    last_updated: '05/07/2022',
  },
  {
    national_id: 'TZ-6789-01234-5678-005',
    name: 'David Kimaro',
    dob: '12/06/1984',
    gender: 'male',
    location: 'Mbeya, Mbeya City',
    last_updated: '20/01/2024',
  },
]
</script>
