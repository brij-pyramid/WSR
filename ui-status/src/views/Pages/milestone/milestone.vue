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
    {{ model }}
 <b-container class="mt--8 pb-5">
      <b-row class="justify-content-center">
        <b-col lg="6" md="8" >
            <h1> Project Milestone</h1>
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
                
                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-hat-3"
                              placeholder="Milestone"
                              name="milestone"
                              v-model="model.milestone">
                  </base-input>
                  Planned Date
                   <b-datepicker class="mb-3" v-model="model.planneddate" :min="min" :max="max" locale="en"></b-datepicker>
                    Actual Date
                   <b-datepicker class="mb-3" v-model="model.actualdate" :min="min" :max="max" locale="en"></b-datepicker>
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
                    <b-button type="submit" variant="primary" :disabled="model.resources==''" class="mt-4" @click="addmilestone()">Add Project Status</b-button>
                  </div>
              </validation-observer>
            </b-card-body>
          </b-card>
        </b-col>
      </b-row>
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
    name: 'Milestone',
    components: {
      BaseHeader
    },
    data() {
      return {
        projectsData: {},
        error:"",
        model: {
          milestone: '',
          project: '',
          date_id:'0',
          planneddate:'',
          actualdate:'',
          comments: ''
        },
        severity: [
        {id:1, value: 'On Track'},
        {id:2, value: 'Low'},
        {id:3, value: 'Medium'},
        {id:4, value: 'High'},
        {id:1, value: 'On Hold'}],
        projectadded: false,
        projectsMilestoneData: {}
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
      getProjectMilestone(id){
         APISERVIVCE.getProjectMilestone(id)
         .then(response=>{
            console.log(response,"data")
      this.projectsMilestoneData =  JSON.parse(response.data.body);
             this.model.milestone = projectsMilestoneData.milestone;
          this.model.project = projectsMilestoneData.project_id
          this.model.milestone = projectsMilestoneData.milestone
          this.model.date_id = projectsMilestoneData.date_id
          this.model.planneddate = projectsMilestoneData.plan_date
          this.model.actualdate = projectsMilestoneData.actual_date
          this.model.comments = projectsMilestoneData.comments
           })
          .catch(err=>console.log(err.responses))

      },
      addmilestone(){
        APISERVIVCE.addMilestone(this.model).then(response=>{
        this.$router.push("/projectstatus")
        this.getAllProject()

         }).catch(err=> console.log(err.response))
      },
      redirectto(data){
        this.$router.push(data)
      }
    },
    mounted () {
      this.getAllProject();
      this.getProjectMilestone(this.userDetails.project)
      this.model.project = this.userDetails.project
    },
     computed: {
      ...mapGetters(["loggedIn","userDetails"]),
    },
  };
</script>
<style></style>
