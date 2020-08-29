<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Helper{

function sendMail($to,$subject,$body){	
$CI =& get_instance();
			 $emailid=$to['email'];//'satyamchinnarao@gmail.com';
			$name=$to['name'];		//	echo $emailid;
			$CI->load->view('mail/class_phpmailer');
			$CI->load->view('mail/class_smtp');
			 $CI->load->library('email');		
			$mailhead='<html><head>';		
			$mailhead.='<link rel="stylesheet" type="text/css" media="screen" href="'.base_url().'css/bootstrap.min.css">';				$mailhead.='<link rel="stylesheet" type="text/css" media="screen" href="'.base_url().'css/font-awesome.min.css">';				$mailhead.='<link rel="stylesheet" type="text/css" media="screen" href="'.base_url().'css/ctrls_style.css">';				$mailhead.='</head>';				$mailfoot="<br>This is an auto-generated e-mail.Hence don't reply to this e-mail.</body></html>";			$body=$mailhead.'<body ><div style="min-width:600px;min-height:600px;background-color:#F9F9F9;border:10px 10px 10px 10px;"><div style="margin:10px 10px 10px 10px;"><img src="'.base_url().'images/maillogo.png" alt="Ctrl4C" stle="background-color:green;" ></div><br>'.$body.'</div></body>'.$mailfoot;
			$to=$emailid;
			$fullname=$name;
			$from = 'noreply@myapp.in';			
			$CI->mail = new PHPMailer();
			$subject =$subject;//'Company Registration Conformation';
			$body=$body;
            $CI->mail->From = $from;
 			$CI->mail->addAddress($to, $name);
			$CI->mail->addAddress('satyamchinnarao@gmail.com', 'Alert');/* for temp setting only test */
			//$mail->addAddress('satyamchinnarao@gmail.com', 'Support');
			 $CI->mail->Subject = $subject;
			$CI->mail->Body    = $body;
            $CI->mail->IsHTML(true);
            $CI->mail->send();
			 /*if(!$CI->mail->send())
			{
				echo 'Message could not be sent.';
				echo 'Mailer Error: ' . $CI->mail->ErrorInfo;
				exit;
            } 
            */
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
}