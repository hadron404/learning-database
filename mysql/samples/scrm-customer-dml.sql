# tag::requirements[]
select t4.CustomerId,t2.Id,t2.state,t2.AddWay,t2.UserId,t1.CorpName,t1.Enable
from wechat_info t5
         left join wechat_customer_wxid t4 on t4.WechatId = t5.Id
         inner join wechat_customer t3 on t3.Id = t4.CustomerId
         inner join wework_customer_belong t2 on t2.CustomerId = t3.Id
         left join wework_user t1 on t1.UserId = t2.UserId
where t5.Type = 4 and t5.Id = 122
  and  t5.IsDeleted = 0
  and t4.IsDeleted = 0
  and t3.IsDeleted = 0
  and t2.IsDeleted = 0
  and t1.IsDeleted = 0
order by t2.Id desc
LIMIT 20, 20;
# end::requirements[]
