import LandingLayout from '@/views/landing/LandingLayout.vue'
import authLayout from '@/views/authentication/authLayout.vue'
import { getState } from '@/utils/contractService'
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
      path: '/bima',
      name: 'Bima Login',
      component: () => import('../views/bima/LoginView.vue'),
    },
    {
      path: '/bima-interface',
      name: 'Bima Interface',
      component: () => import('../views/bima/BimaInterface.vue'),
    },
    {
      path: '/nida',
      name: 'Nida Login',
      component: () => import('../views/nida/LoginView.vue'),
    },
    {
      path: '/nida-interface',
      name: 'Nida Interface',
      component: () => import('../views/nida/NidaInterface.vue'),
    },
    {
      path: '/rita',
      name: 'Rita Login',
      component: () => import('../views/rita/LoginView.vue'),
    },
    {
      path: '/rita-interface',
      name: 'Rita Interface',
      component: () => import('../views/rita/RitaInterface.vue'),
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

router.beforeEach((to, from, next) => {
  if (to.meta.requiresMetaMask && !getState('signer')) {
    next('/')
    notifyError('You are not Connected')
    return
  } else if (
    ['Admin Dashboard', 'Institutions', 'API Requests', 'Admin Account'].includes(to.name) &&
    !(getState('role') == 'admin')
  ) {

    next('/')
    notifyError('You are not Authorized')
    return
  } else if (
    ['Citizen Data', 'Rita Interface', 'Nida Interface'].includes(to.name) &&
    !(getState('role') == 'admin') &&
    !(getState('role') == 'nida') &&
    !(getState('role') == 'rita')
  ) {

    next('/')
    notifyError('You are not Authorized')
    return
  }

  // else if(['Registered Users'].includes(to.name)&& !(getState('role')=='prosecutor')){
  //     next('/');
  //     notifyError("You are not Authenticated")
  //     return;
  // }

  next()
})

export default router
