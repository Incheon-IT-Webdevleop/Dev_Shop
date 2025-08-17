-- Member 테이블 샘플 데이터
INSERT INTO `Member` (`memberIdx`, `email`, `password`, `name`, `phone`, `loginType`, `isActive`, `role`, `joinAt`, `lastLoginAt`) VALUES
(1, 'admin@shop.com', 'hashed_password_1', '관리자', '010-1234-5678', 'local', true, 2, '2024-01-15 10:30:00', '2025-08-07 09:00:00'),
(2, 'john.doe@email.com', 'hashed_password_2', '홍길동', '010-2345-6789', 'local', true, 0, '2024-02-20 14:15:00', '2025-08-06 18:30:00'),
(3, 'jane.smith@email.com', 'hashed_password_3', '김영희', '010-3456-7890', 'kakao', true, 0, '2024-03-10 11:45:00', '2025-08-05 20:15:00'),
(4, 'mike.wilson@email.com', 'hashed_password_4', '박철수', '010-4567-8901', 'google', true, 1, '2024-04-05 16:20:00', '2025-08-04 12:45:00'),
(5, 'sarah.lee@email.com', 'hashed_password_5', '이수진', '010-5678-9012', 'local', false, 0, '2024-05-12 13:00:00', '2025-07-20 10:30:00');

-- profile 테이블 샘플 데이터
INSERT INTO `profile` (`id`, `memberIdx`, `imgName`, `imgPath`, `updatedAt`) VALUES
(1, 1, 'admin_profile.jpg', '/uploads/profiles/admin_profile.jpg', '2024-01-15 10:35:00'),
(2, 2, 'hong_profile.jpg', '/uploads/profiles/hong_profile.jpg', '2024-02-20 14:20:00'),
(3, 3, 'kim_profile.jpg', '/uploads/profiles/kim_profile.jpg', '2024-03-10 11:50:00'),
(4, 4, NULL, NULL, '2024-04-05 16:25:00'),
(5, 5, 'lee_profile.jpg', '/uploads/profiles/lee_profile.jpg', '2024-05-12 13:05:00');

-- ProductCatogory 테이블 샘플 데이터
INSERT INTO `ProductCatogory` (`productCategoryIdx`, `name`, `major`) VALUES
(1, '의류', 0),
(2, '전자제품', 0),
(3, '도서', 0),
(4, '상의', 1),
(5, '하의', 1),
(6, '스마트폰', 1),
(7, '노트북', 1),
(8, '소설', 1),
(9, '자기계발', 1);

-- Category 테이블 샘플 데이터
INSERT INTO `Category` (`categoryIdx`, `categoryName`) VALUES
('010', '패션의류'),
('020', '전자기기'),
('030', '도서/음반'),
('040', '생활용품'),
('050', '스포츠/레저');

-- Products 테이블 샘플 데이터
INSERT INTO `Products` (`productIdx`, `productName`, `createdAt`, `updatedAt`, `price`, `productCode`, `productCategoryIdx`) VALUES
(1, '프리미엄 코튼 반팔티', '2024-06-01 10:00:00', '2024-07-01 15:30:00', 25000, 1001, 4),
(2, '클래식 데님 청바지', '2024-06-02 11:00:00', '2024-07-02 16:00:00', 65000, 1002, 5),
(3, 'iPhone 15 Pro', '2024-06-03 12:00:00', '2024-07-03 10:15:00', 1390000, 2001, 6),
(4, 'MacBook Air M2', '2024-06-04 13:00:00', '2024-07-04 14:20:00', 1490000, 2002, 7),
(5, '해리포터 전집', '2024-06-05 14:00:00', NULL, 89000, 3001, 8),
(6, '7가지 습관', '2024-06-06 15:00:00', '2024-07-06 09:45:00', 15000, 3002, 9);

-- productPost 테이블 샘플 데이터 (컬럼명 수정: delivery Fee -> deliveryFee)
INSERT INTO `productPost` (`productIdx`, `delivery Fee`, `discountRate`, `productImgName`, `productImgPath`, `productDetails`, `isPublished`, `isDelete`) VALUES
(1, 3000, 10, 'tshirt_main.jpg', '/uploads/products/tshirt_main.jpg', '100% 순면으로 제작된 프리미엄 반팔티입니다. 부드러운 착용감과 우수한 통기성을 자랑합니다.', true, false),
(2, 3000, 15, 'jeans_main.jpg', '/uploads/products/jeans_main.jpg', '클래식한 디자인의 데님 청바지입니다. 다양한 스타일링에 어울리는 기본 아이템입니다.', true, false),
(3, 0, 5, 'iphone15_main.jpg', '/uploads/products/iphone15_main.jpg', '최신 A17 Pro 칩셋과 티타늄 소재로 제작된 프리미엄 스마트폰입니다.', true, false),
(4, 0, 8, 'macbook_main.jpg', '/uploads/products/macbook_main.jpg', 'M2 칩셋이 탑재된 경량 노트북으로 뛰어난 성능과 배터리 수명을 제공합니다.', true, false),
(5, 3000, 20, 'harrypotter_main.jpg', '/uploads/products/harrypotter_main.jpg', 'J.K. 롤링의 대표작 해리포터 시리즈 완전판입니다.', true, false),
(6, 3000, 0, 'habits_main.jpg', '/uploads/products/habits_main.jpg', '성공하는 사람들의 7가지 습관에 대한 자기계발서입니다.', false, false);

-- size 테이블 샘플 데이터
INSERT INTO `size` (`optionIdx`, `size`, `color`, `optionStock`, `productIdx`) VALUES
(1, 'S', '화이트', 50, 1),
(2, 'M', '화이트', 30, 1),
(3, 'L', '화이트', 20, 1),
(4, 'S', '블랙', 40, 1),
(5, 'M', '블랙', 25, 1),
(6, '28', '다크블루', 15, 2),
(7, '30', '다크블루', 20, 2),
(8, '32', '다크블루', 12, 2),
(9, NULL, '티타늄 블루', 100, 3),
(10, NULL, '티타늄 화이트', 85, 3),
(11, NULL, '스페이스 그레이', 50, 4),
(12, NULL, '실버', 45, 4);

-- address 테이블 샘플 데이터
INSERT INTO `address` (`addressIdx`, `memberIdx`, `addressName`, `postCode`, `address`, `detail_address`, `recipient`, `recipientPhone`, `createdAt`, `updatedAt`, `IsDefault`) VALUES
(1, 2, '집', 06234, '서울특별시 강남구 테헤란로 123', '456호', '홍길동', 1023456789, '2024-02-20 14:25:00', '2024-02-20 14:25:00', true),
(2, 2, '회사', 06789, '서울특별시 서초구 서초대로 789', '10층', '홍길동', 1023456789, '2024-03-15 10:15:00', '2024-03-15 10:15:00', false),
(3, 3, '집', 07845, '경기도 성남시 분당구 판교역로 234', '101동 505호', '김영희', 1034567890, '2024-03-10 12:00:00', '2024-03-10 12:00:00', true),
(4, 4, '집', 05432, '부산광역시 해운대구 센텀남대로 567', '1502호', '박철수', 1045678901, '2024-04-05 16:30:00', '2024-04-05 16:30:00', true);

-- Orders 테이블 샘플 데이터
INSERT INTO `Orders` (`orderIdx`, `productIdx`, `memberIdx`, `payMethod`, `TotalPrice`, `address`, `detailAddress`, `name`, `postCode`, `phone`, `ispayed`, `orderAt`, `quantity`) VALUES
(1, 1, 2, '카드', 25500, '서울특별시 강남구 테헤란로 123', '456호', '홍길동', 06234, '010-2345-6789', true, '2024-07-15 14:30:00', 1),
(2, 3, 2, '카드', 1390000, '서울특별시 강남구 테헤란로 123', '456호', '홍길동', 06234, '010-2345-6789', true, '2024-07-20 10:15:00', 1),
(3, 2, 3, '무통장', 68000, '경기도 성남시 분당구 판교역로 234', '101동 505호', '김영희', 07845, '010-3456-7890', false, '2024-07-25 16:45:00', 1),
(4, 5, 4, 'PayPal', 74200, '부산광역시 해운대구 센텀남대로 567', '1502호', '박철수', 05432, '010-4567-8901', true, '2024-08-01 11:20:00', 1);

-- PaymentHistory 테이블 샘플 데이터
INSERT INTO `PaymentHistory` (`paymentIdx`, `memberIdx`, `orderIdx`, `productIdx`, `price`, `totalPrice`, `createdAt`, `status`) VALUES
(1, 2, 1, 1, 25000, 25500, '2024-07-15 14:35:00', true),
(2, 2, 2, 3, 1390000, 1390000, '2024-07-20 10:20:00', true),
(3, 3, 3, 2, 65000, 68000, '2024-07-25 16:50:00', false),
(4, 4, 4, 5, 89000, 74200, '2024-08-01 11:25:00', true);

-- review 테이블 샘플 데이터
INSERT INTO `review` (`reviewIdx`, `rating`, `reviewContent`, `isSecret`, `memberIdx`, `orderIdx`, `productIdx`) VALUES
(1, 5, '재질이 정말 부드럽고 착용감이 좋습니다. 추천해요!', false, 2, 1, 1),
(2, 4, '배송이 빠르고 제품 품질이 만족스럽습니다.', false, 2, 2, 3),
(3, 3, '사이즈가 좀 작은 것 같아요. 한 치수 크게 주문하시길.', false, 4, 4, 5);

-- reviewImg 테이블 샘플 데이터
INSERT INTO `reviewImg` (`reviewImgIdx`, `reviewImgPath`, `reviewIdx`, `productIdx`) VALUES
(1, '/uploads/reviews/review1_1.jpg', 1, 1),
(2, '/uploads/reviews/review1_2.jpg', 1, 1),
(3, '/uploads/reviews/review2_1.jpg', 2, 3);

-- FAQ 테이블 샘플 데이터
INSERT INTO `FAQ` (`faqIdx`, `contetnType`, `question`, `answer`) VALUES
(1, 0, '배송기간은 얼마나 걸리나요?', '일반 배송은 2-3일, 당일배송은 오후 6시 이전 주문시 당일 배송됩니다.'),
(2, 0, '교환/환불은 어떻게 하나요?', '상품 수령 후 7일 이내 마이페이지에서 교환/환불 신청이 가능합니다.'),
(3, 0, '회원가입 혜택이 있나요?', '신규 회원 가입시 10% 할인쿠폰과 무료배송 쿠폰을 제공합니다.'),
(4, 1, NULL, '2024년 8월 임시 점검 안내: 8월 10일 새벽 2시~6시 서버 점검이 있을 예정입니다.'),
(5, 1, NULL, '새로운 결제 시스템 도입으로 더욱 안전하고 편리한 결제가 가능합니다.');

-- Inquery 테이블 샘플 데이터
INSERT INTO `Inquery` (`inqueryIdx`, `category`, `content`, `createAt`, `orderIdx`, `productIdx`, `answer`, `answerAt`) VALUES
(1, '주문/배송', '주문한 상품이 아직 배송 준비중인데 언제쯤 발송되나요?', '2024-07-26 10:30:00', 3, 2, NULL, NULL),
(2, '상품문의', '이 제품 색상이 사진과 다른가요?', '2024-07-28 14:15:00', NULL, 1, NULL, NULL),
(3, '교환/환불', '사이즈가 맞지 않아서 교환하고 싶습니다.', '2024-08-02 16:20:00', 4, 5, NULL, '2024-08-02 18:45:00');

-- purchaseInfo 테이블 샘플 데이터
INSERT INTO `purchaseInfo` (`purchaseIdx`, `productIdx`, `purchaseDate`, `correspondent`, `correspondentNum`, `correspondentPhon`, `productOption`, `productCost`, `quantity`, `status`) VALUES
(1, 1, '2024-05-15 09:00:00', '(주)코튼텍스', 12345, 234567890, '화이트/M', 15000, 100, true),
(2, 2, '2024-05-20 11:30:00', '데님코리아', 23456, 345678901, '다크블루/30', 35000, 50, true),
(3, 3, '2024-06-01 14:15:00', '애플코리아', 34567, 456789012, '티타늄블루/128GB', 1200000, 20, false),
(4, 4, '2024-06-05 16:45:00', '애플코리아', 34567, 456789012, '스페이스그레이/256GB', 1300000, 15, true);

-- 데이터 삽입 완료 확인
SELECT 'Member' as TableName, COUNT(*) as RecordCount FROM Member
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'profile', COUNT(*) FROM profile
UNION ALL
SELECT 'address', COUNT(*) FROM address;