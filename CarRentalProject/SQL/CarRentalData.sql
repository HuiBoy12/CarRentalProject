insert into vehicletype values (1, "Small Car", 10);
insert into vehicletype values (2, "Family Car", 20);
insert into vehicletype values (3, "Van", 30);

insert into vehicleinventory values(1, 50);
insert into vehicleinventory values(2, 20);
insert into vehicleinventory values(3, 5);

update vehicleinventory set count = 49 where typeid = 1;
SELECT vi.count, vi.typeid from vehicleinventory vi, vehicletype vt where vi.typeid = vt.ID and vt.type = "Small Car";



select count from vehicleinventory where typeid = 1;
select * from vehicletype;
select * from vehicleinventory;

select * from booking;

select * from customer;
delete from booking

