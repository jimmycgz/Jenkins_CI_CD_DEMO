<?php
session_start();
	if(!isset($_SESSION['login'])){
	    $_SESSION['RedirectKe']=$_SERVER['REQUEST_URI'];
	    #ob_start();
	    header('location: login.php');
	    #ob_end_fluch();

	  }

	$session_ID=$_SERVER['REQUEST_URI'];
	$session_usr=$str_name;
	//$session_usr=$_SESSION['userlogin'];

		
		// define variables and set to empty values
		 $nameErr = $phoneErr = "";
		 $str_name = $str_phone = "";
		
?>

<html>
	<head>
		<title>DEMO for AWS Web Service</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		<style>
			 .error {color: #FF0000;}
		</style>
	</head>
   
	<body> 
	
		<div id="main">
		       <?php
			  print "<center> <h3 style='background-color:lightblue'> Welcome ".$session_usr. " ! &emsp; Use Below Form to Add Contact to RDS DB </h3></center> ";
			//print "<center> <h3 style='background-color:lightblue'> Welcome ".$session_usr. " ! Session ID:". $session_ID . "&emsp; Use Below Form to Add Contact to RDS DB </h3></center> ";

			?>
			
 
			<div id="style_form">
				<h2>Input Form</h2>
				<hr/>
					
				<form method = "POST" action = "">
					<label>Contact Name :</label>
					<input type="text" name="input_name" id="style_text_input" required="required" placeholder="Enter Name"/><br/><br />
					<label>Phone No. :</label>
					<input type="text" name="input_phone" id="style_text_input" required="required" placeholder="Phone Number"/><br/><br />
					<input type="submit" name="input_submit"  value=" Add to DB " id="style_submit"/><br />
				</form>
			</div>
		</div>

	<?php
	  //Get string values from new web form for DB access"
	   
         	

	   // "Get web form data "

	//if($str_name!="" AND $str_phone!="") {
	//if ($_SERVER["REQUEST_METHOD"] == "POST") {
	if (isset($_POST['input_submit']) AND isset($_POST['input_name']) ) {	
		
							    
		//Retrieve the field values from the input form.
		$str_name = test_input($_POST["input_name"]);
		$str_phone = test_input($_POST["input_phone"]);

	} // end if Server request

	function test_input($data) {
	    $data = trim($data);
	    $data = stripslashes($data);
	    $data = htmlspecialchars($data);
	    return $data;

	//end of function
	}
		 
	   // Get contact name and phone from Web Form
      ?> 
	
		
		
		
	<?php
		//connect to DB, add the new contact data to DB.
	   //include "connect_db.php";
		$db_host = "mysql:host=jmy-rds1.cztbwmvwkgvf.ca-central-1.rds.amazonaws.com;dbname=Jmy_Demo_DB";
		$db_name = "Jmy_Demo_DB";
		$db_user = "Jmy_RDS_Admin";
		$db_pass = "jdemo-aws-2088"; 
		$err_message="";

		$options = array(
		PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
		);
		
	if($str_name!="" AND $str_phone!="" AND isset($_POST["input_name"])) {
	//Insert a new contact record to DB if ALL of the values are not empty
		
		//set false value to below viable. to avoid repeat add the old value by refresh				    
	   	unset($_POST['input_name']);
				
	try{
	  
	  $db_connect = new PDO($db_host,$db_user,$db_pass, $options);
	  	  
	  // set the PDO error mode to exception
	  $db_connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	  
		// Delete 15 rows of data to keep showing the other rows on the screen
		//$sql_query = "DELETE FROM Address_book LIMIT 37";
		//$db_connect->exec($sql_query);
		
	  
		//These two fields can't be empty since they are required in the above form
		$sql_query = "INSERT INTO Address_book (Contact_Name, Contact_Phone) VALUES ('$str_name','$str_phone')";
		//$sql_query = "SELECT User_Name, User_Pwd FROM User_table WHERE User_Name='jimmycgz' AND User_Pwd='9900'";
		// echo "<br>" . "Query Line =" .$sql_query. "<br>";	

		//$QQ_State=$db_connect->prepare($sql_query);
		//$db_connect->execute($sql_query);
		$db_connect->exec($sql_query);
		
		echo "<div style='width:530px; padding:0;margin:0 auto;'>";
		echo "<center><h3><br> Contact List</h3>";	
		echo "Find The New Added Contact At The Last Row <br></center></div>";   

		//list the table data
		$stmval = $db_connect -> prepare("SELECT * FROM Address_book" );
		$stmval -> execute();
		$Qry_result=$stmval ->fetchAll();

		echo "<table id=style_table>";  //use table style pre-defined in css
		echo "<tr>";
			//list the table head
			echo " <th>ID</th>";
			echo " <th>Contact_Name</th>";
			echo " <th>Phone</th>";
		echo "</tr>";
	
		//list all records
		foreach($Qry_result as $Q_row) {
			echo "<tr>";
				echo "<td>".$Q_row['Contact_ID']."</td>";
				echo "<td>".$Q_row['Contact_Name']."</td>";
				echo "<td>".$Q_row['Contact_Phone']."</td>";
			echo "</tr>";
			}
		echo "</table>";
	
	}  //try
	
	
	//header("location:update_db.php"); 
	
	catch(PDOException $e)  {
		echo "<br>"."Error found: ".$e->getMessage()."<br>";
	}
	
	$db_connect = null;
	
	//if($str_name!="" AND $str_phone!="")
	}

	// Update to DB and list contacts
	?> 
     
      
	</body>
</html>
