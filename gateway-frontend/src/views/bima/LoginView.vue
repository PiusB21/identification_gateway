<template>
  <main
    class="overflow-hidden overscoll-none tracking-wide fixed flex flex-col top-0 left-0 w-[100%] overflow-y-scroll"
  >
    <section
      class="relative w-[100%] flex flex-col overflow-hidden min-h-[100vh] flex items-center justify-center"
    >
      <canvas
        id="squareCanvas"
        class="absolute left-0 top-0 w-full h-full bg-[var(--sec)] opacity-50 -z-10"
      ></canvas>

      <!-- Login -->
      <div
        class="backdrop-blur-lg bg-white/5 border border-[#009990]/50 rounded-xl px-6 py-8 shadow-lg flex flex-col min-w-[500px]"
      >
        <div :style="{ color: 'rgb(125, 73, 12)' }" class="font-semibold text-2xl pb-8 text-center">
          NHIF - Login
        </div>

        <v-form class="flex flex-col gap-4 z-10">
          <v-text-field
            v-model="loginData.email"
            variant="outlined"
            label="Email"
            color="rgb(125, 73, 12)"
            @focus="focused[0] = true"
            @blur="focused[0] = false"
          >
          </v-text-field>

          <v-text-field
            v-model="loginData.password"
            variant="outlined"
            label="Password"
            color="rgb(125, 73, 12)"
            @focus="focused[1] = true"
            @blur="focused[1] = false"
          >
          </v-text-field>

          <div class="py-4 w-full">
            <v-btn color="rgb(125, 73, 12)" width="100%">Login</v-btn>
          </div>

          <!-- <div class="w-full pb-8">
            <v-btn color="primary" width="100%" variant="flat">Login</v-btn>
          </div> -->
        </v-form>
      </div>
    </section>
  </main>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { renderCanvas } from '@/utils/grid.js'

onMounted(() => {
  const canvasElements = [...document.querySelectorAll('canvas')]
  renderCanvas(canvasElements, 'rgba(125, 73, 12, 0.3)', 'rgba(125, 73, 12, 0.1)')
})

const router = useRouter()

const focused = ref([])

const loginData = ref({
  email: '',
  password: '',
})
</script>
