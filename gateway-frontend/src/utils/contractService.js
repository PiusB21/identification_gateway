import { ethers } from 'ethers'
import { abi } from '../contract/IdentityGateway.json'
import router from '@/router'
import { notifyError, notifySuccess } from './notificationService'

//CONTRACT AND WALLET RELATED
const contractAddress = '0x2Ce2C24c1A46f5eB68eD4EfCE674c4F9f788d4B4'
const INFURA_API_KEY = '39274895cec54a43bc080c087a46ce9e'

export const getProvider = () => {
  return new ethers.providers.Web3Provider(window.ethereum)
}

export const getSignerContract = async () => {
  let provider = getProvider()
  await provider.send('eth_requestAccounts', [])
  const signer = provider.getSigner()
  const contract = new ethers.Contract(contractAddress, abi, signer)
  return { signer, contract }
}

export const getViewerContract = async () => {
  const provider = new ethers.providers.JsonRpcProvider(
    `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
  )
  //let provider = getProvider()
  const contract = new ethers.Contract(contractAddress, abi, provider)
  return { contract }
}

export const setObjectState = (state, value) => {
  localStorage.setItem(state, JSON.stringify(value))
}

export const getObjectState = (state) => {
  return JSON.parse(localStorage.getItem(state))
}

export const setState = (state, value) => {
  localStorage.setItem(state, value)
}

export const getState = (state) => {
  return localStorage.getItem(state)
}

export const resetState = (state) => {
  localStorage.removeItem(state)
}

export const login = async () => {
  if (!window.ethereum.isMetaMask) {
    notifyError('Install metamask!')
    return
  }
  const { contract } = await getViewerContract()
  const { signer } = await getSignerContract()

  const signerAddress = await signer.getAddress()
  const userType = await contract.Login(signerAddress)
  console.log('user Type : ', userType)

  if (signerAddress == '0x7cE5Dc33aF6aC085df443252d8a17AC1AC4E9a97') {
    router.push('/dashboard')
    setState('name', 'admin')
    setState('signer', signerAddress)
    setState('role', 'admin')
    return
  }

  if (userType === null) {
    notifyError('Unauthorized User')
    return
  }
}
export const logout = () => {
  localStorage.clear()
  router.push('/')
  notifySuccess('Please disconnect from the wallet manually.')
}

export const getDate = (timestampInBigNumber) => {
  const timestampInSeconds = ethers.BigNumber.from(timestampInBigNumber).toString()
  const timestampInMs = parseFloat(timestampInSeconds) * 1000
  const date = new Date(timestampInMs)
  const month = date.toLocaleString('en-US', { month: 'short' }) // Get short month name
  const day = date.getDate().toString().padStart(2, '0') // Pad day with leading zero
  const year = date.getFullYear()
  return `${month} ${day}, ${year}`
}

export const getNumber = (inBigNumber) => {
  return ethers.BigNumber.from(inBigNumber).toString()
}
