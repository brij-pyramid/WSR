<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require APPPATH . 'libraries/REST_Controller.php';


class Project extends REST_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 * 		$this->load->library ( "ctrls" );
	 */
	function __construct() {
		// Call the Model constructor
		parent::__construct ();
		$this->load->model ( 'login_model' );
		$this->load->helper ( "url" );
		$this->load->library ( "helper" );
    }
    public function isProjectAvailable($name){
		try{
			$nameExist = $this->db->get_where("projects",['project_name'=> $name])->row_array();
		    return $nameExist ? false : true;
		}
		catch(Exception $e) {
			echo $e;
		}
    }
    public function isProjectStatusAvailable($id){
		try{
			$nameExist = $this->db->get_where("projects_status",['project_id'=> $id])->row_array();
		    return $nameExist ? false : true;
		}
		catch(Exception $e) {
			echo $e;
		}
	}
    //adding projects
    public function addProject_post() {
		header("Access-Control-Allow-Origin: *");
        try {
            if(!$this->post('name')){
				$this->response("please enter project name", REST_Controller::HTTP_UNAUTHORIZED);
			} else{
                $isProjectCheck = $this->isProjectAvailable($this->post('name'));
				 if($isProjectCheck) {
					$param = ['project_name' => $this->post('name'),"client_id"=>$this->post('client'),"project_desc"=>$this->post('desc')];
					$data = $this->db->insert('projects',$param);
					if($data){
                        $lastInsertedData = $this->db->get_where("projects",['project_name'=> $this->post('name')] )->row_array();
						$this->response($this->helper->generateResponse($lastInsertedData,true, '200'), REST_Controller::HTTP_OK);                 
                    }
                }
            }

        } Catch(Exception $e){

        }
    }
    public function getAllProject_get() {
        $sql = "SELECT * FROM projects";
		$query = $this->db->query($sql);
		if ($query->num_rows() > 0) {
			$data =  $query->result_array();
			$this->response($this->helper->generateResponse($data,true, '200'), REST_Controller::HTTP_OK);
		}
    }
    public function addProjectStatus_post(){
        header("Access-Control-Allow-Origin: *");
        try {
            if(!$this->post('project')){
				$this->response("please select project name", REST_Controller::HTTP_UNAUTHORIZED);
			} else{
               
				 if(true) {
                      $param = ['project_id' => $this->post('project'),
                      "date_id"=>$this->post('date_id')
                      ,"timeline"=>$this->post('timeline')
                      ,"quality"=>$this->post('quality')
                      ,"customer"=>$this->post('customer')
                      ,"resources"=>$this->post('resources')
                      ,"achivements"=>$this->post('achivements')
                      ,"update_comments"=>$this->post('comments')];
					$data = $this->db->insert('projects_status',$param);
					if($data){
                      $this->response($this->helper->generateResponse("Success",true, '200'), REST_Controller::HTTP_OK);                 
                }
            } else {
                $this->response($this->helper->generateResponse(null,false, '401', "Project Status Created"), REST_Controller::HTTP_UNAUTHORIZED); 
            }
            }

        } Catch(Exception $e){
            
        }
    }
    function getProjectStatus_post(){
        header("Access-Control-Allow-Origin: *");
        try {
            if(!$this->post()){
                
				$this->response("please select project name", REST_Controller::HTTP_UNAUTHORIZED);
			} else{
                $param = ['project_id' => $this->post('id')];
                 $data = $this->db->get_where("projects_status",$param )->row_array();
                 if($data){
                    $this->response($this->helper->generateResponse($data,true, '200'), REST_Controller::HTTP_OK);
               } else {
                     $this->response($this->helper->generateResponse($data,false,'401',"invalid request, Please try again!")	, REST_Controller::HTTP_UNAUTHORIZED);
                 }
            }

        } Catch(Exception $e){
            
        }
    }
    function addMilestone_post(){
        header("Access-Control-Allow-Origin: *");
        try {
            if(!$this->post()){
                
				$this->response("please select project name", REST_Controller::HTTP_UNAUTHORIZED);
			} else{
                $param = ['project_id' => $this->post('project'),"date_id"=>$this->post('date_id'),"milestone"=>$this->post('milestone')
                ,"plan_date	"=>$this->post('planneddate')
                ,"actual_date"=>$this->post('actualdate')];
                $data = $this->db->insert('projects_milestone',$param);
                 if($data){
                    $this->response($this->helper->generateResponse($data,true, '200'), REST_Controller::HTTP_OK);
               } else {
                     $this->response($this->helper->generateResponse($data,false,'401',"invalid request, Please try again!")	, REST_Controller::HTTP_UNAUTHORIZED);
                 }
            }

        } Catch(Exception $e){
            
        }
    } 

    function getProjectMilestone_post(){
        header("Access-Control-Allow-Origin: *");
        try {
            if(!$this->post()){
                
				$this->response("please select project name", REST_Controller::HTTP_UNAUTHORIZED);
			} else{
                $param = ['project_id' => $this->post('id')];
                 $data = $this->db->get_where("projects_milestone",$param )->row_array();
                 if($data){
                    $this->response($this->helper->generateResponse($data,true, '200'), REST_Controller::HTTP_OK);
               } else {
                     $this->response($this->helper->generateResponse($data,false,'401',"invalid request, Please try again!")	, REST_Controller::HTTP_UNAUTHORIZED);
                 }
            }

        } Catch(Exception $e){
            
        }
    }
}