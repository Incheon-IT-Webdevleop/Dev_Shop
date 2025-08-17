DROP TABLE IF EXISTS `reviewImg`;
DROP TABLE IF EXISTS `review`;
DROP TABLE IF EXISTS `paymentHistory`;
DROP TABLE IF EXISTS `inquiry`;
DROP TABLE IF EXISTS `productPost`;
DROP TABLE IF EXISTS `size`;
DROP TABLE IF EXISTS `purchase`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `productCategory`;
DROP TABLE IF EXISTS `address`;
DROP TABLE IF EXISTS `profile`;
DROP TABLE IF EXISTS `member`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `faq`;

CREATE TABLE `member` (
	`memberIdx`	BIGINT	NOT NULL AUTO_INCREMENT COMMENT 'auto_increasment',
	`email`	VARCHAR(255)	NOT NULL,
	`password`	VARCHAR(255)	NOT NULL,
	`name`	VARCHAR(10)	NOT NULL,
	`phone`	VARCHAR(20)	NOT NULL,
	`loginType`	VARCHAR(10)	NOT NULL,
	`isActive`	boolean	NOT NULL	DEFAULT true,
	`role`	smallint	NOT NULL	DEFAULT 0	COMMENT '0:일반회원, 1: 일반관리자, 2:최고관리자',
	`joinAt`	datetime	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`lastLoginAt`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`memberIdx`)
);

CREATE TABLE `profile` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT,
	`memberIdx`	BIGINT	NOT NULL,
	`imgName`	VARCHAR(255)	NULL,
	`imgPath`	TEXT	NULL,
	`updatedAt`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`)
);

CREATE TABLE `productCategory` (
	`productCategoryIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`name`	VARCHAR(20)	NOT NULL,
	`major`	boolean	NOT NULL	COMMENT '0:대분류 1: 소분류',
	PRIMARY KEY (`productCategoryIdx`)
);

CREATE TABLE `products` (
	`productIdx`	bigint	NOT NULL AUTO_INCREMENT,
	`productName`	VARCHAR(255)	NOT NULL,
	`createdAt`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL,
	`price`	int(8)	NOT NULL,
	`productCode`	int	NOT NULL,
	`productCategoryIdx`	bigint	NOT NULL,
	PRIMARY KEY (`productIdx`),
	FOREIGN KEY (`productCategoryIdx`) REFERENCES `productCategory` (`productCategoryIdx`)
);

CREATE TABLE `faq` (
	`faqIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`contentType`	boolean	NOT NULL	COMMENT '0 : faq, 1:공지',
	`question`	VARCHAR(255)	NULL	COMMENT '공지사항일때는 null가능',
	`answer`	VARCHAR(255)	NOT NULL,
	PRIMARY KEY (`faqIdx`)
);

CREATE TABLE `orders` (
	`orderIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
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
	`quantity`	int	NOT NULL,
	PRIMARY KEY (`orderIdx`),
	FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`),
	FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`)
);

CREATE TABLE `paymentHistory` (
	`paymentIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`memberIdx`	BIGINT	NOT NULL,
	`orderIdx`	BIGINT	NOT NULL,
	`productIdx`	BIGINT	NOT NULL,
	`price`	int	NOT NULL,
	`totalPrice`	int	NOT NULL,
	`createdAt`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`status`	BOOLEAN	NOT NULL	DEFAULT False,
	PRIMARY KEY (`paymentIdx`),
	FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`),
	FOREIGN KEY (`orderIdx`) REFERENCES `orders` (`orderIdx`),
	FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`)
);

CREATE TABLE `productPost` (
	`productIdx`	BIGINT	NOT NULL,
	`deliveryFee`	int	NOT NULL,
	`discountRate`	int	NOT NULL,
	`productImgName`	VARCHAR(255)	NOT NULL,
	`productImgPath`	VARCHAR(255)	NOT NULL,
	`productDetails`	LongText	NOT NULL,
	`isPublished`	boolean	NOT NULL	DEFAULT true	COMMENT 'true:게시, false:미게시',
	`isDelete`	boolean	NOT NULL	DEFAULT false	COMMENT 'false:삭제안됨 true: 삭제됨',
	PRIMARY KEY (`productIdx`),
	FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`)
);

CREATE TABLE `inquiry` (
	`inquiryIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`category`	VARCHAR(20)	NOT NULL,
	`content`	VARCHAR(255)	NOT NULL,
	`createdAt`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`orderIdx`	bigint	NULL,
	`productIdx`	bigint	NULL,
	`answer`	VARCHAR(255)	NULL	COMMENT '답변내용',
	`answeredAt`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`inquiryIdx`),
	FOREIGN KEY (`orderIdx`) REFERENCES `orders` (`orderIdx`),
	FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`)
);

CREATE TABLE `size` (
	`optionIdx`	bigint	NOT NULL AUTO_INCREMENT,
	`size`	VARCHAR(10)	NULL,
	`color`	VARCHAR(20)	NULL,
	`optionStock`	int	NULL,
	`productIdx`	bigint	NOT NULL,
	PRIMARY KEY (`optionIdx`),
	FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`)
);

CREATE TABLE `purchase` (
	`purchaseIdx`	bigint	NOT NULL AUTO_INCREMENT,
	`productIdx`	bigint	NOT NULL,
	`purchaseDate`	DATETIME	NOT NULL,
	`correspondent`	VARCHAR(50)	NOT NULL,
	`correspondentNum`	int	NOT NULL,
	`correspondentPhone`	int	NOT NULL,
	`productOption`	VARCHAR(50)	NOT NULL,
	`productCost`	int	NOT NULL,
	`quantity`	int	NOT NULL,
	`status`	boolean	NOT NULL	DEFAULT false	COMMENT 'false:"임시저장", true:"매입확정""',
	PRIMARY KEY (`purchaseIdx`),
	FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`)
);

CREATE TABLE `address` (
	`addressIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`memberIdx`	BIGINT	NOT NULL,
	`addressName`	VARCHAR(50)	NOT NULL,
	`postCode`	int(6)	NOT NULL,
	`address`	VARCHAR(255)	NOT NULL,
	`detailAddress`	VARCHAR(255)	NOT NULL,
	`recipient`	VARCHAR(10)	NOT NULL,
	`recipientPhone`	int	NOT NULL,
	`createdAt`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL	DEFAULT CURRENT_TIMESTAMP,
	`IsDefault`	Boolean	NOT NULL	DEFAULT False,
	PRIMARY KEY (`addressIdx`),
	FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`)
);

CREATE TABLE `category` (
	`categoryIdx`	VARCHAR(5)	NOT NULL	COMMENT '010 - p1',
	`categoryName`	VARCHAR(30)	NOT NULL,
	PRIMARY KEY (`categoryIdx`)
);

CREATE TABLE `review` (
	`reviewIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`rating`	int	NOT NULL,
	`reviewContent`	VARCHAR(255)	NOT NULL,
	`isSecret`	boolean	NOT NULL	DEFAULT false	COMMENT 'false:공개, true:비공개',
	`memberIdx`	bigint	NOT NULL,
	`orderIdx`	bigint	NOT NULL,
	`productIdx`	bigint	NOT NULL,
	PRIMARY KEY (`reviewIdx`),
	FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`),
	FOREIGN KEY (`orderIdx`) REFERENCES `orders` (`orderIdx`),
	FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`)
);

CREATE TABLE `reviewImg` (
	`reviewImgIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`reviewImgPath`	VARCHAR(255)	NOT NULL,
	`reviewIdx`	bigint	NOT NULL,
	`productIdx`	bigint	NOT NULL,
	PRIMARY KEY (`reviewImgIdx`),
	FOREIGN KEY (`reviewIdx`) REFERENCES `review` (`reviewIdx`),
	FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`)
);