<template>
  <div>
       <!-- BootstrapVue Done -->
    <base-header class="pb-6 pb-8 pt-5 pt-md-8 bg-gradient-success">
      <!-- Card stats -->
      <b-row>

      </b-row>
    </base-header>

 <b-container class="mt--8 pb-5">
      <!-- Table -->
      <b-row class="justify-content-center">
        <b-col lg="6" md="8" >
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

                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-email-83"
                              placeholder="Email"
                              name="Email"
                              :rules="{required: true, email: true}"
                              v-model="model.email">
                  </base-input>
                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-mobile-button"
                              placeholder="mobile"
                              name="Mobile"
                              :rules="{required: true, min: 10}"
                              v-model="model.mobile">
                  </base-input>
                  <base-input alternative
                              class="mb-3"
                              prepend-icon="ni ni-lock-circle-open"
                              placeholder="password"
                              type="password"
                              name="Password"
                              :rules="{required: true, min: 6}"
                              v-model="model.password">
                  </base-input>
                                    <b-row class=" my-4">
                    <!--b-col cols="12">
                      <base-input :rules="{ required: { allowFalse: false } }" name=Privacy Policy>
                        <b-form-checkbox v-model="model.agree">
                          <span class="text-muted">I agree with the <a href="#!">Privacy Policy</a></span>
                        </b-form-checkbox>
                      </base-input>
                    </b-col-->
                  </b-row>
                  <div class="text-center">
                    <b-button type="submit" variant="primary" class="mt-4" @click="createAccount()">Create account</b-button>
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
  import LightTable from "./Tables/RegularTables/LightTable";

  import VueClipboard from 'vue-clipboard2'
  import BaseHeader from '@/components/BaseHeader';
  import APISERVIVCE from '@/service/apiServices.js'

  Vue.use(VueClipboard)
  export default {
    name: 'Adduser',
    components: {
      BaseHeader,
      LightTable,

    },
    data() {
      return {
        projectsData: {},
        error:"",
        model: {
          name: '',
          email: '',
          password: '',
          mobile: ''
        },
      }
    },
    methods: {
      onCopy() {
        this.$notify({
          type: 'info',
          message: 'Copied to clipboard'
        })
      },
     createAccount(){
      this.$store
        .dispatch('register', this.model)
        .then(() => {
          this.$router.push({ name: 'user' })
        }).catch(err=>{
          this.error = err.response.data.error 
          console.log(err.response.data)})
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
