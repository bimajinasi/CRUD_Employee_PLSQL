--CREATE TABLE
create table EMPLOYEE(
EMP_ID NUMBER, EMP_NAME VARCHAR2(20), SALARY NUMBER, MANAGER VARCHAR2(10)
);
/

--INSERT MULTIPLE ROW
insert into EMPLOYEE (EMP_ID, EMP_NAME, SALARY, MANAGER)
WITH tempStation AS (
SELECT 1, 'Amir', 1800, 'James' FROM dual UNION ALL
SELECT 2, 'Eko', 1200, 'Jeko' FROM dual UNION ALL
SELECT 3, 'Amar', 1000, 'Justin' FROM dual UNION ALL
SELECT 4, 'Buenos', 7000, 'Albert' FROM dual UNION ALL
SELECT 5, 'Cintya', 3000, 'Bima' FROM dual UNION ALL
SELECT 6, 'Dheo', 2000, 'Yoga' FROM dual
)
select * FROM tempStation;
/

drop table EMPLOYEE;
/

select * from EMPLOYEE;
/

--INTRO CRUD PLSQL
DECLARE
    l_emp_id NUMBER;
    l_emp_name VARCHAR2(20);
    l_emp_salary NUMBER;
    l_manager VARCHAR2(20);
BEGIN
--INSERT
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, SALARY, MANAGER)
VALUES (8,'Jun',1000,'Yoga');
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, SALARY, MANAGER)
VALUES (9,'Joni',3000,'Yogi');
--commit to save insert row
--COMMIT;
dbms_output.put_line('Values Inserted');

--UPDATE
update EMPLOYEE
set salary  = 7777
where EMP_ID=3;
--COMMIT;
dbms_output.put_line('Values Updated');
--DELETE

delete EMPLOYEE
where EMP_ID = 4;
--COMMIT;
dbms_output.put_line('Values Deleted');
select EMP_ID, EMP_NAME, SALARY, MANAGER
INTO
l_emp_id,
l_emp_name ,
l_emp_salary ,
l_manager
from EMPLOYEE
WHERE
emp_name = 'Amar';

dbms_output.put_line('Employee Detail');
dbms_output.put_line('Employee Number:' || l_emp_id);
dbms_output.put_line('Employee Name:' || l_emp_name);
dbms_output.put_line('Employee Salary :' || l_emp_salary);
dbms_output.put_line('Employee Manager Name :' || l_manager);
END;
/

select * from EMPLOYEE;
/


--###CREATE PACKAGE
CREATE OR REPLACE PACKAGE pkg_employee AS

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

--###CREATE PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY pkg_employee AS
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
--## END PACKAGE

BEGIN
    PKG_EMPLOYEE.detailByEmployee(2);
end;

/

drop package body pkg_employee;
/

drop package pkg_employee;
/


--EXECUTE PROCEDURE IN PACKAGE
-- DECLARE
--     code employee.emp_id%type := 9;
BEGIN
--     PKG_EMPLOYEE.addEmployee(20, 'Axel', 555, 'Joko');
--     PKG_EMPLOYEE.listEmployee;
--     PKG_EMPLOYEE.delEmployee(code);
--     PKG_EMPLOYEE.updateEmployee(6, 'Yogi');
    dbms_output.put_line('==== Employee Update ====');
    PKG_EMPLOYEE.listEmployee;
END;
/

BEGIN
PKG_EMPLOYEE.getByEmployee(2);
end;
/

select * from EMPLOYEE;
/

--IMPLICIT CURSOR : auto created by oracle (has atribute %FOUND, %ISOPEN, %NOTFOUND, %ROWCOUNT, %BULK_ROWCOUNT, )
DECLARE
        total_rows NUMBER(9);
BEGIN
        UPDATE EMPz
            SET SALARY = SALARY + 5;
        IF sql%notfound THEN
            DBMS_OUTPUT.put_line('No customer selected');
        ELSIF sql%found THEN
            total_rows := sql%rowcount;
            DBMS_OUTPUT.put_line(total_rows || 'employee selected ');
        END IF;
END;
/

select * from EMPLOYEE;
/


