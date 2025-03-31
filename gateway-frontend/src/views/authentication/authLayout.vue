<script setup>
import { onMounted } from 'vue'
import { renderCanvas } from '@/utils/grid'

onMounted(() => {
  const canvasElements = [...document.querySelectorAll('canvas')]
  renderCanvas(canvasElements)
})
</script>

<template>
  <main
    class="overflow-hidden overscoll-none tracking-wide fixed flex flex-col top-0 left-0 w-[100%] overflow-y-scroll p-3"
  >
    <section class="relative w-[100%] flex flex-col py-[80px] overflow-hidden min-h-[100vh]">
      <canvas
        id="squareCanvas"
        class="absolute left-0 top-0 w-full h-full bg-[var(--sec)] opacity-50 -z-10"
      ></canvas>
      <!-- <nav class="w-full z-20 px-16 py-4 h-fit flex items-center bg-white">
        <h1
          class="max-sm:text-2xl max-md:text-4xl text-[1.7vw] font-bold text-[var(--pri)] font-sans tracking-tight"
        >
          Gateway-portal
        </h1>
        <div></div>
        <div class="ml-auto">
          <v-btn color="primary">LOGIN</v-btn>
        </div>
      </nav> -->
      <div class="flex-1 overflow-hidden flex">
        <div class="w-[35%] border-t border-[rgba(57,60,212,0.09)]"></div>
        <div class="w-[65%] flex justify-center border-t border-[rgba(57,60,212,0.09)]">
          <div
            class="backdrop-blur-md p-10 rounded-lg bg-gradient-to-l from-white via-white to-transparent"
          ></div>
          <form class="bg-white w-[50%] max-md:max-w-[30rem] h-[90vh] my-auto flex flex-col px-10">
            <div class="my-auto px-48">
              <div class="text-subtitle-1 text-medium-emphasis">Account</div>

              <v-text-field
                density="compact"
                placeholder="Email address"
                prepend-inner-icon="mdi-email-outline"
                variant="outlined"
              ></v-text-field>

              <div
                class="text-subtitle-1 text-medium-emphasis d-flex align-center justify-space-between"
              >
                Password

                <a
                  class="text-caption text-decoration-none text-blue"
                  href="#"
                  rel="noopener noreferrer"
                  target="_blank"
                >
                  Forgot login password?</a
                >
              </div>

              <v-text-field
                :append-inner-icon="visible ? 'mdi-eye-off' : 'mdi-eye'"
                :type="visible ? 'text' : 'password'"
                density="compact"
                placeholder="Enter your password"
                prepend-inner-icon="mdi-lock-outline"
                variant="outlined"
                @click:append-inner="visible = !visible"
              ></v-text-field>

              <v-card class="mb-12" color="surface-variant" variant="tonal">
                <v-card-text class="text-medium-emphasis text-caption">
                  Warning: After 3 consecutive failed login attempts, you account will be
                  temporarily locked for three hours. If you must login now, you can also click
                  "Forgot login password?" below to reset the login password.
                </v-card-text>
              </v-card>

              <v-btn class="mb-8" color="blue" size="large" variant="tonal" block> Log In </v-btn>

              <v-card-text class="text-center">
                <a
                  class="text-blue text-decoration-none"
                  href="#"
                  rel="noopener noreferrer"
                  target="_blank"
                >
                  Sign up now <v-icon icon="mdi-chevron-right"></v-icon>
                </a>
              </v-card-text>
            </div>
          </form>
        </div>
      </div>
    </section>
  </main>
</template>
