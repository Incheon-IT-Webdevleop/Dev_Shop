DROP TABLE IF EXISTS `profile`;

CREATE TABLE `profile` (
	`id`	BIGINT	NOT NULL,
	`memberIdx`	BIGINT	NOT NULL,
	`imgName`	VARCHAR(255)	NULL,
	`imgPath`	TEXT	NULL,
	`updatedAt`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `productCatogory`;

CREATE TABLE `productCatogory` (
	`productCategoryIdx`	BIGINT	NOT NULL,
	`name`	VARCHAR(20)	NOT NULL,
	`major`	boolean	NOT NULL	COMMENT '0:대분류 1: 소분류'
);

DROP TABLE IF EXISTS `FAQ`;

CREATE TABLE `FAQ` (
	`faqIdx`	BIGINT	NOT NULL,
	`contetnType`	boolean	NOT NULL	COMMENT '0 : faq, 1:공지',
	`question`	VARCHAR(255)	NULL	COMMENT '공지사항일때는 null가능',
	`answer`	VARCHAR(255)	NOT NULL
);

DROP TABLE IF EXISTS `Orders`;

CREATE TABLE `Orders` (
	`orderIdx`	BIGINT	NOT NULL,
	`productIdx`	BIGINT	NOT NULL,
	`memberIdx`	BIGINT	NOT NULL,
	`payMethod`	VARCHAR(10)	NOT NULL,
	`TotalPrice`	INT	NOT NULL,
	`address`	VARCHAR(100)	NOT NULL,
	`detailAddress`	VARCHAR(100)	NOT NULL,
	`name`	VARCHAR(10)	NOT NULL,
	`postCode`	int(6)	NOT NULL,
	`phone`	VARCHAR(20)	NOT NULL,
	`ispayed`	Boolean	NULL	DEFAULT false,
	`orderAt`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`quantity`	int	NOT NULL
);

DROP TABLE IF EXISTS `PaymentHistory`;

CREATE TABLE `PaymentHistory` (
	`paymentIdx`	BIGINT	NOT NULL,
	`memberIdx`	BIGINT	NOT NULL,
	`orderIdx`	BIGINT	NOT NULL,
	`productIdx`	BIGINT	NOT NULL,
	`price`	int	NOT NULL,
	`totalPrice`	int	NOT NULL,
	`createdAt`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`status`	BOOLEAN	NOT NULL	DEFAULT False
);

DROP TABLE IF EXISTS `productPost`;

CREATE TABLE `productPost` (
	`productIdx`	BIGINT	NOT NULL,
	`delivery Fee`	int	NOT NULL,
	`discountRate`	int	NOT NULL,
	`productImgName`	VARCHAR(255)	NOT NULL,
	`productImgPath`	VARCHAR(255)	NOT NULL,
	`productDetails`	LongText	NOT NULL,
	`isPublished`	boolean	NOT NULL	DEFAULT true	COMMENT 'true:게시, false:미게시',
	`isDelete`	boolean	NOT NULL	DEFAULT false	COMMENT 'false:삭제안됨 true: 삭제됨'
);

DROP TABLE IF EXISTS `Inquery`;

CREATE TABLE `Inquery` (
	`inqueryIdx`	BIGINT	NOT NULL,
	`category`	VARCHAR(20)	NOT NULL,
	`content`	VARCHAR(255)	NOT NULL,
	`createAt`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`orderIdx`	bigint	NULL,
	`productIdx`	bigint	NULL,
	`answer`	bigint	NULL,
	`answerAt`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `size`;

CREATE TABLE `size` (
	`optionIdx`	bigint	NOT NULL,
	`size`	VARCHAR(10)	NULL,
	`color`	VARCHAR(20)	NULL,
	`optionStock`	int	NULL,
	`productIdx`	bigint	NOT NULL
);

DROP TABLE IF EXISTS `purchaseInfo`;

CREATE TABLE `purchaseInfo` (
	`purchaseIdx`	bigint	NOT NULL,
	`productIdx`	bigint	NOT NULL,
	`purchaseDate`	DATETIME	NOT NULL,
	`correspondent`	VARCHAR(50)	NOT NULL,
	`correspondentNum`	int	NOT NULL,
	`correspondentPhon`	int	NOT NULL,
	`productOption`	VARCHAR(50)	NOT NULL,
	`productCost`	int	NOT NULL,
	`quantity`	int	NOT NULL,
	`status`	boolean	NOT NULL	DEFAULT false	COMMENT 'false:"임시저장", true:"매입확정""'
);

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
	`addressIdx`	BIGINT	NOT NULL,
	`memberIdx`	BIGINT	NOT NULL,
	`addressName`	VARCHAR(50)	NOT NULL,
	`postCode`	int(6)	NOT NULL,
	`address`	VARCHAR(255)	NOT NULL,
	`detail_address`	VARCHAR(255)	NOT NULL,
	`recipient`	VARCHAR(10)	NOT NULL,
	`recipientPhone`	int	NOT NULL,
	`createdAt`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP,
	`IsDefault`	Boolean	NOT NULL	DEFAULT False
);

DROP TABLE IF EXISTS `Category`;

CREATE TABLE `Category` (
	`categoryIdx`	VARCHAR(5)	NOT NULL	COMMENT '010 - p1',
	`categoryName`	VARCHAR(30)	NOT NULL
);

DROP TABLE IF EXISTS `Products`;

CREATE TABLE `Products` (
	`productIdx`	bigint	NOT NULL,
	`productName`	VARCHAR(255)	NOT NULL,
	`createdAt`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL,
	`price`	int(8)	NOT NULL,
	`productCode`	int	NOT NULL,
	`productCategoryIdx`	bigint	NOT NULL
);

DROP TABLE IF EXISTS `reviewImg`;

CREATE TABLE `reviewImg` (
	`reviewImgIdx`	BIGINT	NOT NULL,
	`reviewImgPath`	VARCHAR(255)	NOT NULL,
	`reviewIdx`	bigint	NOT NULL,
	`productIdx`	bigint	NOT NULL
);

DROP TABLE IF EXISTS `Member`;

CREATE TABLE `Member` (
	`memberIdx`	BIGINT	NOT NULL,
	`email`	VARCHAR(255)	NOT NULL,
	`password`	VARCHAR(255)	NOT NULL,
	`name`	VARCHAR(10)	NOT NULL,
	`phone`	VARCHAR(20)	NOT NULL,
	`loginType`	VARCHAR(10)	NOT NULL,
	`isActive`	boolean	NOT NULL	DEFAULT true,
	`role`	smallint	NOT NULL	DEFAULT 0	COMMENT '0:일반회원, 1: 일반관리자, 2:최고관리자',
	`joinAt`	datetime	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`lastLoginAt`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
	`reviewIdx`	BIGINT	NOT NULL,
	`rating`	int	NOT NULL,
	`reviewContent`	VARCHAR(255)	NOT NULL,
	`isSecret`	boolean	NOT NULL	DEFAULT false	COMMENT 'false:공개, true:비공개',
	`memberIdx`	bigint	NOT NULL,
	`orderIdx`	bigint	NOT NULL,
	`productIdx`	bigint	NOT NULL
);

ALTER TABLE `profile` ADD CONSTRAINT `PK_PROFILE` PRIMARY KEY (
	`id`,
	`memberIdx`
);

ALTER TABLE `productCatogory` ADD CONSTRAINT `PK_PRODUCTCATOGORY` PRIMARY KEY (
	`productCategoryIdx`
);

ALTER TABLE `FAQ` ADD CONSTRAINT `PK_FAQ` PRIMARY KEY (
	`faqIdx`
);

ALTER TABLE `Orders` ADD CONSTRAINT `PK_ORDERS` PRIMARY KEY (
	`orderIdx`,
	`productIdx`
);

ALTER TABLE `PaymentHistory` ADD CONSTRAINT `PK_PAYMENTHISTORY` PRIMARY KEY (
	`paymentIdx`
);

ALTER TABLE `productPost` ADD CONSTRAINT `PK_PRODUCTPOST` PRIMARY KEY (
	`productIdx`
);

ALTER TABLE `Inquery` ADD CONSTRAINT `PK_INQUERY` PRIMARY KEY (
	`inqueryIdx`
);

ALTER TABLE `size` ADD CONSTRAINT `PK_SIZE` PRIMARY KEY (
	`optionIdx`
);

ALTER TABLE `purchaseInfo` ADD CONSTRAINT `PK_PURCHASEINFO` PRIMARY KEY (
	`purchaseIdx`,
	`productIdx`
);

ALTER TABLE `address` ADD CONSTRAINT `PK_ADDRESS` PRIMARY KEY (
	`addressIdx`,
	`memberIdx`
);

ALTER TABLE `Category` ADD CONSTRAINT `PK_CATEGORY` PRIMARY KEY (
	`categoryIdx`
);

ALTER TABLE `Products` ADD CONSTRAINT `PK_PRODUCTS` PRIMARY KEY (
	`productIdx`
);

ALTER TABLE `reviewImg` ADD CONSTRAINT `PK_REVIEWIMG` PRIMARY KEY (
	`reviewImgIdx`
);

ALTER TABLE `Member` ADD CONSTRAINT `PK_MEMBER` PRIMARY KEY (
	`memberIdx`
);

ALTER TABLE `review` ADD CONSTRAINT `PK_REVIEW` PRIMARY KEY (
	`reviewIdx`
);

ALTER TABLE `profile` ADD CONSTRAINT `FK_Member_TO_profile_1` FOREIGN KEY (
	`memberIdx`
)
REFERENCES `Member` (
	`memberIdx`
);

ALTER TABLE `Orders` ADD CONSTRAINT `FK_Products_TO_Orders_1` FOREIGN KEY (
	`productIdx`
)
REFERENCES `Products` (
	`productIdx`
);

ALTER TABLE `productPost` ADD CONSTRAINT `FK_Products_TO_productPost_1` FOREIGN KEY (
	`productIdx`
)
REFERENCES `Products` (
	`productIdx`
);

ALTER TABLE `purchaseInfo` ADD CONSTRAINT `FK_Products_TO_purchaseInfo_1` FOREIGN KEY (
	`productIdx`
)
REFERENCES `Products` (
	`productIdx`
);

ALTER TABLE `address` ADD CONSTRAINT `FK_Member_TO_address_1` FOREIGN KEY (
	`memberIdx`
)
REFERENCES `Member` (
	`memberIdx`
);

