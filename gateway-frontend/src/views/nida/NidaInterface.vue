<template>
  <div class="flex flex-col items-center">
    <nav :style="{ backgroundColor: 'rgb(47,103,0)' }" class="py-4 text-white w-full">
      <div class="w-[80%] mx-auto text-3xl flex justify-between">
        <div>NIDA</div>
        <v-btn color="white" icon="mdi-logout" title="Logout" variant="outlined"></v-btn>
      </div>
    </nav>
    <div class="md:w-[80%] py-8">
      <CitizenData :theme-color="'rgb(47,103,0)'" />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import CitizenData from '../admin/CitizenData.vue'

const searchedId = ref('')
</script>
