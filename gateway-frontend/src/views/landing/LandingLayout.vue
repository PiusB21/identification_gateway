<script setup>
import { onMounted } from 'vue'
import { renderCanvas } from '@/utils/grid'
import { useRouter } from 'vue-router'

const router = useRouter()

onMounted(() => {
  const canvasElements = [...document.querySelectorAll('canvas')]
  renderCanvas(canvasElements)
})
</script>

<template>
  <main
    class="overflow-hidden overscoll-none tracking-wide fixed top-0 left-0 w-[100%] overflow-y-scroll"
  >
    <!-- <header
      class="relative top-0 left-0 w-[100%] h-[80px] z-[1] bg-[var(--bg-color)] flex justify-center align-center"
    >
      <div class="flex grid grid-cols-12 w-full items-center">
        <ul class="flex col-start-5 col-span-6 gap-[1rem]">
          <li><router-link to="/interactive-landing">Home</router-link></li>
          <li><router-link to="/interactive-landing">About</router-link></li>
          <li><router-link to="/interactive-landing">Services</router-link></li>
          <li><router-link to="/interactive-landing">Projects</router-link></li>
          <li><router-link to="/interactive-landing">Contact</router-link></li>
        </ul>
      </div>
    </header> -->
    <section class="relative w-[100%] flex flex-col py-[80px] overflow-hidden min-h-[100vh]">
      <canvas
        id="squareCanvas"
        class="absolute left-0 top-0 w-full h-full bg-[var(--sec)] opacity-50"
      ></canvas>

      <nav class="w-full z-10 px-16 py-4 h-fit flex items-center bg-white">
        <h1
          class="max-sm:text-2xl max-md:text-4xl text-[1.7vw] font-bold text-[var(--pri)] font-sans tracking-tight"
        >
          Gateway-portal
        </h1>
        <div></div>
        <div class="ml-auto">
          <v-btn @click="router.push('/adm')" color="primary">LOGIN</v-btn>
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
      <!-- 
          use a white to transparent gradient for a partial blur
      -->
      <!-- grid auto-rows-min
             Any row without an explicitly set height will be as small as possible while still fitting its content.
            -->
      <!-- <div class="z-20 w-[100%] p-4 grid grid-cols-12">
        <div class="intro-area col-span-6 flex flex-col gap-[2rem]">
          <div
            class="pre_header fade_in flex p-[10px] rounded-[3px] gap-[3px] items-center max-w-fit bg-white border border-[#161616]"
          >

            <p class="text-[0.9rem]">Powered by Pius Baraka</p>
          </div>
          <h1 class="hero_header fade_in text-2xl">
            Crafting Websites that<br />
            Build Your Business
          </h1>
          <p class="fade_in text-[0.9rem]">
            We design and develop exceptional websites that just look great-they work hard to bring
            you more customers.From sleek portfolios to powerful booking systems, building with your
            business in mind
          </p>
          <div class="cta_area fade_in text-[0.9rem] flex gap-[1rem]">
            <a
              class=".primary_cta py-[.5rem] px-[1rem] rounded-[10px] border border-[#161616] hover:opacity-70 bg-[#161616] text-white transition-all duration-200 ease-in"
              href=""
              >Start a Product&nbsp;</a
            >
            <a
              class=".secondary_cta py-[.5rem] px-[1rem] rounded-[10px] border border-[#161616] hover:opacity-70 transition-all duration-200 ease-in"
              href=""
              >View Our Work</a
            >
          </div>
        </div>
      </div> -->
    </section>
  </main>
</template>
