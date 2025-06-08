import { ref, computed, reactive } from 'vue'
import { defineStore } from 'pinia'
import { getSignerContract,getViewerContract } from '@/utils/contractService'

export const useGatewayStore = defineStore('gateway', () => {

  const state = reactive({
      citizens : [],
      institutions : [],
      logs:[],
      isLoading:false
  })

  const toggleLoading = (bool)=>{
    state.isLoading = bool
  }

  const getCitizens = async ()=>{
    const { contract } = await getViewerContract()
    state.citizens = await contract.getAllCitizens()
  }

  const addCitizen = async (fname,mname,lname,address,gender,dob,randomInteger)=>{
    const { contract } = await getSignerContract()
    await contract.addCitizen(fname, mname, lname, address, gender, dob, randomInteger);
    setTimeout(()=>getCitizens(),3000)
  }

  const getInstitutions = async ()=>{
    const { contract } = await getViewerContract()
    state.institutions = await contract.getAllInstitution()
  }

  const addInstitution = async (name,address,instType,abbrev)=>{
    const { contract } = await getSignerContract()
    await contract.addInstitution(name, address, instType, abbrev);
    await contract.addOperator('operator', 'operator', address, 'operator', abbrev)
    setTimeout(()=>getInstitutions(),3000)
  }  

  const getLogs = async()=>{
    const { contract } = await getViewerContract()
    state.logs = await contract.getAllTransactions()
  }

  return { state,getInstitutions,getCitizens,getLogs,addCitizen,addInstitution,toggleLoading }
})
