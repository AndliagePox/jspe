create table admin
(
    aid      int auto_increment
        primary key,
    name     varchar(32) null,
    password varchar(32) null
);

create table book
(
    bid   int auto_increment
        primary key,
    name  varchar(64) null,
    reper int         null,
    gross int         null
);

create table product
(
    num      int         not null
        primary key,
    name     varchar(64) null,
    madeTime datetime    null,
    price    float       null
);

create table test
(
    id int null
);

create table user
(
    uid      int auto_increment
        primary key,
    name     varchar(32)   null,
    password varchar(32)   null,
    hold     int default 0 null,
    constraint user_book_bid_fk
        foreign key (hold) references book (bid)
);

INSERT INTO jspe.book (bid, name, reper, gross) VALUES (0, '[system sign]', 0, 0);