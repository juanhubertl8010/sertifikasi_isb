# 📚 Library Management App

Library Management App is an **iOS application** designed to support digital library management. This application allows **members** to browse the book catalog and borrow books, while **employees** can record and monitor borrowed collections.

---

## 🎯 Project Objectives

- Provide a digital library catalog accessible to members
- Record book borrowing activities in a structured and digital way
- Help employees monitor borrowed books efficiently

---

## 🏗️ Architecture

This project uses the **MVVM (Model–View–ViewModel)** architecture:
- **Model**: Represents application data (Participants, Collections, Borrowings)
- **View**: UI built using SwiftUI
- **ViewModel**: Handles business logic, state management, and API communication

---

## ⚙️ Tech Stack

### Language & Framework
- Swift
- SwiftUI

### Internal Libraries
- Foundation
- Combine

### Backend & Database
- PostgREST
- Supabase (External Library)

---

## ✨ Features

### 🔐 Authentication
- User login system
- Role-based access (Member & Employee)

### 📖 Book Catalog
- Display all available library collections
- Show book status (Available / Borrowed)
- Members can borrow books directly from the catalog

### 📝 Book Borrowing
- Borrowing records include:
  - Borrowed book
  - Borrower (member)
  - Borrow date
  - Due date (7 days after borrow date)

### 👨‍💼 Employee Dashboard
- View list of currently borrowed books
- Monitor borrowers and due dates

---

## 🗄️ Database Tables

The application uses **three main tables**:

### 📌 participants
### 📌 collections
### 📌 borrowings

---

