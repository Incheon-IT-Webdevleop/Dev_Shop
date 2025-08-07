package com.shop.shop.oder;

import lombok.Data;

import java.sql.Date;

@Data
public class OrderDto {
    private long orderIdx;      // 주문번호
    private long productIdx;    // 주문한 상품번호
    private long memberIdx;     // 주문한 회원번호
    private String payMethod;   // 결제수단
    private int totalPrice;     // 주문건 총금액
    private String address;     // 주소
    private String detailAddress;// 상세주소
    private String name;        // 이름
    private int postCode;       // 우편번호
    private String phone;       // 주문자 연락처
    private boolean isPayed;    // 결제여부
    private Date oderAt;        // 주문시간
    private int quantity;       // 주문수량

}
