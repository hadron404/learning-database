# tag::table-design[]
create table wechat_info
(
    Id             int auto_increment comment '主键'
        primary key,
    Code           varchar(20)                        null comment '编码',
    CompanyId      bigint                             null comment '对应部门公司的ID',
    AppId          varchar(50)                        null comment 'AppId',
    Type           smallint default 1                 null comment '微信类别：1（公众号），2（小程序）3-视频号 4-企业微信',
    IsDeleted      tinyint  default 0                 null comment '是否可用 0:可用 1：不可用'
)
    comment '微信应用配置表';

create table wechat_customer_wxid
(
    Id               int auto_increment
        primary key,
    CustomerId       bigint             null,
    WechatId         bigint             null comment 'wechatInfo 表主键',
    WxId             varchar(50)        null comment '微信ID,小程序、公众号、视频号为openid，企业微信为外部联系人ID',
    IsDeleted        smallint default 0 null comment '是否删除'
)
    comment '微信客户关联表';

create table wework_customer_belong
(
    Id           int auto_increment
        primary key,
    CustomerId   bigint                 not null comment '客户ID',
    UserId       varchar(20)            null comment '企业userid',
    AddWay       int(10)                null comment '客户添加来源 0:未知来源，1:扫描二维码，2：搜索手机号，3：名片分享，4：群聊，5：手机通讯录，6：微信联系人，8：安装第三方应用时自动添加的客服人员，9：搜索邮箱，10：视频号添加，201：内部成员共享，202：管理员/负责人分配',
    IsDeleted    smallint    default 0  null comment '是否删除',
    CreateTime   datetime               null
)
    comment '企业微信客户关表';

create table wechat_customer
(
    Id           bigint auto_increment
        primary key,
    Name         varchar(255)       null,
    CorpName     varchar(255)       null,
    CorpFullName varchar(255)       null comment '外部联系人所在企业的简称，仅当联系人类型是企业微信用户时有此字段',
    Type         int(2)             null comment '外部联系人的类型，1表示该外部联系人是微信用户，2表示该外部联系人是企业微信用户',
    UnionId      varchar(255)       null comment '微信开放平台的唯一身份标识（微信unionid），通过此字段企业可将外部联系人与公众号/小程序用户关联起来。仅当联系人类型是微信用户，且企业绑定了微信开发者ID有此字段。查看绑定方法。第三方不可获取，上游企业不可获取下游企业客户的unionid字段'
)
    comment '微信客户信息表';

create table wework_user
(
    Id             bigint auto_increment
        primary key,
    UserId         varchar(255)                       not null,
    Name           varchar(255)                       null,
    IsDeleted      tinyint  default 0                 not null comment '是否删除',
    DepartmentId   varchar(255)                       null comment '部门id',
    CorpName       varchar(255)                       null comment '所属公司'
);
# end::table-design[]

# tag::index-design-first[]

# wechat_customer_wxid t4 对 wechatId 、customerId 字段 加索引
## wechatId 加普通索引
ALTER TABLE wechat_customer_wxid
    ADD INDEX Idx_WechatId (WechatId);
## customerId 加普通索引
ALTER TABLE wechat_customer_wxid
    ADD INDEX Idx_CustomerId (CustomerId);
## wechatId 和 customerId 加组合索引
ALTER TABLE wechat_customer_wxid
    ADD INDEX Idx_WechatId_CustomerId (WechatId,CustomerId);


# wework_customer_belong t2 对 customerId、userId 字段 加索引
## userId 加普通索引
ALTER TABLE wework_customer_belong
    ADD INDEX Idx_UserId (UserId);
## customerId,userId 加组合索引
ALTER TABLE wework_customer_belong
    ADD INDEX Idx_CustomerId_UserId (CustomerId,UserId);
# wework_user t1 对 userId 加索引
ALTER TABLE wework_user
    ADD INDEX Idx_UserId (UserId);

# end::index-design-first[]