<template>
  <div class="flex flex-col items-center">
    <nav :style="{ backgroundColor: 'rgb(125, 73, 12)' }" class="py-4 text-white w-full">
      <div class="w-[90%] mx-auto text-3xl flex justify-between">
        <div>NHIF</div>
        <v-btn
          @click="router.push('bima')"
          color="white"
          icon="mdi-logout"
          title="Logout"
          variant="outlined"
        ></v-btn>
      </div>
    </nav>
    <div class="md:w-[90%] py-8">
      <div :style="{ color: 'rgb(125, 73, 12)' }" class="text-2xl font-semibold pb-4">
        Fetch data
      </div>
      <div class="flex gap-16">
        <v-text-field
          color="rgb(125, 73, 12)"
          v-model="searchedId"
          variant="outlined"
          label="Citizen ID"
        >
          <template v-slot:append>
            <v-btn size="x-large" color="rgb(125, 73, 12)">
              <div class="lowercase text-md">Fetch</div>
            </v-btn>
          </template>
        </v-text-field>
      </div>

      <section class="flex flex-col gap-4 py-4">
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Id</div>
          <div class="col-span-7 text-lg">TZ-1232-12315-2322-001</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Name</div>
          <div class="col-span-7 text-lg">John Doe</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Date of Birth</div>
          <div class="col-span-7 text-lg">21/08/2001</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Life Status</div>
          <div class="col-span-7 text-lg">ALIVE</div>
        </div>
      </section>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const searchedId = ref('')
</script>
