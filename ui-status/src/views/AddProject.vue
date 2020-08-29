<template>
  <div>
       <!-- BootstrapVue Done -->
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
      <!-- Card stats -->
      <b-row>
      </b-row>
    </base-header>

 <b-container class="mt--8 pb-5" >
      <b-row class="justify-content-center">
        <b-col lg="6" md="8" >
            <h1> Project</h1>
          <b-card no-body class="bg-secondary border-0">
                         <span style="text-align: center;
    margin-top: 0.25rem;
    font-size: 80%;
    color: #fb6340;" v-if="error">{{error}}</span>
            <b-card-body class="px-lg-5 py-lg-5">

              <validation-observer ref="formValidator">
              
                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-hat-3"
                              placeholder="Name"
                              name="Name"
                              :rules="{required: true}"
                              v-model="model.name">
                  </base-input>
                  <b-select class="mb-3" placeholder="Select Clients"  v-model="model.client">
                    <b-select-option value="0">Select Client</b-select-option>
                <b-select-option v-for="client in clientsData" :key=client.id :value="client['id']">

                  {{  client && client.client_name }}
                </b-select-option>
                  </b-select>
                                
                  <base-input alternative
                              class="mb-3 mt-3"
                              prepend-icon="ni ni-hat-3"
                              placeholder="Description"
                              name="desc"
                              :rules="{required: true}"
                              v-model="model.desc">
                  </base-input>
                   <b-datepicker id="example-datepicker" v-model="value" class="mb-3"></b-datepicker>
                                    <b-row class=" my-4">
                  </b-row>
                  <div class="text-center">
                    <b-button type="submit" variant="primary" :disabled="model.name=='' || model.client ==0" class="mt-4" @click="addProject()">Add Project</b-button>
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
  import LightTableProject from "./Tables/RegularTables/LightTableProject";
  import VueClipboard from 'vue-clipboard2'
  import BaseHeader from '@/components/BaseHeader';
  import APISERVIVCE from '@/service/apiServices.js'

  Vue.use(VueClipboard)
  export default {
    name: 'Adduser',
    components: {
      BaseHeader,
      LightTableProject,

    },
    data() {
      return {
        projectsData: {},
        error:"",
        model: {
          name: '',
          client: "",
          desc: ""
        },
        projectadded: false,
        clientsData: {}
      }
    },
    methods: {
      onCopy() {
        this.$notify({
          type: 'info',
          message: 'Copied to clipboard'
        })
      },
      addProject() {
        APISERVIVCE.addProject(this.model).then(response=>{
        console.log(response,"data")
        this.$router.push("/project")
        this.getAllProject()
         }).catch(err=> console.log(err.response))
      },
      getAllClients(){
        APISERVIVCE.getAllClient().then(response=>{
        console.log(response,"data")
        this.clientsData =  JSON.parse(response.data.body);
        })
      },
      getAllProject(){
        APISERVIVCE.getAllproject().then(response=>{
        console.log(response,"data")
        this.projectsData =  JSON.parse(response.data.body);
        })
      }
    },
    mounted () {
//      this.getAllProject()
      this.getAllClients();
    },
  };
</script>
<style></style>
