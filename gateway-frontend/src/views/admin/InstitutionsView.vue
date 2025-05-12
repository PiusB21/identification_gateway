<template>
  <v-overlay v-model="overlay" class="flex items-center justify-center">
    <AddInstitutionForm @close="overlay = false" />
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
      <div class="flex flex-row gap-8 bg-gray-200 w-fit px-2 py-2 rounded">
        <div @click="switchInst('all')" :class="instFilter.all ? 'bg-white px-1 rounded shadow' : ''"
          class="cursor-pointer transition-all duration-200 ease-in">
          All institutions
        </div>
        <div @click="switchInst('gov')" :class="instFilter.gov ? 'bg-white px-1 rounded shadow' : ''"
          class="cursor-pointer transition-all duration-200 ease-in">
          Government
        </div>
        <div @click="switchInst('health')" :class="instFilter.health ? 'bg-white px-1 rounded shadow' : ''"
          class="cursor-pointer transition-all duration-200 ease-in">
          Healthcare
        </div>
        <div @click="switchInst('academic')" :class="instFilter.academic ? 'bg-white px-1 rounded shadow' : ''"
          class="cursor-pointer transition-all duration-200 ease-in">
          Academic
        </div>
        <div @click="switchInst('private')" :class="instFilter.private ? 'bg-white px-1 rounded shadow' : ''"
          class="cursor-pointer transition-all duration-200 ease-in">
          Mobile Networks
        </div>
      </div>
      <v-text-field label="Search institutions" prepend-inner-icon="mdi-magnify" variant="outlined"></v-text-field>
    </div>

    <v-table height="80%" fixed-header class="md:w-[80%] rounded border min-h-[50vh]">
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
      <tbody>
        <tr v-for="item in institutions" :key="item.institutionName">
          <td>
            <div class="flex flex-row gap-2 items-center font-sans">
              <div
                class="bg-[var(--sec)] text-[var(--pri)] text-xl w-8 h-8 rounded p-2 flex justify-center items-center text-nowrap">
                {{ item.institutionName[0] }}
              </div>
              <div class="flex flex-col">
                <div class="whitespace-nowrap">{{ item.institutionName }}</div>
                <div class="text-gray-500 text-[13px]">{{ item.abbreviation }}</div>
              </div>
            </div>
          </td>
          <td>{{ item.institutionAdress }}</td>
          <td>
            <div class="h-fit w-34 border px-3 py-1 text-center rounded-full text-[12px] font-semibold">
              {{ item.institutionType }}
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
import { onMounted, ref } from 'vue'
import AddInstitutionForm from './AddInstitutionForm.vue'
import { confirmAlert, confirmationAlert } from '@/utils/notificationService'
import { getViewerContract } from '@/utils/contractService'

const overlay = ref(false)

const instFilter = ref({
  all: true,
  gov: false,
  health: false,
  private: false,
  academic: false,
})

const switchInst = (inst) => {
  ; (instFilter.value.all = false),
    (instFilter.value.gov = false),
    (instFilter.value.health = false),
    (instFilter.value.private = false),
    (instFilter.value.academic = false)

  if (inst == 'all') instFilter.value.all = true
  if (inst == 'gov') instFilter.value.gov = true
  if (inst == 'health') instFilter.value.health = true
  if (inst == 'private') instFilter.value.private = true
  if (inst == 'academic') instFilter.value.academic = true
}

const institutions = ref([])

const getInstitutions = async () => {
  const { contract } = await getViewerContract()
  institutions.value = await contract.getAllInstitution()
  console.log(institutions.value);

}

onMounted(() => {
  getInstitutions()
})
</script>
