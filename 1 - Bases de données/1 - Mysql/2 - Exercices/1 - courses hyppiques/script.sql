/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     24/09/2024 09:30:46                          */
/*==============================================================*/

drop database if exists courses203;
create database courses203 collate utf8mb4_general_ci;
use courses203;


/*==============================================================*/
/* Table: CATEGORIE                                             */
/*==============================================================*/
create table CATEGORIE
(
   ID_CATEGORIE         int not null auto_increment,
   NOM_CATEGORIE        varchar(50),
   primary key (ID_CATEGORIE)
) engine=InnoDB;

/*==============================================================*/
/* Table: CHAMP                                                 */
/*==============================================================*/
create table CHAMP
(
   ID_CHAMP             int not null auto_increment,
   NOM_CHAMP            varchar(50),
   NB_PLACES            bigint,
   primary key (ID_CHAMP)
) engine=InnoDB;

/*==============================================================*/
/* Table: CHEVAL                                                */
/*==============================================================*/
create table CHEVAL
(
   ID_CHEVAL            int not null auto_increment,
   ID_PROPRIETAIRE      int not null,
   NOM_CHEVAL           varchar(100),
   DATE_NAISSACE        date,
   SEXE_CHEVAL          varchar(1),
   primary key (ID_CHEVAL)
) engine=InnoDB;

/*==============================================================*/
/* Table: COURSE                                                */
/*==============================================================*/
create table COURSE
(
   ID_COURSE            int not null auto_increment,
   ID_CATEGORIE         int not null,
   ID_CHAMP             int not null,
   NOM_COURSE           varchar(50),
   primary key (ID_COURSE)
) engine=InnoDB;

/*==============================================================*/
/* Table: JOCKEY                                                */
/*==============================================================*/
create table JOCKEY
(
   ID_JOCKEY            int not null auto_increment,
   NOM_JOCKEY           varchar(50),
   PRENOM_JOCKEY        varchar(50),
   primary key (ID_JOCKEY)
) engine=InnoDB;

/*==============================================================*/
/* Table: PARENT                                                */
/*==============================================================*/
create table PARENT
(  ID_CHEVAL        int not null,
   ID_parent            int not null,
   primary key (ID_CHEVAL, ID_parent)
) engine=InnoDB;

/*==============================================================*/
/* Table: PARTICIPE                                             */
/*==============================================================*/
create table PARTICIPE
(
   ID_JOCKEY            int not null,
   ID_CHEVAL            int not null,
   ID_SESSION           int not null,
   CLASSEMENT           int,
   primary key (ID_JOCKEY, ID_CHEVAL, ID_SESSION)
) engine=InnoDB;

/*==============================================================*/
/* Table: PROPRIETAIRE                                          */
/*==============================================================*/
create table PROPRIETAIRE
(
   ID_PROPRIETAIRE      int not null auto_increment,
   NOM_PROPRIETAIRE     varchar(50),
   PRENOM_PROPRIETAIRE  varchar(50),
   primary key (ID_PROPRIETAIRE)
) engine=InnoDB;

/*==============================================================*/
/* Table: SESSION                                               */
/*==============================================================*/
create table SESSION
(
   ID_SESSION           int not null auto_increment,
   ID_COURSE            int not null,
   NOM_SESSION          varchar(50),
   DATE_SESSION         time,
   DOTATION_SESSION     float,
   primary key (ID_SESSION)
) engine=InnoDB;

/*==============================================================*/
/* Table: ORGANISE                                            */
/*==============================================================*/
create table ORGANISE
(
   ID_CHAMP             int not null,
   ID_CATEGORIE         int not null,
   primary key (ID_CHAMP, ID_CATEGORIE)
) engine=InnoDB;

alter table CHEVAL add constraint FK_POSSEDE foreign key (ID_PROPRIETAIRE)
      references PROPRIETAIRE (ID_PROPRIETAIRE) on delete restrict on update restrict;

alter table COURSE add constraint FK_APPARTIENT foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE) on delete restrict on update restrict;

alter table COURSE add constraint FK_SE_DEROULE foreign key (ID_CHAMP)
      references CHAMP (ID_CHAMP) on delete restrict on update restrict;

alter table PARENT add constraint FK_PARENT foreign key (ID_CHEVAL)
      references CHEVAL (ID_CHEVAL) on delete restrict on update restrict;

alter table PARENT add constraint FK_PARENT2 foreign key (ID_PARENT)
      references CHEVAL (ID_CHEVAL) on delete restrict on update restrict;

alter table PARTICIPE add constraint FK_PARTICIPE foreign key (ID_JOCKEY)
      references JOCKEY (ID_JOCKEY) on delete restrict on update restrict;

alter table PARTICIPE add constraint FK_PARTICIPE2 foreign key (ID_CHEVAL)
      references CHEVAL (ID_CHEVAL) on delete restrict on update restrict;

alter table PARTICIPE add constraint FK_PARTICIPE3 foreign key (ID_SESSION)
      references SESSION (ID_SESSION) on delete restrict on update restrict;

alter table SESSION add constraint FK_REALISEE foreign key (ID_COURSE)
      references COURSE (ID_COURSE) on delete restrict on update restrict;

alter table ORGANISE add constraint FK_ORGANISE foreign key (ID_CHAMP)
      references CHAMP (ID_CHAMP) on delete restrict on update restrict;

alter table ORGANISE add constraint FK_ORGANISE2 foreign key (ID_CATEGORIE)
      references CATEGORIE (ID_CATEGORIE) on delete restrict on update restrict;

