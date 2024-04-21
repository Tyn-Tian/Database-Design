create database belajar_mysql_spotify;

create table user (
	user_id varchar(100) not null,
    email varchar(100) not null,
    name varchar(100) not null, 
    birthday date,
    primary key (user_id)
) engine = InnoDB;

create table playlist (
	playlist_id varchar(100) not null, 
    name varchar(100) not null,
    description text,
    user_id varchar(100) not null,
    primary key (playlist_id),
    constraint fk_playlist_user
    foreign key (user_id) references user (user_id)
) engine = InnoDB;

desc playlist;

create table playlist_category (
	category_id varchar(100) not null,
    name varchar(100) not null,
    primary key (category_id)
) engine = InnoDB;

alter table playlist
	add column category_id varchar(100) not null;
    
alter table playlist
	add constraint fk_playlist_category
    foreign key (category_id) references playlist_category (category_id);

create table song (
	song_id varchar(100) not null,
    title varchar(100) not null,
    duration int not null,
    primary key (song_id)
) engine = InnoDB;

create table contains_song (
	playlist_id varchar(100) not null,
    song_id varchar(100) not null,
    constraint fk_contains_song_playlist
		foreign key (playlist_id) references playlist (playlist_id),
	constraint fk_contains_song
		foreign key (song_id) references song (song_id)
) engine = InnoDB;

desc contains_song;

create table album (
	album_id varchar(100) not null,
    title varchar(100) not null,
    release_date date not null,
    primary key (album_id)
) engine = InnoDB;

alter table song
	add column album_id varchar(100) not null;
    
alter table song 
	add constraint fk_song_album
		foreign key (album_id) references album (album_id);
        
desc song;

create table artist (
	artist_id varchar(100) not null,
    name varchar(100) not null,
    bio text,
    primary key (artist_id)
) engine = InnoDB;

create table has_album (
	artist_id varchar(100) not null,
    album_id varchar(100) not null,
    constraint fk_has_album_artis
		foreign key (artist_id) references artist (artist_id),
	constraint fk_has_album
		foreign key (album_id) references album (album_id)
) engine = InnoDB;

desc has_album;

create table follow_artist (
	user_id varchar(100) not null,
    artist_id varchar(100) not null,
    constraint fk_follow_artist_user
		foreign key (user_id) references user (user_id),
	constraint fk_follow_artist
		foreign key (artist_id) references artist (artist_id)
) engine = InnoDB;

desc follow_artist;

create table follow_playlist (
	user_id varchar(100) not null,
    playlist_id varchar(100) not null,
    constraint fk_follow_playlist_user
		foreign key (user_id) references user (user_id),
	constraint fk_follow_playlist
		foreign key (playlist_id) references playlist (playlist_id)
) engine = InnoDB;

desc follow_playlist;


