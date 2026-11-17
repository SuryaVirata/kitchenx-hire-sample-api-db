# KitchenX Hire — Admin API

**Base URL:** `http://localhost:5001/api/v1/hire/admin`

Staff login is email and password. Do not reuse the job seeker / recruiter OTP routes. Admin uses the same `jobId`, `applicationId`, `businessId`, and `userId` as the job seeker and recruiter APIs.

## 1. Authentication

### 1.1 Login
**Method:** `POST`  
**URL:** `/auth/login`  
**Authorization:** Not required

**Request:**
```json
{
  "email": "admin@kitchenxhire.com",
  "password": "correct-horse-battery-staple"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "accessToken": "access_token_example",
    "refreshToken": "refresh_token_example",
    "tokenType": "Bearer",
    "expiresInSeconds": 900,
    "user": {
      "userId": "usr_adm_001",
      "fullName": "Platform Admin",
      "email": "admin@kitchenxhire.com",
      "role": "ADMIN"
    }
  }
}
```

### 1.2 Get Current Staff
**Method:** `GET`  
**URL:** `/auth/me`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "userId": "usr_adm_001",
    "fullName": "Platform Admin",
    "email": "admin@kitchenxhire.com",
    "role": "ADMIN"
  }
}
```

### 1.3 Logout
**Method:** `POST`  
**URL:** `/auth/logout`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

---

## 2. Jobs Management

### 2.1 List All Jobs
**Method:** `GET`  
**URL:** `/jobs?status=OPEN&page=1&limit=10`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "jobId": "job_1001",
        "title": "Kitchen Helper",
        "category": "KITCHEN_HELPER",
        "businessName": "Spice Garden Restaurant",
        "status": "OPEN",
        "applicationsCount": 4,
        "postedAt": "2026-11-05T08:00:00+05:30"
      }
    ],
    "page": 1,
    "limit": 10,
    "totalItems": 36
  }
}
```

### 2.2 Get Job Detail
**Method:** `GET`  
**URL:** `/jobs/job_1001`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "jobId": "job_1001",
    "title": "Kitchen Helper",
    "category": "KITCHEN_HELPER",
    "businessName": "Spice Garden Restaurant",
    "description": "Looking for a kitchen helper for morning shift.",
    "city": "Bengaluru",
    "payAmount": 18000,
    "payType": "MONTHLY",
    "status": "OPEN",
    "postedAt": "2026-11-05T08:00:00+05:30"
  }
}
```

### 2.3 Update Job Status
**Method:** `PATCH`  
**URL:** `/jobs/job_1001`  
**Authorization:** Bearer token

**Request:**
```json
{
  "status": "CLOSED"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "jobId": "job_1001",
    "status": "CLOSED"
  }
}
```

### 2.4 Remove a Job
**Method:** `DELETE`  
**URL:** `/jobs/job_1001`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "message": "Job removed successfully"
}
```

---

## 3. Job Seeker Management

### 3.1 List Job Seekers
**Method:** `GET`  
**URL:** `/job-seekers?page=1&limit=10`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "userId": "usr_jsk_001",
        "fullName": "Ravi Kumar",
        "city": "Bengaluru",
        "applicationsCount": 3,
        "createdAt": "2026-10-20T06:00:00+05:30"
      }
    ],
    "page": 1,
    "limit": 10,
    "totalItems": 128
  }
}
```

### 3.2 Get Job Seeker Detail
**Method:** `GET`  
**URL:** `/job-seekers/usr_jsk_001`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "userId": "usr_jsk_001",
    "fullName": "Ravi Kumar",
    "phoneNumber": "9876543210",
    "city": "Bengaluru",
    "skills": ["DISHWASHING", "KITCHEN_HELPER"],
    "resumeUrl": "https://cdn.kitchenxhire.com/resumes/res_001.pdf"
  }
}
```

---

## 4. Recruiter Management

### 4.1 List Recruiters
**Method:** `GET`  
**URL:** `/recruiters?page=1&limit=10`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "userId": "usr_rec_001",
        "fullName": "Meena Shetty",
        "businessName": "Spice Garden Restaurant",
        "jobsPostedCount": 2,
        "createdAt": "2026-10-18T06:00:00+05:30"
      }
    ],
    "page": 1,
    "limit": 10,
    "totalItems": 42
  }
}
```

### 4.2 Get Recruiter Detail
**Method:** `GET`  
**URL:** `/recruiters/usr_rec_001`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "userId": "usr_rec_001",
    "fullName": "Meena Shetty",
    "phoneNumber": "9812345678",
    "businessId": "biz_001",
    "businessName": "Spice Garden Restaurant"
  }
}
```

---

## 5. Business Management

### 5.1 List Businesses
**Method:** `GET`  
**URL:** `/businesses?page=1&limit=10`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "businessId": "biz_001",
        "businessName": "Spice Garden Restaurant",
        "city": "Bengaluru",
        "status": "APPROVED"
      }
    ],
    "page": 1,
    "limit": 10,
    "totalItems": 30
  }
}
```

### 5.2 Approve a Business
**Method:** `PATCH`  
**URL:** `/businesses/biz_001`  
**Authorization:** Bearer token

**Request:**
```json
{
  "status": "APPROVED"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "businessId": "biz_001",
    "status": "APPROVED"
  }
}
```

---

## 6. Applications Oversight

### 6.1 List All Applications
**Method:** `GET`  
**URL:** `/applications?status=APPLIED&page=1&limit=10`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "applicationId": "app_2001",
        "jobTitle": "Kitchen Helper",
        "jobSeekerName": "Ravi Kumar",
        "businessName": "Spice Garden Restaurant",
        "note": "I have 2 years of experience in a similar role.",
        "status": "APPLIED",
        "appliedAt": "2026-11-17T10:15:00+05:30"
      }
    ],
    "page": 1,
    "limit": 10,
    "totalItems": 210
  }
}
```

---

## 7. Job Categories

### 7.1 List Job Categories
**Method:** `GET`  
**URL:** `/job-categories`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "items": [
      { "categoryId": "1", "name": "KITCHEN_HELPER" },
      { "categoryId": "2", "name": "DISHWASHER" },
      { "categoryId": "3", "name": "COOK" },
      { "categoryId": "4", "name": "CLEANER" }
    ]
  }
}
```

### 7.2 Create a Job Category
**Method:** `POST`  
**URL:** `/job-categories`  
**Authorization:** Bearer token

**Request:**
```json
{
  "name": "WAITER"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "categoryId": "5",
    "name": "WAITER"
  }
}
```

---

## 8. Reports

### 8.1 Dashboard Summary
**Method:** `GET`  
**URL:** `/reports/summary`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "totalJobSeekers": 128,
    "totalRecruiters": 42,
    "totalBusinesses": 30,
    "totalJobsOpen": 36,
    "totalApplications": 210
  }
}
```

---

## 9. Error Response

Same shape across every endpoint above.

**Unknown email / bad password:**
```json
{
  "success": false,
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "Incorrect email or password",
    "details": []
  }
}
```

**Validation error:**
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The request contains invalid data",
    "details": [
      { "field": "name", "message": "Category name is required" }
    ]
  }
}
```
