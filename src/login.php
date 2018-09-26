<?php
session_start();
ob_start();
$str_name=$str_pass=0;
?>


<html>
<head>
<title>DEMO for AWS Web Service</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
  

  
<div id="main" >
<h2> DEMO Website Built by PHP with RDS DB ----Version 4.10 </h2>
<div id="style_login">
<h2>User Login</h2>
<hr/>
  

  <form action="" method="post" >
	<label> User Name :</label>

	<input type="text" name="input_name" id="style_text_input" required="required" placeholder=""/><br/><br />
	<label> Password :</label>
	<input type="password" name="input_pwd" id="style_password" required="required" placeholder=""/> <br/><br /> 
	<input type="submit" value=" Submit " name="submit" id="style_submit"/><br />
	</form>

</div>

</div>
<div id="style_footer" >
  <footer>
    <p>Developed by: Jimmy CUI ...May 2018</p>
    <p>Email: <a href="mailto:jimmycgz@gmail.com">jimmycgz@gmail.com</a></p> 
	<BR>
	<p>* Deployed the code to Dev Server, then Built Prod repo to S3 Bucket by Jenkins Pipelines</p> 
	<p>* May 12th: Integrated with Bitbucket Private repo successfully through 2 Jenkins Projects</p> 
	<p>* May 13th: Built and deployed successfully to GCP instances from S3 Bucket to containers</p> 
	<p>* May 18th: Integrated Jenkins & Ansible to trigger DEMO_Website Deployment to GCP instances</p> 
  
	</footer>
</div>

  
<?php
	  
  //Retrieve the field values from our registration form.
    $str_name = !empty($_POST['input_name']) ? trim($_POST['input_name']) : null;
    $str_pass = !empty($_POST['input_pwd']) ? trim($_POST['input_pwd']) : null;
    //echo "UserName: " . $str_name;
   // echo "Password: " . $str_pass;
	
    
if($str_name!="" AND $str_pass!="") {
  
	  //include "connect_db.php";
	    $db_host = "mysql:host=jmy-rds1.cztbwmvwkgvf.ca-central-1.rds.amazonaws.com;dbname=Jmy_Demo_DB";
	    $db_name = "Jmy_Demo_DB";
	    $db_user = "hash_algos*****";
	    $db_pass = "hash_algos******";
	    $err_message="";

	$options = array(
	PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
	);


try{
  
  $db_connect = new PDO($db_host,$db_user,$db_pass, $options);
  
  
  // set the PDO error mode to exception
  $db_connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  
  

  

    $sql_query = "SELECT User_Pwd FROM User_table WHERE User_Name='$str_name' AND User_Pwd='$str_pass'";
   //$sql_query = "SELECT User_Name, User_Pwd FROM User_table WHERE User_Name='jimmycgz' AND User_Pwd='9900'";
   
  $QQ_State=$db_connect->prepare($sql_query);
  $QQ_State->execute();
   
  $Row_count=$QQ_State->rowCount();
  //echo "<br>"."Find user account in Row No.:" . $Row_count."<br>";
  
  //$Row_count2 = $QQ_State->fetch(PDO::FETCH_ASSOC);   //this shows as Array
  //echo "<br>"."Find user account in Row No.:" . $Row_count2."<br>";
     
 if($Row_count>0) {
	 $_SESSION['login']=TRUE;
     # echo "<br>"."<br>"."Login Successfully. Welcome ".$str_name . " !";
     #sleep(3);
	#ob_start(); // don't goto below header until  all output got clearned by ob_end_clean()
	 	#default session name is update_db.php
	 	$URL =isset($_SESSION['RedirectKe']) ? $_SESSION['RedirectKe']: 'update_db.php';
	 	header('location:'.$URL. '');
      #		header("location: update_db.php");
	    ob_end_clean(); //now the headers are sent
	    #ob_end_flush(); //now the headers are sent

  }
  else{
    echo "<script type= 'text/javascript'>alert('Login failed ! Clik OK to Try Again.');</script>";
    die();
  }
    

  $db_connect = null;
  
  }  
  
  catch(PDOException $e)
  {
    echo "<br>"."Error found: ".$e->getMessage()."<br>";
  }
  
}
    
?>



</body>
  
</html>
