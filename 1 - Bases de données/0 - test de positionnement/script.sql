-- Methode 1

drop database if exists location_203_25;
create database location_203_25 collate utf8mb4_general_ci;

use location_203_25;

create table contrat (id_contrat int auto_increment primary key,
					 date_creation date, 
					 date_entree date, 
                     date_sortie date, 
                     charges float, 
                     loyer_contrat float, 
                     reference int not null, 
                     id_client int not null);
                     
create table bien (reference int auto_increment primary key,
					superficie float, 
                    nb_pieces smallint, 
                    loyer float, 
                    id_client int not null, 
                    id_type int not null,
                    id_quartier int not null);
                    
create table ville (id_ville int auto_increment primary key,
					nom_ville varchar(50) not null);
                    
create table quartier (id_quartier int auto_increment primary key,
						nom_quartier varchar(50) not null, 
                        id_ville int not null);
                        
create table type (id_type int auto_increment primary key,
					nom_type varchar(50) not null);
                    
create table client (id_client int auto_increment primary key,
						nom_client varchar(50) not null, 
                        prenom_client varchar(50) , 
                        adresse varchar(150) , 
                        telephone varchar(30) );


alter table quartier add constraint fk_quartier_ville foreign key (id_ville) 
						references ville(id_ville) on delete cascade on update cascade;

alter table bien add constraint fk_bien_quartier foreign key (id_quartier) 
						references quartier(id_quartier) on delete cascade on update cascade; 
alter table bien add constraint fk_bien_type foreign key (id_type) 
						references type(id_type) on delete cascade on update cascade; 
alter table bien add constraint fk_bien_client foreign key (id_client) 
						references client(id_client) on delete cascade on update cascade; 

alter table contrat add constraint fk_contrat_bien foreign key (reference) 
						references bien(reference) on delete cascade on update cascade; 
alter table contrat add constraint fk_contrat_client foreign key (id_client) 
						references client(id_client) on delete cascade on update cascade; 



-- Methode 2

drop database if exists location_203_25;
create database location_203_25 collate utf8mb4_general_ci;

use location_203_25;


                     

                    
create table ville (id_ville int auto_increment primary key,
					nom_ville varchar(50) not null);
                    
create table quartier (id_quartier int auto_increment primary key,
						nom_quartier varchar(50) not null, 
                        id_ville int not null,
                        constraint fk_quartier_ville foreign key (id_ville) 
						references ville(id_ville) on delete cascade on update cascade);
                        
create table type (id_type int auto_increment primary key,
					nom_type varchar(50) not null);
                    
create table client (id_client int auto_increment primary key,
						nom_client varchar(50) not null, 
                        prenom_client varchar(50) , 
                        adresse varchar(150) , 
                        telephone varchar(30) );

create table bien (reference int auto_increment primary key,
					superficie float, 
                    nb_pieces smallint, 
                    loyer float, 
                    id_client int not null, 
                    id_type int not null,
                    id_quartier int not null,
                    constraint fk_bien_quartier foreign key (id_quartier) 
						references quartier(id_quartier) on delete cascade on update cascade,
					constraint fk_bien_type foreign key (id_type) 
						references type(id_type) on delete cascade on update cascade,
					constraint fk_bien_client foreign key (id_client) 
						references client(id_client) on delete cascade on update cascade
                    );
                    
  
  create table contrat (id_contrat int auto_increment primary key,
					 date_creation date, 
					 date_entree date, 
                     date_sortie date, 
                     charges float, 
                     loyer_contrat float, 
                     reference int not null, 
                     id_client int not null,
					 constraint fk_contrat_bien foreign key (reference) 
							references bien(reference) on delete cascade on update cascade, 
					constraint fk_contrat_client foreign key (id_client) 
						references client(id_client) on delete cascade on update cascade                  
                     
                     );

