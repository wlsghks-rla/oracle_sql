alter session set "_ORACLE_SCRIPT"=true;

create user scott identified by tiger
default tablespace users
temporary tablespace temp;

grant connect, resource, unlimited tablespace to scott;
grant create view to scott;
grant create public synonym to scott;
grant create synonym to scott;

ALTER SESSION SET "_ORACLE_SCRIPT"=true;

 alter USER  hr
 IDENTIFIED BY hr
 DEFAULT TABLESPACE users
 TEMPORARY TABLESPACE temp;
 
 GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE
 TO   hr;
 
 select *
 from all_users
 order by 1;
 
 -- p.448 ½Ç½À
 select tablespace_name, bytes/1024/1024 MB, file_name
 from dba_data_files;
 
 alter database datafile 'C:\APP\ADMIN\PRODUCT\21C\ORADATA\XE\USERS01.DBF' autoextend on;