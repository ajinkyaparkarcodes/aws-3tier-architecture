#!/bin/bash
yum update -y
yum install -y httpd php
systemctl start httpd
systemctl enable httpd

cat << 'EOF' > /var/www/html/index.php
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>3-Tier Architecture Demo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container text-center mt-5">
<h1 class="mb-4">Welcome to the Web Tier</h1>
<div class="card shadow p-4">
<h4>App Tier Response</h4>
<p class="mt-3 text-success fw-bold">
<?php
$response = @file_get_contents('http://Your-ALB-Name/api/test');
if ($response === FALSE) {
echo '<span class="text-danger">Unable to reach App Tier.</span>';
} else {
echo "Response from App: " . htmlspecialchars($response);
}
?>
</p>
</div>
</div>
</body>
</html>
EOF
