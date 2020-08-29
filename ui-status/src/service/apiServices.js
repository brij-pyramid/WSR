import axio from "axios";
import { apiUrl, requestHeader } from "@/constants/constants";
import NProgress from "nprogress";

const apiClient = axio.create({
  baseURL: apiUrl,
  headers: requestHeader
});
apiClient.interceptors.request.use(config => {
  NProgress.start();
  return config;
});
apiClient.interceptors.response.use(response => {
  NProgress.done();
  return response;
});
export default {
  getUsers(details) {
    return apiClient.post("login/user", details);
  },
  getAllUsers() {
    return apiClient.get("login/getAll");
  },
  addProject(payload) {
    return apiClient.post("project/addProject", payload);
  },

  getAllproject() {
    return apiClient.get("project/getAllProject");
  },
  getAllClient() {
    return apiClient.get("client/getAllClients");
  },
  addClient(payload) {
    return apiClient.post("client/addClient", payload);
  },
  addProjectStatus(payload) {
    return apiClient.post("project/addProjectStatus", payload);
  },
  getProjectStatus(id) {
    return apiClient.post("project/getProjectStatus/", { id: id });
  },
  addMilestone(payload) {
    return apiClient.post("project/addMilestone", payload);
  },
  getProjectMilestone(id) {
    return apiClient.post("project/getProjectMilestone/", { id: id });
  }
};
