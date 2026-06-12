### Step 1: Configure Roles and Projects in Ignition

1. Open the Ignition Designer for any project.
2. In the **Tag Browser**, navigate to:
    
    `default > _Config > Roles`
    

#### Add an Operation (Role)

1. Double-click **Operation**.
2. Select **All Properties** > **Value**.
3. Add the required role using the following naming convention:
    - **Role:** `OPE_RoleName`
        - Example: `OPE_Manager`
    - **Department:** `DPT_DepartmentName`
        - Example: `DPT_ProjectDelivery`

#### Add a Project

1. Double-click **Projects**.
2. Select **All Properties** > **Value**.
3. Add the project using the following naming convention:
    - **Project:** `PRJ_ProjectName`
        - Example: `PRJ_TEPortal`

---

### Step 2: Assign Roles and Projects to a User

1. Create a new user in **Azure TECentral B2C** (refer to the separate user creation guide).
2. Open the [Identity Provider Manager 2](https://dev.tecentral.com.au/data/perspective/client/TECentral/Admin/IdpManager) project.
3. Navigate to the User Management page.
4. Click the **Edit** button on the right side of the user record.
5. Open the **Roles** section and assign the required values.

The two main role types are:

- `PRJ_ProjectName` (Project Access)
- `OPE_RoleName` (Operational Role)

Example:

- `PRJ_TEPortal`
- `OPE_Manager`

## Step 3: Configure Security Levels

1. Open the appropriate Ignition Gateway:
    - Development: TECentral-TEST Ignition Gateway
    - Production: TECentral-PROD Ignition Gateway
2. Navigate to:
    
    **Config → Security Levels → Public → Authenticated → Roles**
    
3. Click **Add Security Level**.
4. Create the required security level using the following naming conventions:
    - **Role:** `OPE_RoleName`
        - Example: `OPE_Manager`
    - **Department:** `DPT_DepartmentName`
        - Example: `DPT_ProjectDelivery`
    - **Project:** `PRJ_ProjectName`
        - Example: `PRJ_TEPortal`
5. Click **Save** to apply the changes.

---

## Step 4: Configure Navigation Bar Permissions

1. In Ignition Designer, navigate to:
    
    **Tristar → Docks → Left → Left View → Nav**
    
2. Open the relevant Embedded View (for example, **ICT**).
3. Select the component and create a binding on the **Position → display** property.
4. Bind the property to:
```Python
session.props.auth.user.roles
```
1. Add the following transform script:

```python
def transform(self, value, quality, timestamp):  
   
	userRoles = value 
    hasOperation = any(role in userRoles for role in ["OPE_Manager"])
    hasDepartment = any(role in userRoles for role in ["DPT_ICT"]) 
    hasProject = any(role in userRoles for role in ["PRJ_TEPortal"])  
    
    return hasOperation and hasDepartment and hasProject
```
1. Replace the example role and project names with the security levels required for your view.

---

## Step 5: Configure View Permissions

1. In the Perspective module, locate the view you want to secure.
2. Right-click the view and select **Configure View Permissions...**
3. Navigate to:
    
    **Public → Authenticated → Roles**
    
4. Add the required security levels.
    
    Example:
    
    - `PRJ_TEPortal`
    - `OPE_Manager`
5. Save the changes.

Users will only be able to access the view if they have all required security levels assigned to their account.