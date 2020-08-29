<template>
  <div>
       <!-- BootstrapVue Done -->
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
      <!-- Card stats -->
      <b-row>

      </b-row>
    </base-header>

    <b-container fluid class="mt--7">
        <b-row>
        <b-col>
          <light-table :projects="projectsData"/>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
  import Vue from 'vue'
  import LightTable from "./Tables/RegularTables/LightTable";

  import VueClipboard from 'vue-clipboard2'
  import BaseHeader from '@/components/BaseHeader';
  import APISERVIVCE from '@/service/apiServices.js'

  Vue.use(VueClipboard)
  export default {
    name: 'icons',
    components: {
      BaseHeader,
      LightTable,

    },
    data() {
      return {
        projectsData: {}
      }
    },
    methods: {
      onCopy() {
        this.$notify({
          type: 'info',
          message: 'Copied to clipboard'
        })
      }
    },
    mounted () {
    APISERVIVCE.getAllUsers().then(response=>{
console.log(response,"data")
      this.projectsData =  JSON.parse(response.data.body);
    })
    },
  };
</script>
<style></style>
