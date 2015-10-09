<?php

/* Simple php echo page for software programming exercise 1 
   Copyright Stephen Barrett

   You should have your client open a socket connection to port 80 of this site and attempt to
   send text with the following shape:

   GET /%7eebarrett/lectures/cs4032/echo.php HTTP1.0\r\n

   If you are running a local server (such as php -S localhost:8000) then it would be something like:

   GET /echo.php HTTP1.0\r\n
   
   Different programming languages have different library support for sending http requests.
   Don't use these! Use a raw TCP socket and send the string form above, read the response (a line)
   and close.
   
   (see http://www.w3.org/Protocols/rfc2616/rfc2616.html for details of the HTTP/1.1 protocol)

    You should print out the server response to the terminal. 
*/

//      ini_set('display_errors', 'On');
//      error_reporting(E_ALL | E_STRICT);
      if(isset($_GET['source'])) {
        if ($_GET['source'] == "raw")
           echo file_get_contents(basename($_SERVER['PHP_SELF']));
        else
           echo "<pre>" . htmlspecialchars(file_get_contents(basename($_SERVER['PHP_SELF']))) . "</pre>";
      } else if (isset($_GET['message'])){
      		 echo strtoupper( htmlspecialchars($_GET['message'])) . '\n';
      } else {
?>
      <html>
        <head>
          <title>Whoops: no message for me?</title>
        </head>
        <body>
          <h1>Whoops: no message for me?</h1>
          <p>If you are seeing this page then you have managed to call the echo server without
          sending a parameter. Well done on getting this far, but now try to work out how to send
          a text string to be converted to uppercase</p>
        </body>
      </html>
<?php
      }
?>
