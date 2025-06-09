<template>
  <div class="bg-white px-4 py-8 rounded min-w-[700px]">

    <!-- <div class="absolute top-0 z-10">
      <Loader :color="'stroke-blue-600'" />
    </div> -->
    <div :style="{ color: props.themeColor || '#1867c0' }" class="font-semibold text-2xl pb-8 text-center">
      Register Institution
    </div>

    <v-form class="flex flex-col gap-4 z-10">
      <div class="grid grid-cols-3 gap-2">
        <v-text-field class="col-span-2" v-model="instData.name" variant="outlined" label="Institution Name"
          :color="props.themeColor" @focus="focused[3] = true" @blur="focused[3] = false">
        </v-text-field>


        <v-text-field v-model="instData.abbrev" variant="outlined" label="Abbreviation" :color="props.themeColor"
          @focus="focused[3] = true" @blur="focused[3] = false">
        </v-text-field>
      </div>
      <v-text-field v-model="instData.address" variant="outlined" label="Institution Address" :color="props.themeColor"
        @focus="focused[3] = true" @blur="focused[3] = false">
      </v-text-field>


      <v-select v-model="instData.instType" label="Type" :items="['Government', 'Private']"
        variant="outlined"></v-select>

      <div class="py-4 w-full">
        <v-btn @click="registerInstitution()" :color="props.themeColor || 'primary'" width="100%"
          :loading="isLoading">Add</v-btn>
      </div>
    </v-form>
  </div>
</template>

<script setup>
import { onMounted, ref, defineEmits } from 'vue'
import { getSignerContract } from '@/utils/contractService'
import Loader from '@/components/Loader.vue'
import {useGatewayStore} from "@/stores/gateway.js"

const store = useGatewayStore()
const emit = defineEmits(['close'])

const isLoading = ref(false)

const focused = ref([])

const instData = ref({
  name: '',
  address: '',
  abbrev: '',
  instType: '',
})


const props = defineProps(['themeColor', 'editedCitizen'])

const convertToDateObject = (dateString) => {
  const [day, month, year] = dateString.split('/').map(Number) //for DD/MM/YYYY
  const date = new Date(year, month - 1, day) // Month is zero-based
  return date
}

const registerInstitution = async () => {
  isLoading.value = true
  await store.addInstitution(instData.value.name, instData.value.address, instData.value.instType, instData.value.abbrev);
  isLoading.value = false
  emit('close')
}

//0xe974DB6b5832bfc0228b5b15167cC588454AD048

</script>
