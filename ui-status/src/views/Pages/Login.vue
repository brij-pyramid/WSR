<template>
  <div>
    <!-- Header -->
    <div class="header bg-gradient-success py-7 py-lg-8 pt-lg-9">
      <b-container>
        <div class="header-body text-center mb-7">
          <b-row class="justify-content-center">
            
              <h1 class="text-white">Welcome!</h1>
          
          </b-row>
        </div>
      </b-container>
      <div class="separator separator-bottom separator-skew zindex-100">
        <svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none" version="1.1"
             xmlns="http://www.w3.org/2000/svg">
          <polygon class="fill-default" points="2560 0 2560 100 0 100"></polygon>
        </svg>
      </div>
    </div>
    <!-- Page content -->
    <b-container class="mt--8 pb-5">
      <b-row class="justify-content-center">
        <b-col lg="5" md="7">
          <b-card no-body class="bg-secondary border-0 mb-0">
            <span style="text-align: center;
    margin-top: 0.25rem;
    font-size: 80%;
    color: #fb6340;" v-if="error">{{error}}</span>
            <b-card-body class="px-lg-5 py-lg-5">
                   <base-input alternative
                              class="mb-3"
                              name="Email"
                              :rules="{required: true, email: true}"
                              prepend-icon="ni ni-email-83"
                              placeholder="Email"
                              v-model="model.username">
                  </base-input>

                  <base-input alternative
                              class="mb-3"
                              name="Password"
                              :rules="{required: true, min: 6}"
                              prepend-icon="ni ni-lock-circle-open"
                              type="password"
                              v-on:keypress.enter="login"
                              placeholder="Password"
                              v-model="model.password">
                  </base-input>

                   <div class="text-center">
                    <base-button type="primary" @click="login" native-type="submit" :disabled=isbuttonValid class="my-4">Sign in</base-button>
                  </div>
            </b-card-body>
          </b-card>
          <div class="row mt-3">
            <div class="col-6 text-right"><router-link to="/register" class="text-light" ><small>Create new account</small></router-link></div></div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import APISERVICE from '@/service/apiServices'
import { mapGetters } from "vuex";

  export default {
    data() {
      return {
        model: {
          username: 'satyamchinna4u@gmail.com',
          password: 'satyam',
         },
        userData: [],
        error: null
      };
    },
    methods: {
      onSubmit() {
        // this will be called only after form is valid. You can do api call here to login
      },
      login(){
      this.$store
        .dispatch('login', this.model)
        .then(() => {
          this.$router.push({ name: 'dashboard' })
        }).catch(err=>{
          this.error = err.response.data.error 
          console.log(err.response.data)})
      },
      redirecttoRegister() {
        this.$
      }
    },
    computed: {
      isbuttonValid() {
        return this.model.username == "" || this.model.password == ""; 
      },
       ...mapGetters(["loggedIn"])
    },
    mounted () {
       if(this.loggedIn){
          this.$router.push("/dashboard")
      };
    },
  };
</script>
