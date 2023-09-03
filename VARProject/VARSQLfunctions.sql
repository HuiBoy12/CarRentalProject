use var;

insert into security (symbol, industry, currency) values ("Appl", "Telecommunication", "USD");
insert into security (symbol, industry, currency) values("T", "Telecommunication", "USD");
insert into security (symbol, industry, currency) values("IBM", "Technology", "USD");

select * from security;

update security set symbol = "AAPL" where ID = 1;

insert into portfolio (name, description) values ("Zach", "Zach Portfolio");

select * from portfolio;

insert into portfoliodata (portfolioID, securityID, quantity) values (1, 1, 200); 
insert into portfoliodata (portfolioID, securityID, quantity) values (1, 2, 300); 
insert into portfoliodata (portfolioID, securityID, quantity) values (1, 3, 100); 


select * from portfoliodata;

select * from returndata;
select * from data where securityID = 1 and date >= "2020-01-04"  and date <= "2023-01-01";