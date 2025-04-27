<template>
  <v-overlay v-model="overlay" class="flex items-center justify-center">
    <AddCitizenForm :editedCitizen="editedCitizen" :themeColor="props.themeColor" />
  </v-overlay>

  <section
    :class="route.path == '/citizen-data' ? 'bg-[var(--sec)]' : ''"
    class="h-full flex flex-col items-center gap-4 pb-20"
  >
    <div class="flex justify-between w-full md:w-[80%] py-8 rounded">
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

    <div class="flex flex-col w-full md:w-[80%] rounded gap-2">
      <v-text-field
        label="Search by name, ID number, or other details..."
        prepend-inner-icon="mdi-magnify"
        variant="outlined"
      ></v-text-field>
    </div>

    <v-table height="80%" fixed-header class="md:w-[80%] rounded border min-h-[300px]">
      <thead>
        <tr
          class="text-lg font-bold"
          :class="props.themeColor ? `text-[${props.themeColor}]` : 'text-primary'"
        >
          <th class="text-left">National ID</th>
          <th class="text-left">Name</th>
          <th class="text-left">Date of Birth</th>
          <th class="text-left">Gender</th>
          <th class="text-left">Location</th>
          <th class="text-left">Life Status</th>
          <th class="text-left">Last Updated</th>
          <th class="text-left">Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr class="text-[15px] lg:text-lg" v-for="item in citizenData" :key="item.name">
          <td class="font-semibold text-gray-700">
            {{ item.national_id }}
          </td>
          <td>{{ item.fname }}&nbsp;{{ item.lname }}</td>
          <td>
            {{ item.dob }}
          </td>
          <td>
            {{ item.gender }}
          </td>
          <td>{{ item.district }},&nbsp;{{ item.region }}</td>
          <td class="tracking-wide">
            <div v-if="item.alive" class="flex gap-2">
              <v-icon class="bg-green-700" icon="mdi-check" color="white"></v-icon>
              <div class="text-green-700">ALIVE</div>
            </div>
            <div v-else class="flex gap-2">
              <v-icon class="bg-red-700" icon="mdi-close" color="white"></v-icon>
              <div class="text-red-700">DECEASED</div>
            </div>
          </td>
          <td>{{ item.last_updated }}</td>
          <td class="flex">
            <v-btn
              @click="editCitizen(item)"
              :color="props.themeColor || 'primary'"
              variant="text"
              icon="mdi-pen"
              title="Edit"
            ></v-btn>

            <v-btn
              v-if="item.alive && route.path == '/rita-interface'"
              @click="certifyDeath(item)"
              :color="props.themeColor || 'red'"
              variant="text"
              icon="mdi-certificate-outline"
              title="Issue Death Certificate"
            ></v-btn>
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
import { confirmAlert } from '@/utils/notificationService'

const overlay = ref(false)

const route = useRoute()

const props = defineProps(['themeColor'])

const editedCitizen = ref(null)

const editCitizen = (citizen) => {
  console.log(citizen)

  editedCitizen.value = citizen
  overlay.value = true
}

const certifyDeath = async (person) => {
  const response = await confirmAlert(
    `You are issuing a death certificate to
        ${person.fname} ${person.lname}
        ${person.national_id}`,
  )
  if (response.isConfirmed) {
    const indexOfDeceased = citizenData.value.findIndex(
      (item) => item.national_id == person.national_id,
    )
    citizenData.value[indexOfDeceased].alive = false
  }
}

const citizenData = ref([
  {
    fname: 'Pius',
    lname: 'Baraka',
    national_id: 'TZ-1232-12315-2322-001',
    dob: '21/08/2001',
    gender: 'male',
    region: 'Arusha',
    district: 'Arusha',
    alive: true,
    last_updated: '02/08/2022',
  },
  {
    fname: 'Amina',
    lname: 'Juma',
    national_id: 'TZ-9876-54321-6789-002',
    dob: '14/05/1995',
    gender: 'female',
    region: 'Dar es Salaam',
    district: 'Kinondoni',
    alive: true,
    last_updated: '10/03/2023',
  },
  {
    fname: 'John',
    lname: 'Mwenda',
    national_id: 'TZ-4567-89012-3456-003',
    dob: '30/11/1988',
    gender: 'male',
    region: 'Dodoma',
    district: 'Dodoma',
    alive: false,
    last_updated: '15/09/2021',
  },
  {
    fname: 'Fatma',
    lname: 'Hassan',
    national_id: 'TZ-2345-67890-1234-004',
    dob: '07/02/1999',
    gender: 'female',
    region: 'Mwanza',
    district: 'Ilemela',
    alive: true,
    last_updated: '05/07/2022',
  },
  {
    fname: 'David',
    lname: 'Kimaro',
    national_id: 'TZ-6789-01234-5678-005',
    dob: '12/06/1984',
    gender: 'male',
    region: 'Mbeya',
    district: 'Mbeya City',
    alive: false,
    last_updated: '20/01/2024',
  },
])
</script>
