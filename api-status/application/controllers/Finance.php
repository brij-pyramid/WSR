<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . 'libraries/REST_Controller.php';


class Finance extends REST_Controller {

	public function index_get()
	{
		$data = ["Invalid Request"];
		$this->response($data, REST_Controller::HTTP_OK);
	}
	public function getallexpenditure_get($id = 0){
		$data = $this->db->get_where("fm_expenditure", ['user_id' => $id])->result();
		$this->response($data, REST_Controller::HTTP_OK);
	}
	public function getallsavings_get($id = 0){
		$data = $this->db->get_where("fm_saving", ['user_id' => $id])->result();
		$this->response($data, REST_Controller::HTTP_OK);
	}
	public function gettotalincome_get($id = 0){
		$data = $this->db->get_where("fm_totalincome", ['user_id' => $id])->result();
		$this->response($data, REST_Controller::HTTP_OK);
	}
	public function insertexpenditure_post(){
		try {
			$input = $this->input->post();
			$this->db->insert('fm_expenditure',$input);
			$this->response("Successfully Inserted the Expenditure", REST_Controller::HTTP_OK);
		}
		catch(Exception $e) {
			$this->response("invalid Request"+ $e.getMessage(), REST_Controller::HTTP_OK);
		}
	}
	public function inserttotalincome_post(){
		try{
			$input = $this->input->post();
			$this->db->insert('fm_totalincome',$input);
			$this->response("Successfully Inserted the income", REST_Controller::HTTP_OK);
		}
		catch(Exception $e) {
			$this->response("invalid Request"+ $e.getMessage(), REST_Controller::HTTP_OK);
		}
	}
	public function insertsaving_post(){
		try{
				$input = $this->input->post();
				$this->db->insert('fm_saving',$input);
				$this->response("Successfully Inserted the Savings", REST_Controller::HTTP_OK);
		} catch(Exception $e)
		{
			$this->response("invalid Request"+ $e.getMessage(), REST_Controller::HTTP_OK);
		
		}
			}
	
}