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
          <light-table-clients :projects="clientsData"/>
        </b-col>
    
    </b-container>
  </div>
</template>
<script>
  import Vue from 'vue'
  import LightTableClients from "@/views/Tables/RegularTables/LightTableClients";
  import VueClipboard from 'vue-clipboard2'
  import BaseHeader from '@/components/BaseHeader';
  import APISERVIVCE from '@/service/apiServices.js'

  Vue.use(VueClipboard)
  export default {
    name: 'Adduser',
    components: {
      BaseHeader,
      LightTableClients,

    },
    data() {
      return {
        clientsData: {},
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
      addClient() {
        APISERVIVCE.addClient(this.model).then(response=>{
        this.$router.push("/clients");
         }).catch(err=> console.log(err.response))
      },
      getAllClients(){
        APISERVIVCE.getAllClient().then(response=>{
        console.log(response,"data")
        this.clientsData =  JSON.parse(response.data.body);
    })
      }
    },
    mounted () {
      this.getAllClients()
    },
  };
</script>
<style></style>
