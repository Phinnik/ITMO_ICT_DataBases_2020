<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	</head>
	<body style=>
		<h3>Удаляeм пациента</h3>
		<ul>
			<form name="delete" action="delete.php" method="POST" >
				<ul>ID пациента:</ul><ul><input type="text" name="patient_id"/></ul>
				<ul><input type="submit" name="delete" /></ul>
			</form>
		</ul>
	</body>
</html>



<?php

$connect = pg_connect("host=localhost port=5432 dbname=ClinicDB user=postgres password=1708");
$delete = '"ClinicDB"."MedicalFiles"';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	if (isset($_POST["delete"])) {
        $q = "DELETE FROM $delete WHERE \"patient_id\"='$_POST[patient_id]'";
        $cur = pg_query($q);
		$all = pg_fetch_all($cur);
		pg_close($connect);
    }
}

$connect = pg_connect("host=localhost port=5432 dbname=ClinicDB user=postgres password=1708");
$q = "SELECT * FROM $delete";
$cur = pg_query($connect, $q);
$all = pg_fetch_all($cur);
foreach ($all as $value) {
	foreach ($value as $key => $value) {
		echo "$key: $value <br/>";
	}
	echo "<br><br>";
};
?>