<template>
 <div class="bg-white px-4 py-8 rounded min-w-[700px]">
    <div :style="{ color: props.themeColor || '#1867c0' }" class="font-semibold text-2xl pb-8 text-center">
      Issue NIDA
    </div>

    <v-form class="flex flex-col gap-4 z-10">
      <div class="grid grid-cols-3 gap-2">
        <v-text-field v-model="formData.birthCertificateNo" variant="outlined" label="First Name" :color="props.themeColor"
          @focus="focused[0] = true" @blur="focused[0] = false">
        </v-text-field>
        <v-text-field v-model="formData.citizenId" variant="outlined" label="Middle Name" :color="props.themeColor"
          @focus="focused[1] = true" @blur="focused[1] = false">
        </v-text-field>

        
      </div>
      <!-- <div class="grid grid-cols-2 gap-2">
        <v-text-field v-model="formData.address" variant="outlined" label="Address" :color="props.themeColor"
          @focus="focused[3] = true" @blur="focused[3] = false">
        </v-text-field>
        <v-radio-group label="Gender" v-model="formData.gender" inline>

          <v-radio value="Male" label="Male"></v-radio>
          <v-radio value="Female" label="Female"></v-radio>

        </v-radio-group>
         <v-text-field v-model="formData.district" variant="outlined" label="Gender" :color="props.themeColor"
          @focus="focused[4] = true" @blur="focused[4] = false">
        </v-text-field> 
      </div> -->

      <!-- <v-date-input v-model="formData.dob" label="Date of birth" variant="outlined"></v-date-input> -->

      <div class="py-4 w-full">
        <v-btn @click="issueNida()" :color="props.themeColor || 'primary'" width="100%">Add</v-btn>
      </div>
    </v-form>
  </div>

</template>

<script setup>
import { getSignerContract } from '@/utils/contractService'
import { onMounted } from 'vue'

const emit = defineEmits(['close'])
const props = defineProps(['themeColor', 'editedCitizen'])


onMounted(() => {
    if (props.editedCitizen) {
        formData.value.birthCertificateNo = props.editedCitizen.birthCertificateNo
        formData.value.citizenId = props.editedCitizen.citizenId
    }
})
const formData = ref({
  birthCertificateNo: '',
  citizenId: '',
  
})

const issueNida = async () => {
    const { contract } = await getSignerContract()
    await contract.issueCitizenId(formData.value.birthCertificateNo, formData.value.citizenId);
    emit('close')
}


</script>