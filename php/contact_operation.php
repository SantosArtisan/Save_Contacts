
  <?php
  session_start();
  include 'config/cbt_db.php';
  
  	// API REQUEST
	$_SESSION['request'] = $_POST['request'];
	

	//Saving User Record
	if ($_SESSION['request'] == "ADD USER") {
		# code...

        $fname = $_POST['userFname'];
        $sname = $_POST['userSname'];
        $mname = $_POST['userMname'];
        $email = $_POST['email'];
        $phone = $_POST['phone'];
        $password = $_POST['password'];
        $pic = $_FILES['image']['name'];
        $imagePath = 'contact_uploads/'.$pic;
        $tmp_name = $_FILES['image']['tmp_name'];
        move_uploaded_file($tmp_name, $imagePath);



        $sql1 = "INSERT INTO user (user_fname, user_sname, user_mname, email, phone, password, picture) VALUES('$fname', '$sname', '$mname', '$email', '$phone', '$password', '$pic')";

        $result1 = mysqli_query($connection, $sql1);

    }
    
    
    //Saving User Contacts
	if ($_SESSION['request'] == "ADD CONTACT") {
		# code...

        $cname = $_POST['cName'];
        $cno = $_POST['cNo'];
        $caddress = $_POST['cAddress'];
        $cemail = $_POST['cEmail'];
        $user = $_POST['user'];
        $pic = $_FILES['image']['name'];
        $imagePath = 'contact_uploads/'.$pic;
        $tmp_name = $_FILES['image']['tmp_name'];
        move_uploaded_file($tmp_name, $imagePath);



        $sql1 = "INSERT INTO contacts (contact_name, contact_no, contact_address, contact_email, contact_picture, user_id) VALUES('$cname', '$cno', '$caddress', '$cemail', '$pic', '$user')";

        $result1 = mysqli_query($connection, $sql1);

    }
    
                    //User Login
	        	if ($_SESSION['request'] == "USER LOGIN") {
	        		# code...

		            $email = $_POST['email'];
		            $password = $_POST['password'];

			         $sql= mysqli_query($connection,"SELECT * FROM user WHERE email='$email' AND password='$password'");


                     $result=array();
                
                     while($row=mysqli_fetch_assoc($sql))
                      {
                        
                      $result[]=$row;
                    
                      }
                
                      header('Content-Type: application/json');
                      echo json_encode($result);

			    }
			    
			    
			    //Fetch Contact by User ID  from the Database
	        	if ($_SESSION['request'] == "GET CONTACT") {
                    
                    $user=$_POST['id'];
			        $query = "SELECT * FROM contacts WHERE contact_id = '$user'  ";
			        $result = mysqli_query($connection, $query);
			        $data = array();
			        while ($row = mysqli_fetch_assoc($result)) {
			        	$data[] = $row;
			        }
			        
			        header('Content-type: applicatio/json');
			        print(json_encode($data));
	        	}
	        	
	        	
	        		//Search Contact from the Database
	        	if ($_SESSION['request'] == "SEARCH CONTACTS") {

	        		$search = $_POST['search'];
	        		$user=$_POST['user'];
			        $query7 = "SELECT * FROM contacts 
			        WHERE    user_id = '$user'    AND  contact_name LIKE '%$search%'
";
			        $result7 = mysqli_query($connection, $query7);
			        $data = array();
			        while ($row = mysqli_fetch_assoc($result7)) {
			        	
			        	$data[] = $row;
			        }
			        
			        header('Content-type: applicatio/json');
			        print(json_encode($data));
	        	}
	        	
	        	
	        	//Delete Contact from the Database
	        	if ($_SESSION['request'] == "DELETE CONTACT") {

	        		$id = $_POST['id'];
			        $query15 = "DELETE FROM contacts WHERE contact_id = '$id'";
			        $result15 = mysqli_query($connection, $query15);
	        	}
	        	
	        	

  
  ?>