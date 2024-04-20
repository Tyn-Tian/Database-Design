create database belajar_mysql_notification;

show tables;

# User

create table user (
	id varchar(100) not null,
    name varchar(100) not null,
    primary key (id)
) engine = InnoDB;

insert into user(id, name) values ("Tian", "Christian");
insert into user(id, name) values ("Budi", "Budi Nugraha");

select * from user;

# Notification

create table notification (
	id int not null auto_increment,
    title varchar(255) not null,
    detail text not null,
    created_at timestamp not null,
    user_id varchar(100),
    primary key (id)
) engine = InnoDB;

alter table notification
	add constraint fk_notification_user
		foreign key (user_id) references user (id);
        
desc notification;

insert into notification(title, detail, created_at, user_id)
values ("Contoh Pesanan", "Detail Pesanan", current_timestamp(), "Tian");

insert into notification(title, detail, created_at, user_id)
values ("Contoh Promo", "Detail Promo", current_timestamp(), null);

insert into notification(title, detail, created_at, user_id)
values ("Contoh Pembayaran", "Detail Pembayaran", current_timestamp(), "Budi");

select * from notification;

select * from notification
where (user_id = "Tian" or user_id is null)
order by created_at desc;

select * from notification
where (user_id = "Budi" or user_id is null)
order by created_at desc;

# Category

create table category (
	id varchar(100) not null,
    name varchar(100) not null,
    primary key (id)
) engine = InnoDB;

alter table notification
	add column category_id varchar(100);
    
desc notification;

alter table notification
	add constraint fk_notification_category
		foreign key (category_id) references category (id);
        
insert into category(id, name) values ("INFO", "Info");
insert into category(id, name) values ("PROMO", "Promo");

select * from category;

update notification
set category_id = "INFO"
where (id = 1 or id = 3);

update notification
set category_id = "PROMO"
where id = 2;

select * from notification;

select * 
from notification n
	join category c on (n.category_id = c.id)
where (n.user_id = "Tian" or n.user_id is null)
order by n.created_at desc;

select * 
from notification n
	join category c on (n.category_id = c.id)
where (n.user_id = "Budi" or n.user_id is null)
order by n.created_at desc;

select * 
from notification n
	join category c on (n.category_id = c.id)
where (n.user_id = "Tian" or n.user_id is null)
and n.category_id = "INFO"
order by n.created_at desc;

# Notification Read

create table notification_read (
	id int not null auto_increment,
    is_read boolean not null,
    notification_id int not null,
    user_id varchar(100) not null,
    primary key (id)
) engine = InnoDB;

alter table notification_read
	add constraint fk_notification_read_notification
		foreign key (notification_id) references notification (id);
        
alter table notification_read
	add constraint fk_notification_read_user
		foreign key (user_id) references user (id);
        
desc notification_read;

select * from notification;

insert into notification_read(is_read, notification_id, user_id)
values (true, 2, "Tian");

insert into notification_read(is_read, notification_id, user_id)
values (true, 2, "Budi");

select * from notification_read;

select * 
from notification n
	join category c on (n.category_id = c.id)
    left join notification_read nr on (nr.notification_id = n.id)
where (n.user_id = "Tian" or n.user_id is null)
and (nr.user_id = "Tian" or nr.user_id is null)
order by n.created_at desc;

insert into notification(title, detail, created_at, user_id, category_id)
values ("Contoh Pesanan Lagi", "Detail Pesanan Lagi", current_timestamp(), "Tian", "INFO");

insert into notification(title, detail, created_at, user_id, category_id)
values ("Contoh Promo Lagi", "Detail Promo Lagi", current_timestamp(), null, "PROMO");


# Counter

select count(*)
from notification n
	join category c on (c.id = n.category_id)
    left join notification_read nr on (nr.notification_id = n.id)
where (n.user_id = "Tian" or n.user_id is null)
and (n.user_id is null)
order by n.created_at desc;