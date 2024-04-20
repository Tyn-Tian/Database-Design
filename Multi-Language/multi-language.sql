create database belajar_mysql_multi_bahasa;

create table categories (
	id varchar(100) not null,
    position int not null,
    primary key (id)
) engine = InnoDB;

desc categories;

insert into categories(id, position) values ("FOOD", 1);
insert into categories(id, position) values ("GADGET", 2);
insert into categories(id, position) values ("FASHION", 3);

select * from categories
order by position;

create table categories_translations (
	category_id varchar(100) not null,
    language varchar(100) not null,
    name varchar(100) not null,
    description text,
    primary key (category_id, language)
) engine = InnoDB;

desc categories_translations;

alter table categories_translations
	add constraint fk_categories_translation
		foreign key (category_id) references categories (id);
        
insert into categories_translations(category_id, language, name, description)
values ("FOOD", "ID", "Makanan", "Deskripsi Makanan");
insert into categories_translations(category_id, language, name, description)
values ("FOOD", "US", "Food", "Food Description");

insert into categories_translations(category_id, language, name, description)
values ("GADGET", "ID", "Gawai", "Deskripsi Gawai");
insert into categories_translations(category_id, language, name, description)
values ("GADGET", "US", "Gadget", "Gadget Description");

select * from categories c
	join categories_translations ct on (c.id = ct.category_id)
where ct.language = "ID"
order by c.position;





