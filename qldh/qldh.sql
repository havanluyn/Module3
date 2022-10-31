update orderdetail join product on orderdetail.pID=product.pID
set total=orderdetail.odQuantity*product.pPrice;
SET SQL_SAFE_UPDATES = 0;
update orderr 
join (select sum(orderdetail.total) as s,orderdetail.oID as id from orderdetail group by orderdetail.oID) as sub on sub.id=orderr.oID
set oTotalPrice=sub.s;
