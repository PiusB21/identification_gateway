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

  const addCitizen = async (fname,mname,randomInteger,lname,gender,dob)=>{
    const { contract } = await getSignerContract()
    await contract.addCitizen(fname, mname, randomInteger, lname, gender, dob);
    setTimeout(()=>getCitizens(),3000)
  }

  const issueInsurance = async (birthCertificateNo, healthInsurance)=>{
    const { contract } = await getSignerContract()
    await contract.issueBima(birthCertificateNo, healthInsurance);
  }

  const revokeInsurance = async (healthInsurance)=>{
    const { contract } = await getSignerContract()
    await contract.revokeHealthInsurance(healthInsurance);
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

  const getIndividualCitizenData = async (birthCertificateNo)=>{
      const { contract } = await getViewerContract()
      const citizen = await contract.getCitizenData(birthCertificateNo)
      return citizen
  } //issueCitizenId

  const issueCitizenId = async (birthCertificateNo,citizenId)=>{
      const { contract } = await getSignerContract()
       await contract.issueCitizenId(birthCertificateNo,citizenId)
  }

  const issueDeathCertificate = async(
    cause, dob, registeredBy, citizenId
  )=>{
    const { contract } = await getSignerContract()
    await contract.issueDeathCertificate(cause, dob, registeredBy, citizenId)
  }

  return { 
    state,
    issueInsurance,
    revokeInsurance,
    getInstitutions,
    getCitizens,
    getLogs,
    addCitizen,
    addInstitution,
    toggleLoading,
    getIndividualCitizenData,
    issueDeathCertificate ,
    issueCitizenId
  }
})
