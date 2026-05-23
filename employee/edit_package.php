<?php
$page_title = 'Edit Package';
require_once 'includes/header.php';
require_once '../db.php';

$id = (int)($_GET['id'] ?? 0);
$row = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM tbl_packages WHERE package_id = $id"));
if (!$row) { header("Location: packages.php"); exit(); }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = $_POST['package_name'];
    $desc = $_POST['description'];
    $price = (float)$_POST['price'];
    $inclusions = $_POST['inclusion_details'];
    $sql = "UPDATE tbl_packages SET package_name='$name', description='$desc', price=$price, inclusion_details='$inclusions' WHERE package_id = $id";
    if (mysqli_query($conn, $sql)) {
        $action = "Updated package: $name (ID: $id)";
        mysqli_query($conn, "INSERT INTO tbl_logs (user_id, action, datetime) VALUES ({$_SESSION['user_id']}, '$action', NOW())");
        header("Location: packages.php?msg=updated");
        exit();
    }
}
?>
<?php include 'includes/sidebar.php'; ?>
<div class="main-content">
    <div class="page-header"><h1>Edit Package</h1><p>Update package details</p></div>
    <div class="form-card card">
        <div class="card-header"><h2>Package Details</h2></div>
        <div class="card-body">
            <form method="POST" action="">
                <div class="mb-3"><label for="package_name" class="form-label">Package Name</label><input type="text" class="form-control" id="package_name" name="package_name" required value="<?= htmlspecialchars($row['package_name']) ?>"></div>
                <div class="mb-3"><label for="description" class="form-label">Description</label><textarea class="form-control" id="description" name="description" rows="3"><?= htmlspecialchars($row['description']) ?></textarea></div>
                <div class="mb-3"><label for="price" class="form-label">Price (₱)</label><input type="number" class="form-control" id="price" name="price" step="0.01" min="0" required value="<?= $row['price'] ?>"></div>
                <div class="mb-4"><label for="inclusion_details" class="form-label">Inclusion Details</label><textarea class="form-control" id="inclusion_details" name="inclusion_details" rows="3"><?= htmlspecialchars($row['inclusion_details']) ?></textarea></div>
                <div class="d-flex gap-2"><button type="submit" class="btn btn-primary">Update Package</button><a href="packages.php" class="btn btn-outline-secondary">Cancel</a></div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
