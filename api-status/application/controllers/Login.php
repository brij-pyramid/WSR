<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require APPPATH . 'libraries/REST_Controller.php';


class Login extends REST_Controller {

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
	public function index()
	{
		if($this->input->post('admin_login')){
			//print_r($_POST);
						$username=$this->input->post('admin_username');
			$password=$this->input->post('admin_password');
			$params=array('username'=>$username,
				'password' => $password,
				'status'	=>1					
			);
			$query = $this->db->get_where('admin_user', $params)->result_array();
			//$response=$this->ctrl4c->callCURL('partnerLogin',$params);
			print_r($query);
			
			$data  = $query[0];
			$this->session->set_userdata($data);
			if($this->session->userdata('username')) {
				redirect('AdminHome');
			}
		}
		$this->load->view('login/login');
	}
	function generateResponse($data, $success,$status_code = '200',$errormessage="Invalid Request"){
		$response['status_code'] = $status_code;
		$response['body'] = json_encode($data);
		$response['success'] = $success;
		if(!$success){
		  $response['error'] = $errormessage;

		}

      return $response;
	}
	public function user_post() {
		header("Access-Control-Allow-Origin: *");
		try {
			if(!$this->post('username')){
				$this->response("please enter Username", REST_Controller::HTTP_UNAUTHORIZED);
			} else if(!$this->post('password')){
				$this->response("please enter Password", REST_Controller::HTTP_UNAUTHORIZED);
			}else {
			     $param = ['username' => $this->post('username'), 'password'=>md5($this->post('password'))];
			     $data = $this->db->get_where("sr_users",$param )->row_array();
			     if($data){
				     $this->response($this->helper->generateResponse($data,true, '200'), REST_Controller::HTTP_OK);
			    } else {
				      $this->response($this->helper->generateResponse($data,false,'401',"invalid Login, Please try again!")	, REST_Controller::HTTP_UNAUTHORIZED);
			      }
	        }
	    }
	    catch(Exception $e){
		    $this->response("invalid Login, Please try again!"+ $e.getMessage(), REST_Controller::HTTP_UNAUTHORIZED);
	    }
	}
	public function isUserEmailAvailable($email){
		try{
			$emailExist = $this->db->get_where("sr_users",['username'=> $email])->row_array();
		    return $emailExist ? false : true;
		}
		catch(Exception $e) {
			echo $e;
		}
	}
	public function register_post() {
	//	error_reporting(E_ALL);
		header("Access-Control-Allow-Origin: *");
		try {
			if(!$this->post('name')){
				$this->response("please enter name", REST_Controller::HTTP_UNAUTHORIZED);
			} else if(!$this->post('email')){
				$this->response("please enter email", REST_Controller::HTTP_UNAUTHORIZED);
			} else if(!$this->post('password')){
				$this->response("please enter Password", REST_Controller::HTTP_UNAUTHORIZED);
			} else if(!$this->post('mobile')){
				$this->response("please enter mobile", REST_Controller::HTTP_UNAUTHORIZED);
			}else {
			     $isEmailCheck = $this->isUserEmailAvailable($this->post('email'));
				 if($isEmailCheck) {
					$param = ['name' => $this->post('name'),'username' => $this->post('email'), 'password'=>md5($this->post('password'))];
					$data = $this->db->insert('sr_users',$param);
					if($data){
						$lastInsertedData = $this->db->get_where("sr_users",['username'=> $this->post('email')] )->row_array();
						$this->response($this->helper->generateResponse($lastInsertedData,true, '200'), REST_Controller::HTTP_OK);
						$body='Dear Customer ,  <br>Your Support Package has been upgraded<br><div style="margin-top:15px;"><table'.TABLESTYLE.' >';
						$body.='<tr '.TABLETRSTYLE.'><td>Name  : </td><th>'.$this->post('name').' Days </th>';
						$body.='<tr '.TABLETRSTYLE.'><td>Mobile  : </td><th>'.$this->post('mobile').'</th>';
						$body.='<tr '.TABLETRSTYLE.'><td>Password  : </td><th>'.$this->post('password').'</th>';
						$body.='';
						$body.='</table></div>';
						$to=array('email'=>$this->post('email'),'name'=>$this->post('name'));
						$this->helper->sendMail($to,'Registration Email',$body);
					} else {
						$this->response($this->helper->generateResponse($data, false,'401',"invalid Login, Please try again!")	, REST_Controller::HTTP_UNAUTHORIZED);
					}
				 } else {
					$this->response($this->helper->generateResponse(null,false, '401', "Email Already Exist"), REST_Controller::HTTP_UNAUTHORIZED); 
				 } 
	        }
	    }
	    catch(Exception $e){
		    $this->response("invalid Login, Please try again!"+ $e.getMessage(), REST_Controller::HTTP_UNAUTHORIZED);
	    }
	}
	public function getAll_get() { 
		$sql = "SELECT * FROM sr_users";
		$query = $this->db->query($sql);
		if ($query->num_rows() > 0) {
			$data =  $query->result_array();
			$this->response($this->helper->generateResponse($data,true, '200'), REST_Controller::HTTP_OK);
		}
	
	
	}
}
