<?php

session_start();

$role = $_SESSION['user_role'];
session_destroy();

if ($_SERVER['SERVER_ADDR'] == '::1' || $_SERVER['SERVER_ADDR'] == 'localhost' || $_SERVER['SERVER_ADDR'] == '127.0.0.1') {
    header('Location:index.php');
} else {
    if ($role == 76 || $role == 77) {
        header('Location:http://ncov.lmis.gov.pk');
        exit;
    } else {
        header('Location:http://lmis.gov.pk/index.php');
        exit;
    }
}
?>