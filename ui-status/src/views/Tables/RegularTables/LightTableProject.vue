<template>

    <b-card no-body>
       <b-card-header class="border-0">
             
      <b-button type="submit" variant="primary" @click="addproject()">Add Project</b-button>
      <b-button type="submit" variant="primary" @click="addprojectStatus()">Project Status</b-button>
     
       </b-card-header>
        <b-card-header class="border-0">
            <h3 class="mb-0">User details </h3>
                    
        </b-card-header>
        
        <el-table class="table-responsive table"
                  header-row-class-name="thead-light"
                  :data="projects">
           <el-table-column label="Name"
                             prop="project_name"
                             min-width="240px">
            </el-table-column>

            <el-table-column label="Client"
                             min-width="170px"
                             prop="client_id">
            </el-table-column>

            <el-table-column label="Description"
                             prop="project_desc"
                             min-width="240px">
                            
            </el-table-column>
        </el-table>

        <b-card-footer class="py-4 d-flex justify-content-end">
            <base-pagination v-model="currentPage" :per-page="1" :total="projects.length"></base-pagination>
        </b-card-footer>
            
      <modal :show.sync="modals.classic" headerClasses="justify-content-center">
        <h4 slot="header" class="title title-up">Modal title</h4>
        <p>Do You want to delete</p>
        <template slot="footer">
          <b-button>Nice Button</b-button>
          <b-button type="danger" @click="modals.classic = false">Close</b-button>
        </template>
      </modal>
    </b-card>
</template>
<script>
//  import projects from './../projects'
  import { Table, TableColumn} from 'element-ui'
import { BaseNav, Modal } from '@/components';

  export default {
    name: 'light-table-project',
    components: {
      [Table.name]: Table,
      [TableColumn.name]: TableColumn,
      Modal
    },
    props: {
        projects: {
            type: [Object, Array]
        }
    },
    data() {
      return {
        currentPage: 1,
        modals: {
            classic: false
          }
      };
    },
    methods: {
        deteteData(id) {
            this.modals.classic = true
            console.log(id, "idd")
        },
        projectStatus(id) {
            this.$router.push({name: 'projectstatus', params: {id: id}})
            console.log(id, "idd")
        },
        addproject(){
          this.$router.push("addproject");
        },
        addprojectStatus() {
          this.$router.push("/projectstatus")
        }
    },
  }
</script>
