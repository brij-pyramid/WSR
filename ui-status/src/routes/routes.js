import DashboardLayout from "@/views/Layout/DashboardLayout.vue";
import AuthLayout from "@/views/Pages/AuthLayout.vue";

import NotFound from "@/views/NotFoundPage.vue";

const routes = [
  {
    path: "/",
    redirect: "dashboard",
    component: DashboardLayout,
    children: [
      {
        path: "/dashboard",
        name: "dashboard",
        meta: { requiresAuth: true },

        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () =>
          import(/* webpackChunkName: "demo" */ "../views/Dashboard.vue")
      },
      {
        path: "/users",
        name: "users",
        prop: true,
        meta: { requiresAuth: true },

        component: () =>
          import(/* webpackChunkName: "demo" */ "../views/Icons.vue")
      },
      {
        path: "/adduser",
        name: "adduser",
        prop: true,
        meta: { requiresAuth: true },

        component: () =>
          import(/* webpackChunkName: "demo" */ "../views/Adduser.vue")
      },
      {
        path: "/profile",
        name: "profile",
        prop: true,

        meta: { requiresAuth: true },

        component: () =>
          import(
            /* webpackChunkName: "demo" */ "../views/Pages/UserProfile.vue"
          )
      },
      {
        path: "/project",
        name: "project",
        meta: { requiresAuth: true },
        component: () =>
          import(/* webpackChunkName: "demo" */ "../views/Project.vue")
      },
      {
        path: "/addproject",
        name: "addproject",
        meta: { requiresAuth: true },
        component: () =>
          import(/* webpackChunkName: "demo" */ "../views/AddProject.vue")
      },
      {
        path: "/clients",
        name: "clients",
        meta: { requiresAuth: true },
        component: () =>
          import(/* webpackChunkName: "demo" */ "../views/client/client.vue")
      },
      {
        path: "/addclient",
        name: "addclient",
        meta: { requiresAuth: true },
        component: () =>
          import(/* webpackChunkName: "demo" */ "../views/client/addclient.vue")
      },
      {
        path: "/projectstatus",
        name: "projectstatus",
        meta: { requiresAuth: true },
        component: () =>
          import(
            /* webpackChunkName: "demo" */ "../views/project/Projectstatus.vue"
          )
      },
      {
        path: "/milestone",
        name: "milestone",
        meta: { requiresAuth: true },
        component: () =>
          import(
            /* webpackChunkName: "demo" */ "../views/Pages/milestone/milestone.vue"
          )
      },
      {
        path: "/resources",
        name: "resources",
        meta: { requiresAuth: true },
        component: () =>
          import(
            /* webpackChunkName: "demo" */ "../views/project/Projectstatus.vue"
          )
      },
      {
        path: "/activities",
        name: "activities",
        meta: { requiresAuth: true },
        component: () =>
          import(
            /* webpackChunkName: "demo" */ "../views/project/Projectstatus.vue"
          )
      },
      {
        path: "/risk",
        name: "risk",
        meta: { requiresAuth: true },
        component: () =>
          import(
            /* webpackChunkName: "demo" */ "../views/project/Projectstatus.vue"
          )
      },
      {
        path: "/tables",
        name: "tables",
        component: () =>
          import(/* webpackChunkName: "demo" */ "../views/RegularTables.vue")
      }
    ]
  },
  {
    path: "/",
    redirect: "login",
    component: AuthLayout,
    children: [
      {
        path: "/login",
        name: "login",
        component: () =>
          import(/* webpackChunkName: "demo" */ "../views/Pages/Login.vue")
      },
      {
        path: "/register",
        name: "register",
        component: () =>
          import(/* webpackChunkName: "demo" */ "../views/Pages/Register.vue")
      },
      { path: "*", component: NotFound }
    ]
  }
];

export default routes;
