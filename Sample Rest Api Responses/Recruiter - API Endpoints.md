# KitchenX Hire — Recruiter API

**Base URL:** `http://localhost:5001/api/v1/hire`

## 1. Authentication

### 1.1 Request OTP
**Method:** `POST`  
**URL:** `/auth/otp/request`  
**Authorization:** Not required

**Request:**
```json
{
  "countryCode": "+91",
  "phoneNumber": "9812345678",
  "purpose": "LOGIN"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "challengeId": "otp_ch_610",
    "maskedPhoneNumber": "+91 ******5678",
    "expiresInSeconds": 300,
    "resendAvailableInSeconds": 30,
    "otpLength": 6
  }
}
```

### 1.2 Verify OTP (Login or Signup)
**Method:** `POST`  
**URL:** `/auth/otp/verify`  
**Authorization:** Not required

**Request:**
```json
{
  "challengeId": "otp_ch_610",
  "otp": "715620",
  "role": "RECRUITER"
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
    "expiresInSeconds": 3600,
    "isNewUser": true,
    "user": {
      "userId": "usr_rec_001",
      "fullName": "Meena Shetty",
      "role": "RECRUITER"
    }
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

## 2. Business Profile

### 2.1 Get My Business Profile
**Method:** `GET`  
**URL:** `/recruiter/business`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "businessId": "biz_001",
    "businessName": "Spice Garden Restaurant",
    "businessType": "RESTAURANT",
    "city": "Bengaluru",
    "address": "12 MG Road, Bengaluru",
    "contactPerson": "Meena Shetty",
    "status": "APPROVED"
  }
}
```

### 2.2 Update My Business Profile
**Method:** `PATCH`  
**URL:** `/recruiter/business`  
**Authorization:** Bearer token

**Request:**
```json
{
  "businessName": "Spice Garden Restaurant",
  "businessType": "RESTAURANT",
  "city": "Bengaluru",
  "address": "12 MG Road, Bengaluru"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "businessId": "biz_001",
    "businessName": "Spice Garden Restaurant",
    "businessType": "RESTAURANT",
    "city": "Bengaluru",
    "address": "12 MG Road, Bengaluru"
  }
}
```

---

## 3. Job Postings

### 3.1 Post a New Job
**Method:** `POST`  
**URL:** `/recruiter/jobs`  
**Authorization:** Bearer token

**Request:**
```json
{
  "title": "Kitchen Helper",
  "category": "KITCHEN_HELPER",
  "description": "Looking for a kitchen helper for morning shift.",
  "city": "Bengaluru",
  "payAmount": 18000,
  "payType": "MONTHLY"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "jobId": "job_1001",
    "title": "Kitchen Helper",
    "category": "KITCHEN_HELPER",
    "status": "OPEN",
    "postedAt": "2026-11-05T08:00:00+05:30"
  }
}
```

### 3.2 My Posted Jobs
**Method:** `GET`  
**URL:** `/recruiter/jobs?status=OPEN&page=1&limit=10`  
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
        "status": "OPEN",
        "applicationsCount": 4,
        "postedAt": "2026-11-05T08:00:00+05:30"
      }
    ],
    "page": 1,
    "limit": 10,
    "totalItems": 1
  }
}
```

### 3.3 Update a Job Posting
**Method:** `PATCH`  
**URL:** `/recruiter/jobs/job_1001`  
**Authorization:** Bearer token

**Request:**
```json
{
  "payAmount": 19000,
  "description": "Looking for a kitchen helper for morning shift. Pay revised."
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "jobId": "job_1001",
    "payAmount": 19000,
    "status": "OPEN"
  }
}
```

### 3.4 Close a Job Posting
**Method:** `DELETE`  
**URL:** `/recruiter/jobs/job_1001`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "message": "Job closed successfully"
}
```

---

## 4. Applications Received

### 4.1 View Applications for a Job
**Method:** `GET`  
**URL:** `/recruiter/jobs/job_1001/applications?page=1&limit=10`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "applicationId": "app_2001",
        "jobSeekerName": "Ravi Kumar",
        "resumeUrl": "https://cdn.kitchenxhire.com/resumes/res_001.pdf",
        "note": "I have 2 years of experience in a similar role.",
        "status": "APPLIED",
        "appliedAt": "2026-11-17T10:15:00+05:30"
      }
    ],
    "page": 1,
    "limit": 10,
    "totalItems": 1
  }
}
```

### 4.2 Update Application Status (Shortlist / Accept / Reject)
**Method:** `PATCH`  
**URL:** `/recruiter/applications/app_2001`  
**Authorization:** Bearer token

**Request:**
```json
{
  "status": "SHORTLISTED",
  "recruiterNotes": "Good fit, schedule interview."
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "applicationId": "app_2001",
    "status": "SHORTLISTED",
    "recruiterNotes": "Good fit, schedule interview."
  }
}
```

---

## 5. Market Jobs (Read-Only)

### 5.1 Browse Other Jobs in the Market
**Method:** `GET`  
**URL:** `/jobs?city=Bengaluru&page=1&limit=10`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "jobId": "job_1002",
        "title": "Dishwasher",
        "category": "DISHWASHER",
        "businessName": "Coastal Bites",
        "city": "Bengaluru",
        "payAmount": 15000,
        "payType": "MONTHLY",
        "status": "OPEN"
      }
    ],
    "page": 1,
    "limit": 10,
    "totalItems": 1
  }
}
```

**Note:** Recruiters can browse this list but cannot apply — there is no `applications` action on this route for a `RECRUITER` session.

---

## 6. Error Response

Same shape across every endpoint above.

**Validation error:**
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The request contains invalid data",
    "details": [
      { "field": "title", "message": "Job title is required" }
    ]
  }
}
```

**Not the job owner:**
```json
{
  "success": false,
  "error": {
    "code": "FORBIDDEN",
    "message": "You do not have access to this job",
    "details": []
  }
}
```
