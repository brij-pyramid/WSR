import Vue from "vue";
import DashboardPlugin from "./plugins/dashboard-plugin";
import App from "./App.vue";
import store from "./store/store";

// router setup
import router from "./routes/router";
// plugin setup
Vue.use(DashboardPlugin);

/* eslint-disable no-new */
new Vue({
  el: "#app",
  render: h => h(App),
  router,
  store
});
