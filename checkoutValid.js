function validate(){

    var name = document.getElementById("name").value;
    var contact = document.getElementById("contact").value;
    var address = document.getElementById("address").value;
    var email = document.getElementById("mail").value;

    if(name=="")
    {   document.getElementById('error-container').innerHTML= "Name can't be empty!";
        return false;
    }

    if(!(/^[A-Za-z]+$/.test(name)))
    {   document.getElementById('error-container').innerHTML= "Enter alphabets only in name";
        return false;
    }

    if(email=="")
    { document.getElementById('error-container').innerHTML= "Enter Email";
        return false;
    }

    if(address=="")
    {   document.getElementById('error-container').innerHTML= "Address can't be empty!";
        return false;
    }

    if(contact=="")
    {   document.getElementById('error-container').innerHTML= "Enter Contact#";
        return false;
    }




}


function contactCheck(event){

    var keychar;
			
		keychar = event.key;
		if (((".+-0123456789").indexOf(keychar) > -1))
		   return true;
		else{
            document.getElementById('error-container').innerHTML = "Wrong Format!";
		   return false;
        }
}