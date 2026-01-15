# Library Management App

Library Management App is an iOS application designed to support digital library management. The application allows members to browse the library catalog and borrow books, while employees can record and monitor borrowed collections.

---

## Project Objectives

- Provide a digital library catalog accessible to members
- Record book borrowing activities in a structured and digital manner
- Assist employees in monitoring borrowed books efficiently

---

## Architecture

This project follows the MVVM (Model–View–ViewModel) architecture pattern.

- Model: Represents application data such as participants, collections, and borrowings
- View: User interface implemented using SwiftUI
- ViewModel: Handles business logic, state management, and communication with backend services

---

## Tech Stack

### Language and Framework
- Swift
- SwiftUI

### Internal Libraries
- Foundation
- Combine

### Backend and Database
- PostgREST
- Supabase (external library)

---

## Features

### Authentication
- User login system
- Role-based access control (Member and Employee)

### Book Catalog
- Displays all available library collections
- Shows book status (Available or Borrowed)
- Members can borrow books directly from the catalog

### Book Borrowing
- Borrowing records include:
  - Borrowed book
  - Borrower (member)
  - Borrow date
  - Due date (automatically set to 7 days after the borrow date)

### Employee Dashboard
- Displays a list of currently borrowed books
- Allows employees to monitor borrowers and due dates

---

## Borrowing Rules

- Borrowing duration is 7 days
- Due date is automatically calculated from the borrow date

---

## Database Tables

The application uses three main tables in the database.

### participants
Stores user information.
- id
- name
- email
- role (member or employee)

### collections
Stores library collection data.
- id
- title
- author
- available

### borrowings
Stores book borrowing records.
- id
- participant_id
- collection_id
- borrow_date
- return_date

---

### ERD

![Image](https://github.com/user-attachments/assets/00deff75-1499-4680-9584-299f899e233e)

### Unit Testing
<img width="721" height="277" alt="Image" src="https://github.com/user-attachments/assets/df5b33d3-69a1-4e75-924a-73a7cb181d39" />

- Gambar diatas adalah contoh unit testing menggunakan white box, pada gambar diatas sistem munguji jika password empty itu harusnya tidak bisa login. dan hasil dari unit testingnya adalah success yakni user tidak dapat login

<img width="721" height="222" alt="Image" src="https://github.com/user-attachments/assets/6188430e-f736-4b2f-8376-50ee3426a721" />
- Gambar diatas sistem menguji jika email dan password yang dimasukkan sesuai maka hasilnya harusnya bisa login dan dari hasil unit testingnya adalah sukses dimana user bisa login
