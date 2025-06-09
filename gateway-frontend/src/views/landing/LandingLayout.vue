<script setup>
import { onMounted,ref } from 'vue'
import { renderCanvas } from '@/utils/grid'
import { useRouter } from 'vue-router'
import { login } from "@/utils/contractService.js"

const router = useRouter()
const isLoading = ref(false)

const buttonClicked = async()=>{
  isLoading.value = true
  await login()
  isLoading.value = false
}

onMounted(() => {
  const canvasElements = [...document.querySelectorAll('canvas')]
  renderCanvas(canvasElements, 'rgba(255,255,255,0.6)', 'rgba(57,60,212,0.09)')
})
</script>

<template>
  <main class="overflow-hidden overscoll-none tracking-wide fixed top-0 left-0 w-[100%] overflow-y-scroll">
    <section class="relative w-[100%] flex flex-col py-[80px] overflow-hidden min-h-[100vh]">
      <canvas id="squareCanvas" class="absolute left-0 top-0 w-full h-full bg-[var(--sec)] opacity-50"></canvas>

      <nav class="w-full z-10 px-16 py-4 h-fit flex items-center bg-white">
        <h1 class="max-sm:text-2xl max-md:text-4xl text-[1.7vw] font-bold text-[var(--pri)] font-sans tracking-tight">
          Gateway-portal
        </h1>
        <div></div>
        <div class="ml-auto">
          <v-btn :loading="isLoading" @click="buttonClicked()" color="primary">LOGIN</v-btn>
        </div>
      </nav>
      <div class="flex-1 flex z-10">
        <div class="w-[60%] max-md:w-[100%] flex items-center justify-center">
          <div class="text-[3vh] font-semibold font-sans max-md:w-[80%] w-[50%] h-[40%]">
            Connecting Organizations seamlessly,<br />
            with a <span class="text-[var(--pri)]">Blockchain</span> based gateway. <br />
            <span class="text-lg font-sm text-gray-400">Sharing&nbsp;data&nbsp;securely.</span>
          </div>
        </div>
        <div class="w-[40%] max-md:w-0"></div>
      </div>
      <div class="z-10 w-[100%] px-16 bg-yellow-400 items-center">
        <div class="h-fit w-full grid grid-cols-5 bg-blue-400"></div>
      </div>

    </section>
  </main>
</template>
