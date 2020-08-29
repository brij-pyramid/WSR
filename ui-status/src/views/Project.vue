<template>
  <div>
       <!-- BootstrapVue Done -->
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
      <!-- Card stats -->
      <b-row>
      </b-row>
    </base-header>

 <b-container class="mt--8 pb-5" >
      <!-- Table -->
        <b-col>
          <light-table-project :projects="projectsData"/>
        </b-col>
    
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
          name: ''
        },
        projectadded: false
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
        this.getAllProject()
         }).catch(err=> console.log(err.response))
      },
      getAllProject(){
        APISERVIVCE.getAllproject().then(response=>{
        console.log(response,"data")
        this.projectsData =  JSON.parse(response.data.body);
    })
      }
    },
    mounted () {
      this.getAllProject()
    },
  };
</script>
<style></style>
