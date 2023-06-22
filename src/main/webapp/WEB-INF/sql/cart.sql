select * from tb_basket;

select *
from tb_basket bk join tb_sales sl
on bk.ss_num = sl.ss_num
where mem_id = '12345';

select bk_amount, mem_id, ss_name, ss_img, ss_price, bk_amount*sl.ss_price as total
from tb_basket bk join tb_sales sl
                       on bk.ss_num = sl.ss_num
where mem_id = '12345';


select bk_amount, mem_id, ss_name, ss_img, ss_price, bk_amount*sl.ss_price as total
from tb_basket bk join tb_sales sl
                       on bk.ss_num = sl.ss_num
where mem_id = '12345'
group by mem_id;

select sum(total)
from (
        select mem_id, bk_amount*sl.ss_price as total
        from tb_basket bk join tb_sales sl
                               on bk.ss_num = sl.ss_num
        where mem_id = '12345'
    ) AA
group by mem_id;


select mem_id, bk_amount*sl.ss_price as total
from tb_basket bk join tb_sales sl
                       on bk.ss_num = sl.ss_num
where mem_id = '12345';

select