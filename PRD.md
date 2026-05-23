# Product Requirements Document
## Resort Reservation System

**Stack:** PHP, Bootstrap 5, XAMPP (MySQL)
**Version:** 1.0
**Type:** Internal web application

---

## 1. Overview

A simple resort reservation system that lets admins and employees manage accommodations, amenities, packages, and reservations, while customers can browse rooms, packages, and make reservations. The system runs locally on XAMPP.

---

## 2. User Roles

### Admin
- Full access to all tables and pages
- Can add, edit, and view: Users, Accommodations, Amenities, Packages, Reservations, Logs

### Employee
- Same as admin but cannot see the Users table or Logs table
- The employee sidebar is a copy of the admin sidebar with the Users and Logs links removed
- Responsible for approving or rejecting reservations

### Customer
- Can browse available accommodations and packages
- Can make a reservation
- Can view their own reservation history and status

---

## 3. Database Tables

### tbl_users
| Column | Type | Notes |
|---|---|---|
| user_id | INT, PK, AUTO_INCREMENT | |
| full_name | VARCHAR(100) | |
| role | ENUM('admin','employee','customer') | |
| username | VARCHAR(50) | |
| password | VARCHAR(255) | Use password_hash() |
| email | VARCHAR(100) | |

### tbl_logs
| Column | Type | Notes |
|---|---|---|
| log_id | INT, PK, AUTO_INCREMENT | |
| user_id | INT, FK → tbl_users | |
| action | TEXT | |
| datetime | DATETIME | |

### tbl_accommodations
| Column | Type | Notes |
|---|---|---|
| accommodation_id | INT, PK, AUTO_INCREMENT | |
| accommodation_name | VARCHAR(100) | |
| description | TEXT | |
| capacity | INT | |
| price_per_night | DECIMAL(10,2) | |
| availability_status | ENUM('available','unavailable') | |

### tbl_amenities
| Column | Type | Notes |
|---|---|---|
| amenity_id | INT, PK, AUTO_INCREMENT | |
| amenity_name | VARCHAR(100) | |
| description | TEXT | |
| price_per_use | DECIMAL(10,2) | |

### tbl_reservations
| Column | Type | Notes |
|---|---|---|
| reservation_id | INT, PK, AUTO_INCREMENT | |
| user_id | INT, FK → tbl_users | |
| accommodation_id | INT, FK → tbl_accommodations | |
| check_in_date | DATE | |
| check_out_date | DATE | |
| total_price | DECIMAL(10,2) | |
| reservation_status | ENUM('pending','approved','rejected','cancelled') | |

### tbl_packages
| Column | Type | Notes |
|---|---|---|
| package_id | INT, PK, AUTO_INCREMENT | |
| package_name | VARCHAR(100) | |
| description | TEXT | |
| price | DECIMAL(10,2) | |
| inclusion_details | TEXT | |

---

## 4. Pages and Features

### 4.1 Login Page (`login.php`)
- Username and password fields
- Single login form for all roles
- After login, redirect based on role:
  - Admin → `admin/dashboard.php`
  - Employee → `employee/dashboard.php`
  - Customer → `customer/dashboard.php`
- Use `$_SESSION` to store the logged-in user

### 4.2 Admin Pages (`/admin/`)

**Sidebar links:**
- Dashboard
- Users
- Accommodations
- Amenities
- Packages
- Reservations
- Logs
- Logout

**dashboard.php**
- Simple count cards: total users, total reservations, total accommodations, pending reservations

**users.php**
- Table: full_name, role, username, email
- Search bar (searches full_name or username)
- Sort by role dropdown
- Add button → modal or redirect to `add_user.php`
- Edit and Delete buttons per row

**accommodations.php**
- Table: accommodation_name, capacity, price_per_night, availability_status
- Search bar
- Sort by availability dropdown
- Add, Edit, Delete per row

**amenities.php**
- Table: amenity_name, description, price_per_use
- Search bar
- Add, Edit, Delete per row

**packages.php**
- Table: package_name, description, price, inclusion_details
- Search bar
- Add, Edit, Delete per row

**reservations.php**
- Table: customer full_name, accommodation_name, check_in_date, check_out_date, total_price, reservation_status
- No foreign key columns displayed — JOIN tbl_users and tbl_accommodations
- Sorted by check_in_date descending
- Search bar (search by customer name)
- Sort by reservation_status dropdown
- Approve / Reject buttons per row (only for pending reservations)
- Add button

**logs.php**
- Table: full_name (joined from tbl_users), action, datetime
- Sorted by datetime descending
- Search bar (search by name or action)

### 4.3 Employee Pages (`/employee/`)

Exact copy of `/admin/` folder with these differences:
- No link or page for `users.php`
- No link or page for `logs.php`
- Employee can still approve/reject reservations on `reservations.php`

### 4.4 Customer Pages (`/customer/`)

**Sidebar links:**
- Browse Rooms
- Browse Packages
- My Reservations
- Logout

**rooms.php**
- Shows all accommodations where availability_status = 'available'
- Displays: accommodation_name, description, capacity, price_per_night
- Search bar
- Reserve button per row → goes to `reserve.php?id=X`

**reserve.php**
- Shows the selected accommodation details
- Form fields: check_in_date, check_out_date
- Total price is auto-computed (PHP: nights × price_per_night)
- Submit saves to tbl_reservations with status = 'pending'

**packages.php**
- Shows all packages
- Displays: package_name, description, price, inclusion_details
- Search bar only (read-only for customer)

**my_reservations.php**
- Shows only the logged-in customer's reservations
- Table: accommodation_name, check_in_date, check_out_date, total_price, reservation_status
- Sorted by check_in_date descending
- Customer can cancel a reservation if status is still 'pending'

---

## 5. Table Display Rules (All Roles)

- Tables with date fields are sorted descending (latest first)
- Every table has a search bar — PHP filters the SQL query using `LIKE '%$search%'`
- Foreign key columns are never shown — always JOIN and show the name instead
- Every table has an Add button in the top-right area of the page
- Category/status dropdowns for filtering where applicable (role, availability, reservation status)

---

## 6. File Structure

```
/htdocs/resort/
│
├── login.php
├── logout.php
├── db.php                  ← single database connection file
│
├── admin/
│   ├── dashboard.php
│   ├── users.php
│   ├── add_user.php
│   ├── edit_user.php
│   ├── accommodations.php
│   ├── add_accommodation.php
│   ├── edit_accommodation.php
│   ├── amenities.php
│   ├── add_amenity.php
│   ├── edit_amenity.php
│   ├── packages.php
│   ├── add_package.php
│   ├── edit_package.php
│   ├── reservations.php
│   ├── add_reservation.php
│   ├── logs.php
│   └── includes/
│       ├── sidebar.php
│       └── header.php
│
├── employee/
│   ├── dashboard.php
│   ├── accommodations.php
│   ├── amenities.php
│   ├── packages.php
│   ├── reservations.php
│   └── includes/
│       ├── sidebar.php     ← same as admin but without users and logs links
│       └── header.php
│
├── customer/
│   ├── dashboard.php
│   ├── rooms.php
│   ├── reserve.php
│   ├── packages.php
│   ├── my_reservations.php
│   └── includes/
│       ├── sidebar.php
│       └── header.php
│
└── assets/
    ├── css/
    │   └── style.css
    └── img/
```

---

## 7. Code Style Guidelines

- Keep it simple and readable — a student should be able to follow it
- Use plain `$_GET`, `$_POST`, and `$_SESSION` directly
- Use basic `for` or `foreach` loops, no fancy abstractions
- Variable names: short and obvious — `$name`, `$price`, `$rows`, `$row`, `$id`, `$result`
- No classes or OOP — just procedural PHP functions if needed
- Database queries go directly in the page file or in a small included function file
- No frameworks, no Composer, no npm — just plain PHP files

**Example query pattern:**
```php
$search = $_GET['search'] ?? '';
$sql = "SELECT * FROM tbl_accommodations WHERE accommodation_name LIKE '%$search%' ORDER BY accommodation_id DESC";
$result = mysqli_query($conn, $sql);

while ($row = mysqli_fetch_assoc($result)) {
    echo $row['accommodation_name'];
}
```

**Session check at top of every protected page:**
```php
session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login.php");
    exit();
}
```

---

## 8. Design Guidelines

### Philosophy
Clean, warm, and calm — fits a resort context. No dark mode, no flashy effects. Everything should feel like a simple, well-organized hotel front desk system.

### What to Avoid (Common AI Design Clichés)
- Purple-to-indigo gradients anywhere
- Glassmorphism (blurred frosted-glass cards)
- Neon glow effects or colored shadows
- Dark background with light text as the default theme
- Gradient text or gradient buttons
- Bento grid layouts
- Excessive rounded corners on everything (`border-radius` everywhere)
- Using Inter or Roboto as the only font with no personality
- Floating orb or blob background decorations
- Animated hero sections or parallax effects
- Cards with gradient borders

### Color Palette
```
Primary:    #2E7D6B  (deep teal-green — calm, natural)
Secondary:  #F5F0E8  (warm off-white — feels like sand/linen)
Accent:     #C8A96E  (warm gold — resort/luxury without being flashy)
Text:       #2C2C2C  (near-black, easier on the eyes than pure black)
Border:     #DDD5C8  (warm gray)
Sidebar bg: #1E5C4E  (darker shade of primary)
Sidebar text: #FFFFFF
```

### Typography
- Font: `Georgia` for headings (serif, classic, trustworthy)
- Font: `system-ui, sans-serif` for body text (clean, no download needed)
- No Google Fonts CDN required — keeps it simple and offline-capable in XAMPP

### Layout
- Bootstrap 5 grid
- Fixed sidebar (260px wide) on the left, content on the right
- White content area with subtle warm border: `1px solid #DDD5C8`
- Page has a warm off-white body background: `#F5F0E8`
- No hero banners or decorative images in the admin/employee views
- Tables use Bootstrap's `.table .table-hover` with a warm header background using the primary color
- Buttons: solid, no gradient — use Bootstrap `.btn-success` overridden with the primary color for main actions, `.btn-warning` for edit, `.btn-danger` for delete
- Add buttons sit in the top-right of the card above each table

### Component Style
- Cards: white background, `border: 1px solid #DDD5C8`, `border-radius: 6px` (subtle, not extreme)
- Table headers: `background-color: #2E7D6B`, `color: #fff`
- Sidebar active link: `background-color: #C8A96E`, `color: #fff`
- Login page: centered card on the warm off-white background, no illustration needed

---

## 9. How Role Routing Works

In `db.php` or `login.php`, after verifying credentials:

```php
if ($role == 'admin') {
    header("Location: admin/dashboard.php");
} else if ($role == 'employee') {
    header("Location: employee/dashboard.php");
} else {
    header("Location: customer/dashboard.php");
}
```

Each folder checks `$_SESSION['role']` at the top of every page and redirects if the role does not match.

---

## 10. Log Tracking

Every time an admin or employee adds, edits, approves, rejects, or deletes a record, insert a row into `tbl_logs`:

```php
$action = "Approved reservation ID $id";
$sql = "INSERT INTO tbl_logs (user_id, action, datetime) VALUES ({$_SESSION['user_id']}, '$action', NOW())";
mysqli_query($conn, $sql);
```

Keep it simple — just a text description and timestamp.

---

## 11. Out of Scope (Not Included in v1.0)

- Input sanitization or prepared statements
- CSRF protection
- Email notifications
- Payment integration
- Image uploads for accommodations
- PDF exports
- API endpoints
- Mobile app