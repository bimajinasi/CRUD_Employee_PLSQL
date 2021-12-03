--------------------------------------------------------
--  File created - Friday-December-03-2021   
--------------------------------------------------------
DROP PACKAGE "SYSTEM"."PKG_EMPLOYEE";
DROP PACKAGE BODY "SYSTEM"."PKG_EMPLOYEE";
--------------------------------------------------------
--  DDL for Package PKG_EMPLOYEE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "SYSTEM"."PKG_EMPLOYEE" AS

--add a employee
PROCEDURE addEmployee(
pkg_id employee.emp_id%type,
pkg_name employee.emp_name%type,
pkg_salary employee.salary%type,
pkg_manager employee.manager%type
);

--update employee
PROCEDURE updateEmployee(
upd_id  employee.emp_id%type,
upd_name employee.emp_name%type
);

--select employee by id
PROCEDURE detailByEmployee(
select_id employee.emp_id%type
);

--remove a employee
PROCEDURE delEmployee(pkg_id employee.emp_id%TYPE);

--list all employee
PROCEDURE listEmployee;

END pkg_employee;

/
--------------------------------------------------------
--  DDL for Package Body PKG_EMPLOYEE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "SYSTEM"."PKG_EMPLOYEE" AS
    --PROCEDURE ADD
    PROCEDURE addEmployee(
    pkg_id employee.emp_id%type,
    pkg_name employee.emp_name%type,
    pkg_salary employee.salary%type,
    pkg_manager employee.manager%type
    )
    IS
    --INSERT
        BEGIN
            INSERT INTO employee (emp_id, emp_name, salary, manager)
            VALUES (pkg_id, pkg_name, pkg_salary, pkg_manager);
        END addEmployee;


    --PROCEDURE UPDATE
    PROCEDURE updateEmployee(
    upd_id employee.emp_id%type,
    upd_name employee.emp_name%type
    )
    IS
        BEGIN
            update employee SET EMP_NAME = upd_name where EMP_ID = upd_id;
            COMMIT;
    END updateEmployee;

    --PROCEDURE detailByEmployee
    PROCEDURE detailByEmployee(
        select_id employee.emp_id%type
    )
    IS
    c_name employee.emp_name%type;
    c_salary employee.salary%type;
    c_manager employee.manager%type;
    BEGIN
        select EMP_NAME, SALARY, MANAGER
        INTO c_name, c_salary, c_manager
        from EMPLOYEE where EMP_ID = select_id;
        COMMIT;
        dbms_output.put_line(select_id || ' ' || c_name || ' ' || c_salary || ' ' || c_manager);
    END detailByEmployee;

    --PROCEDURE DELETE
    PROCEDURE delEmployee(pkg_id employee.emp_id%type) IS
        BEGIN
            DELETE FROM EMPLOYEE
            where EMP_ID = pkg_id;
        END delEmployee;

    --PROCEDURE SELECT LIST
    PROCEDURE listEmployee IS
    c_id employee.emp_id%type;
    c_name employee.emp_name%type;
    c_salary employee.salary%type;
    c_manager employee.manager%type;
    CURSOR c_employee is
        SELECT emp_id, emp_name, salary, manager from employee;
    BEGIN
    open c_employee; --cursor for allocating the memory
    loop
    FETCH c_employee into c_id, c_name, c_salary, c_manager; --cursor for retrieving the data
        EXIT WHEN c_employee%notfound;
        dbms_output.put_line(c_id || ' ' || c_name || ' ' || c_salary || ' ' || c_manager);
   END LOOP;
   CLOSE c_employee; --cursor to release the allocated memory
    END listEmployee;

    END pkg_employee;

/
