<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require APPPATH . 'libraries/REST_Controller.php';


class Client extends REST_Controller {

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
    public function isClientAvailable($name){
		try{
			$nameExist = $this->db->get_where("clients",['client_name'=> $name])->row_array();
		    return $nameExist ? false : true;
		}
		catch(Exception $e) {
			echo $e;
		}
	}
    //adding projects
    public function addClient_post() {
		header("Access-Control-Allow-Origin: *");
        try {
            if(!$this->post('name')){
				$this->response("please enter project name", REST_Controller::HTTP_UNAUTHORIZED);
			} else{
                $isProjectCheck = $this->isClientAvailable($this->post('name'));
				 if($isProjectCheck) {
					$param = ['client_name' => $this->post('name')];
					$data = $this->db->insert('clients',$param);
					if($data){
                        $lastInsertedData = $this->db->get_where("clients",['client_name'=> $this->post('name')] )->row_array();
						$this->response($this->helper->generateResponse($lastInsertedData,true, '200'), REST_Controller::HTTP_OK);                 
                    }else {
						$this->response($this->helper->generateResponse("sss",true, '200'), REST_Controller::HTTP_OK);                 

					}
                }else {
					$this->response($this->helper->generateResponse(null,false, '401', "Client Already Exist"), REST_Controller::HTTP_UNAUTHORIZED); 

				}
            }

        } Catch(Exception $e){}
    }
    public function getAllClients_get() {
        $sql = "SELECT * FROM clients";
		$query = $this->db->query($sql);
		if ($query->num_rows() > 0) {
			$data =  $query->result_array();
			$this->response($this->helper->generateResponse($data,true, '200'), REST_Controller::HTTP_OK);
		}
    }
}