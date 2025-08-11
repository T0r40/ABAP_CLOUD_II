# Incident Management
## Table of Contents
## Table of Contents
1. [Scope](#1-scope)  
2. [Functional Overview](#2-functional-overview)  
3. [Technical Requirements](#3-technical-requirements)  
   - [3.1 Data Structure & Data Dictionary](#31-data-structure--data-dictionary)  
   - [3.2 CRUD Operations (Create, Read, Update, Delete)](#32-crud-operations-create-read-update-delete)  
4. [Database Design](#4-database-design)  
   - [4.1 Database Tables – RAP Model](#41-database-tables--rap-model)  
   - [4.2 Additional Database Tables](#42-additional-database-tables)  
   - [4.3 Field Definitions](#43-field-definitions)  
   - [4.4 Table Relationships](#44-table-relationships)  
   - [4.5 Additional Considerations](#45-additional-considerations)  
5. [Data Modeling & Storage](#5-data-modeling--storage)  
   - [5.1 Incident Root Entity and Composition to History Entity](#51-incident-root-entity-and-composition-to-history-entity)  
   - [5.2 Redirected Consumption Entities](#52-redirected-consumption-entities)  
   - [5.3 Metadata Extensions](#53-metadata-extensions)  
   - [5.4 Behavior Definition](#54-behavior-definition)  
6. [Business Services](#6-business-services)  
   - [6.1 Service Definition](#61-service-definition)  
   - [6.2 Service Binding](#62-service-binding)  
7. [UI Actions](#7-ui-actions)  
8. [Validation Functional Requirements](#8-validation-functional-requirements)  
9. [Testing](#9-testing)  


## 1. Scope  

**Objective:**  
Develop an application based on the ABAP RESTful Application Programming Model (RAP) for incident management. The application must support CRUD operations, ensure optimal performance, and apply business validations, in addition to providing a user interface implemented with the same technology.  

**Project Scope:**  

**Backend with ABAP RAP with DRAFT:**  
- Define the data structure using CDS Views.  
- Implement a Business Object (BO) with standard actions (Create, Read, Update, Delete) in a managed scenario.  
- Implement validations and business logic within Behavior Definitions and Implementations.  
- Optimize query performance using best practices recommended for ABAP Cloud.  

**User Interface:**  
- Develop a Fiori Elements application based on OData V4 exposed by the RAP service, using Metadata Extensions.  
- Include forms and lists for incident management.  
- Implement validation messages and error handling.  

**Technical Requirements:**  
- Use of CDS Views, compositions, and associations.  
- Implementation of Business Objects in ABAP RAP.  
- Exposure of OData V4 service.  
- Development of the UI using Fiori Elements.  

---

## 2. Functional Overview  

The Incident Management System will allow users to register, update, consult, and close incidents within an organization. Each incident will contain key information such as problem type, priority, status, and a detailed description.  

**Main Application Flow:**  
- Creation of an incident with mandatory data.  
- Consultation of open and closed incidents.  
- Update of incident status and details.  
- Deletion of records according to defined permissions.  
- Validations and restrictions to ensure data consistency.  

Users will access the application through a **Fiori Elements** interface, displaying lists and forms optimized for efficient incident management. 

---

## 3. Technical Requirements  

### 3.1 Data Structure & Data Dictionary  
- Create and configure objects in the Data Dictionary:  
  - **Data types:** Specific data elements and domains for the fields mentioned in the following section.  
  - **Database tables:**  
    - Tables for incidents and incident history.  
    - Configuration of primary and secondary keys.  

### 3.2 CRUD Operations (Create, Read, Update, Delete)  
- **Create:** Implement the creation of incidents through the RAP application with validations such as mandatory fields and correct data formats.  
- **Read:** Implement queries with filters by incident priority, status, and responsible person.  
- **Update:** Enable the operation in the Behavior Definition of the RAP application.  
- **Delete:** Enable the operation in the Behavior Definition of the RAP application, validating the deletion of incidents that have the status **"Open"**.

---

## 4. Database Design  

**Technical Note:**  
For the naming convention of the objects created in the system, replace the word **"USER"** with the last three characters of the student’s SAP User ID in all created artifacts. This is to avoid conflicts during artifact creation.  

### 4.1 Database Tables – RAP Model  
- **Incidents:** `ZDT_INCT_USER`  
- **Incident History:** `ZDT_INCT_H_USER`  

### 4.2 Additional Database Tables  
- **Status:** `ZDT_STATUS_USER`  
- **Priorities:** `ZDT_PRIORITY_USER`  

### 4.3 Field Definitions  
*(Details of the database field definitions go here.)*  
  
### ZDT_INCT_USER (Incidents)  
Stores the basic information about incidents.

| Field Name             | Data Type                  | Length | Description                                                   |
|------------------------|---------------------------|--------|---------------------------------------------------------------|
| INC_UUID               | SYSUUID_X16                | RAW 16 | Unique identifier for the Incident.                          |
| INCIDENT_ID            | NUMC                       | 8      | Semantic ID for the Incident.                                |
| TITLE                  | CHAR                       | 20     | Title.                                                        |
| DESCRIPTION            | CHAR                       | 60     | Detailed description of the Incident.                        |
| STATUS                 | CHAR                       | 2      | Status of the Incident (e.g., 'OP', 'IP').                    |
| PRIORITY               | CHAR                       | 1      | Priority of the Incident (e.g., 'H').                         |
| CREATION_DATE          | DATS                       | 8      | Created Date.                                                 |
| CHANGED_DATE           | DATS                       | 8      | Changed Date.                                                 |
| LOCAL_CREATED_BY       | ABP_CREATION               |        | Created By.                                                   |
| LOCAL_CREATED_AT       | ABP_CREATION_TSTMPL        |        | Created On.                                                   |
| LOCAL_LAST_CHANGED_BY  | ABP_LOCINST_LAST_CHANGE    |        | Changed By.                                                   |
| LOCAL_LAST_CHANGED_AT  | ABP_LOCINST_LAST_CHANGE_TSTMPL |    | Changed On.                                                   |
| LAST_CHANGED_AT        | ABP_LASTCHANGE_TSTMPL      |        | Changed On.                                                   |


### ZDT_INCT_H_USER (History)  
Stores information about the history of the Incidents.

| Field Name             | Data Type                   | Length | Description                                                   |
|------------------------|-----------------------------|--------|---------------------------------------------------------------|
| HIS_UUID               | SYSUUID_X16                 | RAW 16 | Unique identifier for the History Incident.                   |
| INC_UUID               | SYSUUID_X16                 | 10     | Unique identifier for the Incident.                           |
| HIS_ID                 | NUMC                        | 8      | History ID.                                                    |
| PREVIOUS_STATUS        | CHAR                        | 2      | Status of the Incident (e.g., 'OP', 'IP').                     |
| NEW_STATUS             | CHAR                        | 2      | Status of the Incident (e.g., 'OP', 'IP').                     |
| TEXT                   | CHAR                        | 80     | Observation.                                                   |
| LOCAL_CREATED_BY       | ABP_CREATION                 |        | Created By.                                                    |
| LOCAL_CREATED_AT       | ABP_CREATION_TSTMPL          |        | Created On.                                                    |
| LOCAL_LAST_CHANGED_BY  | ABP_LOCINST_LASTCHANGE       |        | Created On.                                                    |
| LOCAL_LAST_CHANGED_AT  | ABP_LOCINST_LASTCHANGE_TSTMPL|        | Changed By.                                                    |
| LAST_CHANGED_AT        | ABP_LASTCHANGE_TSTMPL        |        | Changed On.                                                    |

### ZDT_STATUS_USER (Statuses)  
Stores the possible statuses for Incidents (e.g., Pending, Completed).

| Field Name           | Data Type | Length | Description                                                       |
|----------------------|-----------|--------|-------------------------------------------------------------------|
| STATUS_CODE          | CHAR      | 2      | Unique identifier for the status.                                 |
| STATUS_DESCRIPTION   | CHAR      | 40     | Description of the status (e.g., 'Pending', 'Completed').         |

---

**Allowed values for the field `STATUS_CODE`:**

| Value | Description   |
|-------|---------------|
| OP    | Open          |
| IP    | In Progress   |
| PE    | Pending       |
| CO    | Completed     |
| CL    | Closed        |
| CN    | Canceled      |

### ZDT_PRIORITY_USER (Priorities)  
Stores the possible priorities for Incidents (e.g., High, Low).

| Field Name             | Data Type | Length | Description                                                              |
|------------------------|-----------|--------|--------------------------------------------------------------------------|
| PRIORITY_CODE          | CHAR      | 1      | Unique identifier for the priority.                                      |
| PRIORITY_DESCRIPTION   | CHAR      | 40     | Description of the priority (e.g., 'A' for High, 'B' for Low).           |

---

**Allowed values for the field `PRIORITY_CODE`:**

| Value | Description |
|-------|-------------|
| H     | High        |
| M     | Medium      |
| L     | Low         |

## 4.4 Table Relationships  

**Relationship 1:** `ZDT_INCT_H_USER` → `ZDT_INCT_USER`  
- **Type:** Foreign key.  
- **Detail:** Foreign Key Field `INC_UUID` in `ZDT_INCT_H_USER` references `INC_UUID` in `ZDT_INCT_USER`.  

**Relationship 2:** `ZDT_INCT_USER` → `ZDT_STATUS_USER`  
- **Type:** Foreign key.  
- **Detail:** Foreign Key Field `STATUS` in `ZDT_INCT_USER` references `STATUS_CODE` in `ZDT_STATUS_USER`.  

**Relationship 3:** `ZDT_INCT_USER` → `ZDT_PRIORITY_USER`  
- **Type:** Foreign key.  
- **Detail:** Foreign Key Field `PRIORITY` in `ZDT_INCT_USER` references `PRIORITY_CODE` in `ZDT_PRIORITY_USER`.  

## 4.5 Additional Considerations  

**Consistency and Validation:**  
- Use domains for fields such as `STATUS` and `PRIORITY`, defining predefined values.  
- Ensure that identifiers (UUID) are unique by using primary keys.

---

## 5. Data Modeling & Storage  

### 5.1 Incident Root Entity and Composition to History Entity  
The RAP application uses a main **Incident** root entity that provides CRUD operations (together with the previously mentioned validations) and a **composition** navigation to the **History** entity, **read-only** from the UI.  
This navigation must be implemented from the Incident root entity to the History entity using a **composition with cardinality `[0..*]`**, and the History entity must be associated back to the root/parent via the `INC_UUID` field (with its corresponding alias).  

During the save process of an incident, define an **additional save** that captures the changes in the History entity—recording **previous status** and **new status**, along with **change date** and **user**. This process inserts data into table `ZDT_INCT_H_USER`.  

---

### 5.2 Redirected Consumption Entities  
Create **two consumption/projection entities**:  
- One for the **Incident** root entity, using a **transactional contract**.  
- One for the **History** entity.  

They must be related using the **redirection technique** so that:  
- From the **Incident** entity, the association **redirects** to its **composition child** (History).  
- From the **History** entity, the association **redirects** to its **parent** (Incidents).  

---

### 5.3 Metadata Extensions  

#### Incidents  
- Add **ascending sorting** by `INCIDENT_ID`.  
- Set the header **title** to *Incident*.  
- **Hide** from visible columns and from search filters:  
  - Audit fields: `local_created_by`, `local_created_at`, `local_last_changed_by`, `local_last_changed_at`, `last_changed_at`.  
  - Columns: `inc_uuid` and `title`.  
    - **Note:** `title` must be removed **only** from **search filters** (it may remain visible as a column).  
  - Referenced associations.  
- Add visualization types via `@UI.facet`:  
  - `#IDENTIFICATION_REFERENCE` for incident records.  
  - `#LINEITEM_REFERENCE` for modification records shown in the related History view.  
- On field `INC_UUID`, define an **action** (same name to be reused in the Behavior Definition for the “Change Status” button) using `@UI.lineItem` and `@UI.identification` with:  
  - `type = #FOR_ACTION`  
  - `dataAction = '<ActionName>'`  
- Set **field importance**:  
  - UUID fields → `#HIGH`  
  - ID fields → `#MEDIUM`  
  - Other fields → `#LOW`  

#### History  
- Add **ascending sorting** by `HIS_ID`.  
- Set the header **title** to *History*.  
- **Disable creation** in the History view (changes are recorded via Incident status changes) using `@UI.createHidden: true` at the header level.  
- **Hide** from visible columns and from search filters:  
  - Audit fields: `local_created_by`, `local_created_at`, `local_last_changed_by`, `local_last_changed_at`, `last_changed_at`.  
  - Columns: `his_uuid`, `inc_uuid`.  
  - Referenced associations.  
- Add `#LINEITEM_REFERENCE` via `@UI.facet` for modification records in the related History view.  
- Set **field importance**:  
  - UUID fields → `#HIGH`  
  - ID fields → `#MEDIUM`  
  - Other fields → `#LOW`  

---

### 5.4 Behavior Definition  

Create **two Behavior Definitions**:  
1) One that defines the behavior for the Incident root entity and the History entity (with **composition** association to the root).  
2) Another that specifies the **implementation**.

#### Entity Behavior Definitions  

**Incidents**  
- Define buttons for basic operations: **Create**, **Update**, **Delete**.  
- Define association with the **History** composition child, enabling `features: instance` and `with draft`.  
- Set read-only fields: `inc_uuid`, `incident_id`, `status`, `changed_date`, and audit fields `local_created_by`, `local_created_at`, `local_last_changed_by`, `local_last_changed_at`, `last_changed_at`.  
- Set `inc_uuid` as **auto-generated (UUID)**.  
- Set required fields: `title`, `description`, `priority`.  
- Define the action button with the **same name** used in the Metadata Extensions of the History entity, enabling `features: instance` and `authorization: update`.  
- Add an **abstract entity** with two fields:  
  - one for the **new status** (used in Incident and History views),  
  - one for the **observation/note** (used only in the History view).  
- Configure **side effects** to update the History view when performing the **Change Status** action.  
- Add a **determination** on `on save` to create a new History record when a new incident is created, setting initial status **`OP` (Open)** in `new_status` and text **"First Incident"** in `text`.  
- Add a **determination** on `on modify` so that when opening the create view, `incident_id`, `creation_date`, and `status` are prefilled. `incident_id` must **auto-increment**, and both `incident_id` and `creation_date` are **read-only**.  
- Enable **Draft** actions: `Activate`, `Discard`, `Edit`, `Resume`, `Prepare`.  
- Map all database fields from `ZDT_INCT_USER`.  

**History**  
- Define buttons for basic operations: **Update**, **Delete**.  
- Define association with the **parent** Incident entity, enabling `with draft`.  
- Set `his_uuid` as **auto-generated (UUID)**.  
- Set read-only fields: `his_uuid`, `inc_uuid`, and audit fields `local_created_by`, `local_created_at`, `local_last_changed_by`, `local_last_changed_at`, `last_changed_at`.  
- Map all database fields from `ZDT_INCT_H_USER`.  

#### Entity Behavior Implementations  

**Incidents**  
- Enable buttons: **Create**, **Update**, **Delete**.  
- Enable Draft actions: `Activate`, `Discard`, `Edit`, `Resume`, `Prepare`.  
- Enable association with the **History** composition child.  

**History**  
- Enable association with the **parent** Incident entity.  

---

## 6. Business Services  

### 6.1 Service Definition  
It is necessary to expose the consumption entities `ZC_DT_INCT_USER` and `ZC_DT_INCT_H_USER` so that the relationship between both views can be displayed in the Fiori application in the browser.  

### 6.2 Service Binding  
When generating the Service Binding from the previously created Service Definition, set the **Binding Type** field to **OData V4 - UI** to enable the **Preview** tool and allow testing the application in the browser.  

---

## 7. UI Actions  

An explicit **status change** must be allowed from RAP through a button that triggers an action, prompting for the **new status value** and an **observation text** via a pop-up.  

It is important to note that the action used to change the status must be **disabled** when creating new records.  

---

## 8. Validation Functional Requirements  

**Mandatory Fields:**  
- Validate that the fields `TITLE`, `DESCRIPTION`, `PRIORITY`, `STATUS`, and `CREATION_DATE` are not empty when creating an incident.  
- When updating an incident, ensure that mandatory values are not removed.  

**Status Restrictions:**  
- An incident cannot be changed to **Completed (CO)** or **Closed (CL)** if it is still in **Pending (PE)** status.  
- For incidents with status **Canceled (CN)**, **Completed (CO)**, or **Closed (CL)**, status changes are no longer allowed.  

**Date Validation:**  
- `CHANGE_DATE` cannot be earlier than `CREATION_DATE`.  
- Users cannot register an incident with a future date.  

**Responsible User Validation:**  
- If the status changes to **In Progress (IP)**, a `RESPONSIBLE` must be assigned.  
- Only the assigned user or an administrator can change the status of an incident.  
  - **Note:** For testing purposes, the developer’s own user is considered as an administrator.  

---

## 9. Testing  

From the user interface, the required CRUD operations must be invoked, ensuring that the processes execute correctly.  
