import LandingLayout from '@/views/landing/LandingLayout.vue'
import authLayout from '@/views/authentication/authLayout.vue'

import { createRouter, createWebHistory } from 'vue-router'
import AdminLayout from '@/views/admin/adminLayout.vue'
import DashboardView from '@/views/admin/DashboardView.vue'
import InstitutionsView from '@/views/admin/InstitutionsView.vue'
import ApiKeysView from '@/views/admin/ApiKeysView.vue'
import ApiRequests from '@/views/admin/ApiRequests.vue'
import CitizenData from '@/views/admin/CitizenData.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    // {
    //   path: '/',
    //   name: 'home',
    //   component: HomeView,
    //   component: () => import('../views/AboutView.vue'),
    // },
    {
      path: '/',
      name: 'Home',
      component: LandingLayout,
    },
    {
      path: '/auth',
      name: 'Authentication',
      component: authLayout,
    },
    {
      path: '/adm',
      redirect: '/dashboard',
      name: 'Admin Account',
      component: AdminLayout,
      children: [
        {
          path: '/dashboard',
          name: 'Admin Dashboard',
          component: DashboardView,
        },
        {
          path: '/institutions',
          name: 'Institutions',
          component: InstitutionsView,
        },
        {
          path: '/api-keys',
          name: 'API Keys',
          component: ApiKeysView,
        },
        {
          path: '/api-requests',
          name: 'API Requests',
          component: ApiRequests,
        },
        {
          path: '/citizen-data',
          name: 'Citizen Data',
          component: CitizenData,
        },
      ],
    },
  ],
})

export default router
