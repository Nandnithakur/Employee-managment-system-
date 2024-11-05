<?php
$host = "localhost";
$user = "root"; // replace with your MySQL username
$password = "30June2004,"; // replace with your MySQL password
$database = "pro2"; // replace with your database name

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch all employees
if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['action']) && $_GET['action'] == 'fetchEmployees') {
    $sql = "SELECT * FROM Employees";
    $result = $conn->query($sql);

    $employees = [];
    while ($row = $result->fetch_assoc()) {
        $employees[] = $row;
    }
    echo json_encode($employees);
}

// Add new employee
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['action']) && $_GET['action'] == 'addEmployee') {
    $employee_id = $_POST['employee_id'];
    $name = $_POST['name'];
    $contact_details = $_POST['contact_details'];
    $department = $_POST['department'];
    $designation = $_POST['designation'];

    $stmt = $conn->prepare("INSERT INTO Employees (employee_id, name, contact_details, department, designation) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("issss", $employee_id, $name, $contact_details, $department, $designation);
    if ($stmt->execute()) {
        echo "Employee added successfully!";
    } else {
        echo "Error: " . $stmt->error;
    }
    $stmt->close();
}

$conn->close();
?>
