-- 회원 테이블
CREATE TABLE `member` (
	`memberIdx`	BIGINT	NOT NULL AUTO_INCREMENT COMMENT '회원 고유번호',
	`email`	VARCHAR(255)	NOT NULL UNIQUE COMMENT '이메일 (중복 불가)',
	`password`	VARCHAR(255)	NOT NULL COMMENT '암호화된 비밀번호',
	`name`	VARCHAR(50)	NOT NULL COMMENT '회원명',
	`phone`	VARCHAR(20)	NOT NULL COMMENT '전화번호',
	`loginType`	VARCHAR(10)	NOT NULL DEFAULT 'LOCAL' COMMENT 'LOCAL, GOOGLE, KAKAO 등',
	`isActive`	BOOLEAN	NOT NULL DEFAULT TRUE COMMENT '계정 활성화 상태',
	`role`	TINYINT	NOT NULL DEFAULT 0 COMMENT '0:일반회원, 1:관리자, 2:최고관리자',
	`joinedAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '가입일시',
	`lastLoginAt`	DATETIME	NULL COMMENT '마지막 로그인 일시',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`memberIdx`),
	INDEX `idx_email` (`email`),
	INDEX `idx_phone` (`phone`)
) COMMENT '회원 정보';

-- 회원 프로필 테이블
CREATE TABLE `profile` (
	`profileIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`memberIdx`	BIGINT	NOT NULL COMMENT '회원 고유번호',
	`imgName`	VARCHAR(255)	NULL COMMENT '프로필 이미지 파일명',
	`imgPath`	TEXT	NULL COMMENT '프로필 이미지 경로',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`profileIdx`),
	UNIQUE KEY `uk_member_profile` (`memberIdx`)
) COMMENT '회원 프로필';

-- 주소 테이블
CREATE TABLE `address` (
	`addressIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`memberIdx`	BIGINT	NOT NULL COMMENT '회원 고유번호',
	`addressName`	VARCHAR(50)	NOT NULL COMMENT '주소 별칭 (집, 회사 등)',
	`postCode`	VARCHAR(10)	NOT NULL COMMENT '우편번호',
	`address`	VARCHAR(255)	NOT NULL COMMENT '기본 주소',
	`detailAddress`	VARCHAR(255)	NOT NULL COMMENT '상세 주소',
	`recipient`	VARCHAR(50)	NOT NULL COMMENT '수령인',
	`recipientPhone`	VARCHAR(20)	NOT NULL COMMENT '수령인 전화번호',
	`isDefault`	BOOLEAN	NOT NULL DEFAULT FALSE COMMENT '기본 주소 여부',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`addressIdx`),
	INDEX `idx_member` (`memberIdx`)
) COMMENT '배송 주소';

-- 상품 카테고리 테이블
CREATE TABLE `productCategory` (
	`categoryIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`name`	VARCHAR(50)	NOT NULL COMMENT '카테고리명',
	`parentIdx`	BIGINT	NULL COMMENT '상위 카테고리 (NULL이면 대분류)',
	`sortOrder`	INT	NOT NULL DEFAULT 0 COMMENT '정렬 순서',
	`isActive`	BOOLEAN	NOT NULL DEFAULT TRUE COMMENT '활성화 상태',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`categoryIdx`),
	INDEX `idx_parent` (`parentIdx`),
	INDEX `idx_sort` (`sortOrder`)
) COMMENT '상품 카테고리';

-- 상품 테이블
CREATE TABLE `products` (
	`productIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`productName`	VARCHAR(255)	NOT NULL COMMENT '상품명',
	`productCode`	VARCHAR(50)	NOT NULL UNIQUE COMMENT '상품 코드',
	`categoryIdx`	BIGINT	NOT NULL COMMENT '카테고리',
	`price`	DECIMAL(10,2)	NOT NULL COMMENT '상품 가격',
	`discountRate`	DECIMAL(5,2)	NOT NULL DEFAULT 0.00 COMMENT '할인율 (%)',
	`stockQuantity`	INT	NOT NULL DEFAULT 0 COMMENT '재고 수량',
	`isActive`	BOOLEAN	NOT NULL DEFAULT TRUE COMMENT '판매 상태',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`productIdx`),
	INDEX `idx_category` (`categoryIdx`),
	INDEX `idx_product_code` (`productCode`),
	INDEX `idx_price` (`price`)
) COMMENT '상품 기본 정보';

-- 상품 상세 정보 테이블
CREATE TABLE `productPost` (
	`productIdx`	BIGINT	NOT NULL,
	`deliveryFee`	DECIMAL(8,2)	NOT NULL DEFAULT 0.00 COMMENT '배송비',
	`productImgName`	VARCHAR(255)	NOT NULL COMMENT '대표 이미지 파일명',
	`productImgPath`	VARCHAR(500)	NOT NULL COMMENT '대표 이미지 경로',
	`productDetails`	LONGTEXT	NOT NULL COMMENT '상품 상세 설명',
	`isPublished`	BOOLEAN	NOT NULL DEFAULT TRUE COMMENT '게시 상태',
	`isDeleted`	BOOLEAN	NOT NULL DEFAULT FALSE COMMENT '삭제 상태',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`productIdx`)
) COMMENT '상품 상세 정보';

-- 상품 옵션 테이블 (사이즈, 색상 등)
CREATE TABLE `productOption` (
	`optionIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`productIdx`	BIGINT	NOT NULL COMMENT '상품 고유번호',
	`optionType`	VARCHAR(20)	NOT NULL COMMENT '옵션 타입 (SIZE, COLOR 등)',
	`optionValue`	VARCHAR(50)	NOT NULL COMMENT '옵션 값',
	`additionalPrice`	DECIMAL(8,2)	NOT NULL DEFAULT 0.00 COMMENT '추가 가격',
	`stock`	INT	NOT NULL DEFAULT 0 COMMENT '옵션별 재고',
	`isActive`	BOOLEAN	NOT NULL DEFAULT TRUE COMMENT '활성화 상태',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`optionIdx`),
	INDEX `idx_product` (`productIdx`),
	INDEX `idx_option_type` (`optionType`)
) COMMENT '상품 옵션';

-- 주문 테이블
CREATE TABLE `orders` (
	`orderIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`orderNumber`	VARCHAR(50)	NOT NULL UNIQUE COMMENT '주문번호',
	`memberIdx`	BIGINT	NOT NULL COMMENT '주문 회원',
	`orderStatus`	VARCHAR(20)	NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING, PAID, SHIPPED, DELIVERED, CANCELLED',
	`paymentMethod`	VARCHAR(20)	NOT NULL COMMENT '결제 방법',
	`totalAmount`	DECIMAL(10,2)	NOT NULL COMMENT '총 주문 금액',
	`discountAmount`	DECIMAL(10,2)	NOT NULL DEFAULT 0.00 COMMENT '할인 금액',
	`deliveryFee`	DECIMAL(8,2)	NOT NULL DEFAULT 0.00 COMMENT '배송비',
	`finalAmount`	DECIMAL(10,2)	NOT NULL COMMENT '최종 결제 금액',
	`recipientName`	VARCHAR(50)	NOT NULL COMMENT '수령인',
	`recipientPhone`	VARCHAR(20)	NOT NULL COMMENT '수령인 전화번호',
	`deliveryAddress`	VARCHAR(500)	NOT NULL COMMENT '배송 주소',
	`postCode`	VARCHAR(10)	NOT NULL COMMENT '우편번호',
	`orderMemo`	TEXT	NULL COMMENT '주문 메모',
	`isPaid`	BOOLEAN	NOT NULL DEFAULT FALSE COMMENT '결제 완료 여부',
	`paidAt`	DATETIME	NULL COMMENT '결제 완료 일시',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`orderIdx`),
	INDEX `idx_order_number` (`orderNumber`),
	INDEX `idx_member` (`memberIdx`),
	INDEX `idx_status` (`orderStatus`),
	INDEX `idx_created_at` (`createdAt`)
) COMMENT '주문 정보';

-- 주문 상품 테이블
CREATE TABLE `orderItems` (
	`orderItemIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`orderIdx`	BIGINT	NOT NULL COMMENT '주문 고유번호',
	`productIdx`	BIGINT	NOT NULL COMMENT '상품 고유번호',
	`optionIdx`	BIGINT	NULL COMMENT '선택한 옵션',
	`quantity`	INT	NOT NULL COMMENT '주문 수량',
	`unitPrice`	DECIMAL(10,2)	NOT NULL COMMENT '단가',
	`totalPrice`	DECIMAL(10,2)	NOT NULL COMMENT '총 가격',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`orderItemIdx`),
	INDEX `idx_order` (`orderIdx`),
	INDEX `idx_product` (`productIdx`)
) COMMENT '주문 상품 상세';

-- 결제 내역 테이블
CREATE TABLE `paymentHistory` (
	`paymentIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`orderIdx`	BIGINT	NOT NULL COMMENT '주문 고유번호',
	`memberIdx`	BIGINT	NOT NULL COMMENT '결제 회원',
	`paymentMethod`	VARCHAR(20)	NOT NULL COMMENT '결제 방법',
	`amount`	DECIMAL(10,2)	NOT NULL COMMENT '결제 금액',
	`paymentStatus`	VARCHAR(20)	NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING, SUCCESS, FAILED, CANCELLED',
	`transactionId`	VARCHAR(100)	NULL COMMENT '거래 ID',
	`paymentData`	JSON	NULL COMMENT '결제 관련 데이터',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`paymentIdx`),
	INDEX `idx_order` (`orderIdx`),
	INDEX `idx_member` (`memberIdx`),
	INDEX `idx_status` (`paymentStatus`)
) COMMENT '결제 내역';

-- 리뷰 테이블
CREATE TABLE `review` (
	`reviewIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`memberIdx`	BIGINT	NOT NULL COMMENT '리뷰 작성자',
	`productIdx`	BIGINT	NOT NULL COMMENT '상품',
	`orderIdx`	BIGINT	NOT NULL COMMENT '주문',
	`rating`	TINYINT	NOT NULL COMMENT '평점 (1-5)',
	`title`	VARCHAR(100)	NULL COMMENT '리뷰 제목',
	`content`	TEXT	NOT NULL COMMENT '리뷰 내용',
	`isSecret`	BOOLEAN	NOT NULL DEFAULT FALSE COMMENT '비밀 리뷰 여부',
	`isRecommended`	BOOLEAN	NULL COMMENT '추천 여부',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`reviewIdx`),
	INDEX `idx_member` (`memberIdx`),
	INDEX `idx_product` (`productIdx`),
	INDEX `idx_rating` (`rating`)
) COMMENT '상품 리뷰';

-- 리뷰 이미지 테이블
CREATE TABLE `reviewImg` (
	`reviewImgIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`reviewIdx`	BIGINT	NOT NULL COMMENT '리뷰 고유번호',
	`productIdx`	BIGINT	NOT NULL COMMENT '상품 고유번호',
	`imgName`	VARCHAR(255)	NOT NULL COMMENT '이미지 파일명',
	`imgPath`	VARCHAR(500)	NOT NULL COMMENT '이미지 경로',
	`sortOrder`	INT	NOT NULL DEFAULT 0 COMMENT '정렬 순서',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`reviewImgIdx`),
	INDEX `idx_review` (`reviewIdx`),
	INDEX `idx_product` (`productIdx`)
) COMMENT '리뷰 이미지';

-- 문의 테이블
CREATE TABLE `inquiry` (
	`inquiryIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`memberIdx`	BIGINT	NULL COMMENT '문의자 (비회원 가능)',
	`inquiryType`	VARCHAR(20)	NOT NULL COMMENT '문의 유형 (PRODUCT, ORDER, GENERAL 등)',
	`productIdx`	BIGINT	NULL COMMENT '상품 관련 문의',
	`orderIdx`	BIGINT	NULL COMMENT '주문 관련 문의',
	`title`	VARCHAR(200)	NOT NULL COMMENT '문의 제목',
	`content`	TEXT	NOT NULL COMMENT '문의 내용',
	`contactEmail`	VARCHAR(255)	NULL COMMENT '답변 받을 이메일',
	`contactPhone`	VARCHAR(20)	NULL COMMENT '연락처',
	`isSecret`	BOOLEAN	NOT NULL DEFAULT FALSE COMMENT '비밀글 여부',
	`status`	VARCHAR(20)	NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING, ANSWERED, CLOSED',
	`answer`	TEXT	NULL COMMENT '답변 내용',
	`answeredBy`	BIGINT	NULL COMMENT '답변자 (관리자)',
	`answeredAt`	DATETIME	NULL COMMENT '답변 일시',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`inquiryIdx`),
	INDEX `idx_member` (`memberIdx`),
	INDEX `idx_type` (`inquiryType`),
	INDEX `idx_status` (`status`)
) COMMENT '고객 문의';

-- FAQ 테이블
CREATE TABLE `faq` (
	`faqIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`category`	VARCHAR(50)	NOT NULL COMMENT 'FAQ 카테고리',
	`contentType`	VARCHAR(20)	NOT NULL DEFAULT 'FAQ' COMMENT 'FAQ, NOTICE',
	`question`	VARCHAR(500)	NULL COMMENT '질문 (공지사항은 NULL 가능)',
	`answer`	TEXT	NOT NULL COMMENT '답변/내용',
	`sortOrder`	INT	NOT NULL DEFAULT 0 COMMENT '정렬 순서',
	`isActive`	BOOLEAN	NOT NULL DEFAULT TRUE COMMENT '활성화 상태',
	`viewCount`	INT	NOT NULL DEFAULT 0 COMMENT '조회수',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`faqIdx`),
	INDEX `idx_category` (`category`),
	INDEX `idx_content_type` (`contentType`),
	INDEX `idx_sort` (`sortOrder`)
) COMMENT 'FAQ 및 공지사항';

-- 매입 관리 테이블
CREATE TABLE `purchase` (
	`purchaseIdx`	BIGINT	NOT NULL AUTO_INCREMENT,
	`productIdx`	BIGINT	NOT NULL COMMENT '매입 상품',
	`supplierName`	VARCHAR(100)	NOT NULL COMMENT '공급업체명',
	`supplierContact`	VARCHAR(100)	NOT NULL COMMENT '공급업체 연락처',
	`supplierPhone`	VARCHAR(20)	NOT NULL COMMENT '공급업체 전화번호',
	`productOption`	VARCHAR(100)	NULL COMMENT '상품 옵션',
	`unitCost`	DECIMAL(10,2)	NOT NULL COMMENT '매입 단가',
	`quantity`	INT	NOT NULL COMMENT '매입 수량',
	`totalCost`	DECIMAL(12,2)	NOT NULL COMMENT '총 매입 비용',
	`purchaseDate`	DATETIME	NOT NULL COMMENT '매입 일자',
	`status`	VARCHAR(20)	NOT NULL DEFAULT 'TEMP' COMMENT 'TEMP:임시저장, CONFIRMED:매입확정',
	`memo`	TEXT	NULL COMMENT '메모',
	`createdAt`	DATETIME	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedAt`	DATETIME	NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`purchaseIdx`),
	INDEX `idx_product` (`productIdx`),
	INDEX `idx_purchase_date` (`purchaseDate`),
	INDEX `idx_status` (`status`)
) COMMENT '상품 매입 관리';

-- 기타 카테고리 테이블 (기존 category 테이블 유지)
CREATE TABLE `category` (
	`categoryIdx`	VARCHAR(10)	NOT NULL COMMENT '카테고리 코드',
	`categoryName`	VARCHAR(50)	NOT NULL COMMENT '카테고리명',
	`description`	TEXT	NULL COMMENT '설명',
	`isActive`	BOOLEAN	NOT NULL DEFAULT TRUE COMMENT '활성화 상태',
	PRIMARY KEY (`categoryIdx`)
) COMMENT '기타 카테고리';

-- ============================================
-- 외래 키 제약 조건
-- ============================================

-- 프로필 관련
ALTER TABLE `profile` ADD CONSTRAINT `FK_member_TO_profile` 
FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`) ON DELETE CASCADE;

-- 주소 관련
ALTER TABLE `address` ADD CONSTRAINT `FK_member_TO_address` 
FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`) ON DELETE CASCADE;

-- 상품 카테고리 관련 (자기 참조)
ALTER TABLE `productCategory` ADD CONSTRAINT `FK_productCategory_TO_productCategory` 
FOREIGN KEY (`parentIdx`) REFERENCES `productCategory` (`categoryIdx`) ON DELETE SET NULL;

-- 상품 관련
ALTER TABLE `products` ADD CONSTRAINT `FK_productCategory_TO_products` 
FOREIGN KEY (`categoryIdx`) REFERENCES `productCategory` (`categoryIdx`);

ALTER TABLE `productPost` ADD CONSTRAINT `FK_products_TO_productPost` 
FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`) ON DELETE CASCADE;

ALTER TABLE `productOption` ADD CONSTRAINT `FK_products_TO_productOption` 
FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`) ON DELETE CASCADE;

-- 주문 관련
ALTER TABLE `orders` ADD CONSTRAINT `FK_member_TO_orders` 
FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`);

ALTER TABLE `orderItems` ADD CONSTRAINT `FK_orders_TO_orderItems` 
FOREIGN KEY (`orderIdx`) REFERENCES `orders` (`orderIdx`) ON DELETE CASCADE;

ALTER TABLE `orderItems` ADD CONSTRAINT `FK_products_TO_orderItems` 
FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`);

ALTER TABLE `orderItems` ADD CONSTRAINT `FK_productOption_TO_orderItems` 
FOREIGN KEY (`optionIdx`) REFERENCES `productOption` (`optionIdx`) ON DELETE SET NULL;

-- 결제 관련
ALTER TABLE `paymentHistory` ADD CONSTRAINT `FK_orders_TO_paymentHistory` 
FOREIGN KEY (`orderIdx`) REFERENCES `orders` (`orderIdx`);

ALTER TABLE `paymentHistory` ADD CONSTRAINT `FK_member_TO_paymentHistory` 
FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`);

-- 리뷰 관련
ALTER TABLE `review` ADD CONSTRAINT `FK_member_TO_review` 
FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`);

ALTER TABLE `review` ADD CONSTRAINT `FK_products_TO_review` 
FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`);

ALTER TABLE `review` ADD CONSTRAINT `FK_orders_TO_review` 
FOREIGN KEY (`orderIdx`) REFERENCES `orders` (`orderIdx`);

ALTER TABLE `reviewImg` ADD CONSTRAINT `FK_review_TO_reviewImg` 
FOREIGN KEY (`reviewIdx`) REFERENCES `review` (`reviewIdx`) ON DELETE CASCADE;

ALTER TABLE `reviewImg` ADD CONSTRAINT `FK_products_TO_reviewImg` 
FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`);

-- 문의 관련
ALTER TABLE `inquiry` ADD CONSTRAINT `FK_member_TO_inquiry` 
FOREIGN KEY (`memberIdx`) REFERENCES `member` (`memberIdx`) ON DELETE SET NULL;

ALTER TABLE `inquiry` ADD CONSTRAINT `FK_products_TO_inquiry` 
FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`) ON DELETE SET NULL;

ALTER TABLE `inquiry` ADD CONSTRAINT `FK_orders_TO_inquiry` 
FOREIGN KEY (`orderIdx`) REFERENCES `orders` (`orderIdx`) ON DELETE SET NULL;

ALTER TABLE `inquiry` ADD CONSTRAINT `FK_member_TO_inquiry_answerer` 
FOREIGN KEY (`answeredBy`) REFERENCES `member` (`memberIdx`) ON DELETE SET NULL;

-- 매입 관련
ALTER TABLE `purchase` ADD CONSTRAINT `FK_products_TO_purchase` 
FOREIGN KEY (`productIdx`) REFERENCES `products` (`productIdx`);
