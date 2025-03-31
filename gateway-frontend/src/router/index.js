import LandingLayout from '@/views/landing/LandingLayout.vue'
import authLayout from '@/views/authentication/authLayout.vue'

import { createRouter, createWebHistory } from 'vue-router'
import AdminLayout from '@/views/admin/adminLayout.vue'
import DashboardView from '@/views/admin/DashboardView.vue'
import InstitutionsView from '@/views/admin/InstitutionsView.vue'

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
          path: '/reports',
          name: 'Reports',
          component: DashboardView,
        },
      ],
    },
  ],
})

export default router
