<script setup>
import { ref } from 'vue'

const drawer = ref(false)
</script>

<template>
  <v-card>
    <v-layout>
      <v-navigation-drawer width="300" class="bg-[var(--pri)]" color="primary" expand-on-hover rail>
        <v-list>
          <v-list-item prepend-icon="mdi-lan-connect" title="Gateway Portal">
            <template v-slot:title>
              <span class="text-xl font-bold">Gateway Portal</span>
            </template>
          </v-list-item>
        </v-list>

        <v-divider></v-divider>

        <v-list density="compact" nav>
          <v-list-item to="/dashboard" prepend-icon="mdi-view-dashboard" value="Dashboard">
            <template v-slot:title>
              <span class="text-lg">Dashboard</span>
              <!-- Custom title -->
            </template>
          </v-list-item>
          <v-list-item
            to="/institutions"
            prepend-icon="mdi-bank"
            title="Institutions"
            value="Institutions"
          >
            <template v-slot:title>
              <span class="text-lg">Institutions</span>
              <!-- Custom title -->
            </template>
          </v-list-item>
          <v-list-item to="/api-keys" prepend-icon="mdi-key" title="api-keys" value="api-keys">
            <template v-slot:title>
              <span class="text-lg">API Keys</span>
              <!-- Custom title -->
            </template>
          </v-list-item>
          <v-list-item
            to="/api-requests"
            prepend-icon="mdi-link-variant"
            title="api-requests"
            value="api-requests"
          >
            <template v-slot:title>
              <span class="text-lg">API Requests</span>
              <!-- Custom title -->
            </template>
          </v-list-item>
          <v-list-item
            to="/citizen-data"
            prepend-icon="mdi-database"
            title="citizen-data"
            value="citizen-data"
          >
            <template v-slot:title>
              <span class="text-lg">Citizen Data</span>
              <!-- Custom title -->
            </template>
          </v-list-item>
        </v-list>
      </v-navigation-drawer>

      <v-main style="height: 100vh" class="flex flex-col">
        <v-app-bar color="white" class="elevation-0 px-4">
          <v-toolbar-title>
            <div class="text-xl font-bold text-gray-800">Gateway Portal</div>
          </v-toolbar-title>

          <v-app-bar-nav-icon
            class="opacity-0"
            variant="text"
            @click.stop="drawer = !drawer"
          ></v-app-bar-nav-icon>

          <v-btn color="primary" icon="mdi-logout" title="Logout" variant="outlined"></v-btn>
        </v-app-bar>
        <div class="h-full w-full overflow-y-auto">
          <router-view></router-view>
        </div>
      </v-main>
    </v-layout>
  </v-card>
</template>
