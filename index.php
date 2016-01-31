<?php

/**
 * @link https://github.com/BTVIgnite/projectspace
 * @license http://opensource.org/licenses/MIT MIT License
 */

// checking for minimum PHP version
if (version_compare(PHP_VERSION, '5.3.7', '<')) {
    exit("Sorry, this site requires PHP version 5.3.7 or higher!");
} else if (version_compare(PHP_VERSION, '5.5.0', '<')) {
    // if you are using PHP 5.3 or PHP 5.4 you have to include the password_api_compatibility_library.php
    // (this library adds the PHP 5.5 password hashing functions to older versions of PHP)
    require_once("libraries/password_compatibility_library.php");
}

// include the configs
require_once("config/db.php");

// load the login class
require_once("classes/Login.php");

// create a login object.
$login = new Login();

// Check for login session
if ($login->isUserLoggedIn() == true) {
    // the user is logged in.
    include("views/logged_in.php");

} else {
    // the user is not logged in.
    include("views/not_logged_in.php");
}
