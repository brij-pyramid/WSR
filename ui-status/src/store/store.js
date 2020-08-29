import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";
import { apiUrl } from "@/constants/constants";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user: null
  },
  mutations: {
    SET_USER_DATA(state, userData) {
      state.user = userData;
      localStorage.setItem("user", JSON.stringify(userData));
    },
    CLEAR_USER_DATA() {
      localStorage.removeItem("user");
      location.reload();
    }
  },
  actions: {
    register({ commit }, credentials) {
      return axios
        .post(apiUrl + "login/register", credentials)
        .then(({ data }) => {
          //    commit("SET_USER_DATA", JSON.parse(data));
        });
    },
    login({ commit }, credentials) {
      return axios.post(apiUrl + "login/user", credentials).then(({ data }) => {
        commit("SET_USER_DATA", JSON.parse(data.body));
      });
    },
    logout({ commit }) {
      commit("CLEAR_USER_DATA");
    }
  },
  getters: {
    loggedIn(state) {
      return !!state.user;
    },
    userDetails(state) {
      return state.user;
    }
  }
});
