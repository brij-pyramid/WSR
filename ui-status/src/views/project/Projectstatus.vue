<template>
  <div>
       <!-- BootstrapVue Done -->
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
      <!-- Card stats -->
      <b-row>
        <b-button variant="primary" @click="redirectto('milestone')">Mile Stone</b-button>
        <b-button  @click="redirectto('resources')">Resources</b-button>
        <b-button  @click="redirectto('activities')">Activities</b-button>
        <b-button  @click="redirectto('risk')">Risk</b-button>
      </b-row>
    </base-header>

 <b-container class="mt--8 pb-5" v-if="!projectsStatusData">
      <b-row class="justify-content-center">
        <b-col lg="6" md="8" >
            <h1> Project Status</h1>
          <b-card no-body class="bg-secondary border-0">
                         <span style="text-align: center;
    margin-top: 0.25rem;
    font-size: 80%;
    color: #fb6340;" v-if="error">{{error}}</span> 
            <b-card-body class="px-lg-5 py-lg-5" >
              <validation-observer ref="formValidator">
                                <b-select :disabled="model.project > 0" class="mb-3" placeholder="Select project"  v-model="model.project">
                    <b-select-option value="0">Select project</b-select-option>
                <b-select-option v-for="project in projectsData" :key=project.pid :value="project['pid']">
                  {{ project.project_name }}
                </b-select-option>
                  </b-select>
                 <b-select class="mb-3" placeholder="Select timeline Status"  v-model="model.date_id">
                    <b-select-option value="0">Select Date Format</b-select-option>
                    <b-select-option value="1">1</b-select-option>
                    <b-select-option value="2">2</b-select-option>
                    <b-select-option value="3">3</b-select-option>
                  </b-select>
                 <b-select class="mb-3" placeholder="Select timeline Status"  v-model="model.timeline">
                    <b-select-option value="0">Select timeline Status</b-select-option>
                    <b-select-option v-for="s in severity" :key=s.id :value="s.id">
                      {{ s.value }}
                     </b-select-option>
                  </b-select>
                  <b-select class="mb-3" placeholder="Select quality Status"  v-model="model.quality">
                    <b-select-option value="0">Select quality Status</b-select-option>
                    <b-select-option v-for="s in severity" :key=s :value="s.id">
                    {{ s.value }}
                     </b-select-option>
                  </b-select>
                   <b-select class="mb-3" placeholder="Select customer Status"  v-model="model.customer">
                    <b-select-option selected value="0">Select customer Statust</b-select-option>
                    <b-select-option v-for="s in severity" :key=s :value="s.id">
                     {{ s.value }}
                     </b-select-option>
                  </b-select>
                  <b-select class="mb-3" placeholder="Select resources Status"  v-model="model.resources">
                    <b-select-option value="0">Select resources Status</b-select-option>
                    <b-select-option v-for="s in severity" :key=s :value="s.id">
                     {{ s.value }}
                     </b-select-option>
                  </b-select>
                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-hat-3"
                              placeholder="Achivements"
                              name="achivements"
                              v-model="model.achivements">
                  </base-input>
                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-hat-3"
                              placeholder="Comments"
                              name="comments"                          
                              v-model="model.comments">
                  </base-input>
                                    <b-row class=" my-4">
                  </b-row>
                  <div class="text-center">
                    <b-button type="submit" variant="primary" :disabled="model.resources==''" class="mt-4" @click="addProjectStatus()">Add Project Status</b-button>
                  </div>
              </validation-observer>
            </b-card-body>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
    <b-container v-else>
Status Completed

    </b-container>
  </div>
</template>
<script>
  import Vue from 'vue'
  import VueClipboard from 'vue-clipboard2'
  import BaseHeader from '@/components/BaseHeader';
  import APISERVIVCE from '@/service/apiServices.js'
  import { mapGetters } from "vuex";

  Vue.use(VueClipboard)
  export default {
    name: 'ProjectStatus',
    components: {
      BaseHeader
    },
    data() {
      return {
        projectsData: {},
        error:"",
        model: {
          name: '',
          project: '',
          quality: '0',
          timeline: '0',
          customer:'0',
          resources: '0',
          achivements:'',
          comments:'',
          date_id:'0'
        },
        severity: [
        {id:1, value: 'On Track'},
        {id:2, value: 'Low'},
        {id:3, value: 'Medium'},
        {id:4, value: 'High'},
        {id:1, value: 'On Hold'}],
        projectadded: false,
        projectsStatusData: {}
      }
    },
    methods: {
      onCopy() {
        this.$notify({
          type: 'info',
          message: 'Copied to clipboard'
        })
      },
      addProjectStatus() {
        APISERVIVCE.addProjectStatus(this.model).then(response=>{
        this.$router.push("/project")
        this.getAllProject()

         }).catch(err=> console.log(err.response))
      },
      getAllProject(){
        APISERVIVCE.getAllproject().then(response=>{
        console.log(response,"data")
        this.projectsData =  JSON.parse(response.data.body);
    })
      },
      getProjectStatus(id){
         APISERVIVCE.getProjectStatus(id)
         .then(response=>{
            console.log(response,"data")
            this.projectsStatusData =  JSON.parse(response.data.body);
           })
          .catch(err=>console.log(err.responses))

      },
      redirectto(data){
        this.$router.push(data)
      }
    },
    mounted () {
      this.getAllProject();
      this.getProjectStatus(this.userDetails.project)
      this.model.project = this.userDetails.project
    },
     computed: {
      ...mapGetters(["loggedIn","userDetails"]),
    },
  };
</script>
<style></style>
