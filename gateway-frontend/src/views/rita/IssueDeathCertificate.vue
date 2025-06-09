<template>
  <div class="bg-white px-4 py-8 rounded min-w-[700px]">
    <div :style="{ color: props.themeColor || '#1867c0' }" class="font-semibold text-2xl pb-8 text-center">
      Issue Death Certificate to Citizen {{ props.editedCitizen }}
    </div>

    <v-form class="flex flex-col gap-4 z-10">
      <div class="py-4 w-full">
        <v-btn :loading="isLoading" @click="registerCitizen()" :color="props.themeColor || 'red'" width="100%">Issue</v-btn>
      </div>
    </v-form>
  </div>
</template>

<script setup>
import { onMounted, ref, defineEmits } from 'vue'
import { getSignerContract } from '@/utils/contractService'
import {useGatewayStore} from "@/stores/gateway.js"

const store = useGatewayStore()
const focused = ref([])
const emit = defineEmits(['close'])
const isLoading = ref(false)
const formData = ref({

})

const props = defineProps(['themeColor', 'editedCitizen'])

const convertToDateObject = (dateString) => {  
  const [day, month, year] = dateString.split('/').map(Number)
  const date = new Date(year, month - 1, day) // Month is zero-based
  return date
}

onMounted(() => {
  if (props.editedCitizen) {
    formData.value.fname = props.editedCitizen.fname
    formData.value.lname = props.editedCitizen.lname
    formData.value.mname = props.editedCitizen.mname
    formData.value.gender = props.editedCitizen.gender
    formData.value.region = props.editedCitizen.region
    formData.value.district = props.editedCitizen.district
    formData.value.dob = convertToDateObject(props.editedCitizen.dateofBirth)
  }
})


const issueDeathCertificate = async()=>{
    await store.issueDeathCertificate(cause, dob, registeredBy, citizenId)
    emit('close')
}

</script>
