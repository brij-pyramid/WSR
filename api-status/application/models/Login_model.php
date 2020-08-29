<?php

class login_model extends CI_Model {
    function __construct()
    {
        // Call the Model constructor
        parent::__construct();
    }
function login($username,$password)
	{
        $param = ['username' => $username, 'password'=>md5($password)];
        $data = $this->db->get_where("fm_user",$param )->row_array();
		return $data;

    }
    function getAlluser() {
        $sql = "SELECT * FROM fm_user";
        $query = $this->db->query($sql);
        if ($query->num_rows() > 0) {
         return $data =  $query->result_array();
        }
        return 0;
    }
}