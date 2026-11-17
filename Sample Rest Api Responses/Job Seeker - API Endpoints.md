# KitchenX Hire — Job Seeker API

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
  "phoneNumber": "9876543210",
  "purpose": "LOGIN"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "challengeId": "otp_ch_501",
    "maskedPhoneNumber": "+91 ******3210",
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
  "challengeId": "otp_ch_501",
  "otp": "482913",
  "role": "JOB_SEEKER"
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
    "isNewUser": false,
    "user": {
      "userId": "usr_jsk_001",
      "fullName": "Ravi Kumar",
      "role": "JOB_SEEKER"
    }
  }
}
```

### 1.3 Get Current Session
**Method:** `GET`  
**URL:** `/auth/session`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "userId": "usr_jsk_001",
    "phoneNumber": "9876543210",
    "authenticated": true
  }
}
```

### 1.4 Logout
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

## 2. Profile

### 2.1 Get My Profile
**Method:** `GET`  
**URL:** `/job-seeker/profile`  
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
    "experienceYears": 2,
    "skills": ["DISHWASHING", "KITCHEN_HELPER"],
    "profileComplete": true
  }
}
```

### 2.2 Update My Profile
**Method:** `PATCH`  
**URL:** `/job-seeker/profile`  
**Authorization:** Bearer token

**Request:**
```json
{
  "fullName": "Ravi Kumar",
  "city": "Bengaluru",
  "experienceYears": 2,
  "skills": ["DISHWASHING", "KITCHEN_HELPER", "CLEANING"]
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "userId": "usr_jsk_001",
    "fullName": "Ravi Kumar",
    "city": "Bengaluru",
    "experienceYears": 2,
    "skills": ["DISHWASHING", "KITCHEN_HELPER", "CLEANING"],
    "profileComplete": true
  }
}
```

---

## 3. Resume

### 3.1 Upload Resume
**Method:** `POST`  
**URL:** `/job-seeker/resume`  
**Authorization:** Bearer token

**Request:**
```json
{
  "fileName": "ravi_kumar_resume.pdf",
  "fileBase64": "<base64-encoded-file>"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "resumeId": "res_001",
    "fileName": "ravi_kumar_resume.pdf",
    "fileUrl": "https://cdn.kitchenxhire.com/resumes/res_001.pdf",
    "uploadedAt": "2026-11-10T09:30:00+05:30"
  }
}
```

### 3.2 Get My Resume
**Method:** `GET`  
**URL:** `/job-seeker/resume`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "data": {
    "resumeId": "res_001",
    "fileName": "ravi_kumar_resume.pdf",
    "fileUrl": "https://cdn.kitchenxhire.com/resumes/res_001.pdf",
    "uploadedAt": "2026-11-10T09:30:00+05:30"
  }
}
```

---

## 4. Jobs

### 4.1 Browse Jobs
**Method:** `GET`  
**URL:** `/jobs?city=Bengaluru&category=KITCHEN_HELPER&page=1&limit=10`  
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
        "city": "Bengaluru",
        "payAmount": 18000,
        "payType": "MONTHLY",
        "status": "OPEN"
      }
    ],
    "page": 1,
    "limit": 10,
    "totalItems": 24
  }
}
```

### 4.2 Get Job Detail
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

---

## 5. Applications

### 5.1 Apply to a Job
**Method:** `POST`  
**URL:** `/jobs/job_1001/applications`  
**Authorization:** Bearer token

**Request:**
```json
{
  "resumeId": "res_001",
  "note": "I have 2 years of experience in a similar role."
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "applicationId": "app_2001",
    "jobId": "job_1001",
    "status": "APPLIED",
    "appliedAt": "2026-11-17T10:15:00+05:30"
  }
}
```

### 5.2 My Applications
**Method:** `GET`  
**URL:** `/job-seeker/applications?status=APPLIED&page=1&limit=10`  
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
        "businessName": "Spice Garden Restaurant",
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

### 5.3 Withdraw Application
**Method:** `DELETE`  
**URL:** `/applications/app_2001`  
**Authorization:** Bearer token

**Response:**
```json
{
  "success": true,
  "message": "Application withdrawn successfully"
}
```

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
      { "field": "resumeId", "message": "Resume is required" }
    ]
  }
}
```

**Already applied:**
```json
{
  "success": false,
  "error": {
    "code": "ALREADY_APPLIED",
    "message": "You have already applied to this job",
    "details": []
  }
}
```
