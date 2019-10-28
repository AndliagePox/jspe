create database jspe;

use jspe;

create table test(id int);

insert into test values (2);
insert into test values (8);
insert into test values (231);
insert into test values (321);
insert into test values (8333);
insert into test values (811);
insert into test values (4218);
insert into test values (81);
insert into test values (3231);
insert into test values (13212);
insert into test values (834);
insert into test values (328);
insert into test values (7);
insert into test values (77);

create table product(
    num int primary key ,
    name varchar(64),
    madeTime datetime,
    price float
);