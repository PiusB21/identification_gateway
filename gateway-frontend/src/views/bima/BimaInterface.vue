<template>
  <div class="flex flex-col items-center">
    <nav :style="{ backgroundColor: 'rgb(125, 73, 12)' }" class="py-4 text-white w-full">
      <div class="w-[90%] mx-auto text-3xl flex justify-between">
        <div>NHIF</div>
        <v-btn 
        class=""
          @click="logout();router.push('/');"
          color="white"
          icon="mdi-logout"
          title="Logout"
          variant="outlined"
        ></v-btn>
      </div>
    </nav>
    <div class="md:w-[90%] py-8">

      <div class="flex gap-4 text-xl mb-8">
          <button @click="querying=false; onMembersPage=true" :class="onMembersPage?'!border-yellow-900 !text-yellow-900':'border-transparent'" class="!border-b-2">Insurance Members</button>
          <button @click="onMembersPage=false; querying=true" :class="querying?'!border-yellow-900 !text-yellow-900':'border-transparent'" class="!border-b-2">Query by ID</button>
      </div>
<!-- :style="{ color: 'rgb(125, 73, 12)' }" -->
      <QueryingPage v-if="querying"/>
      <MembersPage v-if="onMembersPage"/>
    </div>
  </div>
</template>

<script setup>

import { ref,computed,watch } from 'vue'
import { useRouter } from 'vue-router'
import {logout} from "@/utils/contractService.js"
import {useGatewayStore} from "@/stores/gateway.js"
import QueryingPage from './QueryingPage.vue'
import MembersPage from './MembersPage.vue'

const querying = ref(false)
const onMembersPage = ref(true)

const store = useGatewayStore()
const router = useRouter()



</script>
