<template>
  <div class="flex flex-col items-center">
    <nav :style="{ backgroundColor: 'rgba(0,114,187)' }" class="py-4 text-white w-full">
      <div class="w-[80%] mx-auto text-3xl flex justify-between">
        <div>NHIF</div>
        <v-btn color="white" icon="mdi-logout" title="Logout" variant="outlined"></v-btn>
      </div>
    </nav>
    <div class="md:w-[80%] py-8">
      <div :style="{ color: 'rgba(0,114,187)' }" class="text-2xl font-semibold pb-4">
        Fetch data
      </div>
      <div class="flex gap-16">
        <v-text-field
          color="rgba(0,114,187)"
          v-model="searchedId"
          variant="outlined"
          label="Citizen ID"
        >
          <template v-slot:append>
            <v-btn size="x-large" color="rgba(0,114,187)">
              <div class="lowercase text-md">Fetch</div>
            </v-btn>
          </template>
        </v-text-field>
      </div>
      <section class="flex flex-col gap-4 py-4">
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Id</div>
          <div class="col-span-7 text-lg">afd-xx-xx-xx-xxxx-wwww-as-as</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Name</div>
          <div class="col-span-7 text-lg">John Doe</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">Age</div>
          <div class="col-span-7 text-lg">40 years</div>
        </div>
        <div class="grid grid-cols-8">
          <div class="col-span-1 text-gray-600">NHIF Package</div>
          <div class="col-span-7 text-lg">Individual</div>
        </div>
      </section>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const searchedId = ref('')
</script>
