package com.shop.shop.oder;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.sql.Date;

@Data
public class OrderDto {

    @Schema(description = "주문 고유번호", example = "1")
    private long orderIdx;      // 주문번호

    @Schema(description = "주문 상품번호", example = "3")
    private long productIdx;    // 주문한 상품번호

    @Schema(description = "주문자 (회원)번호", example = "4")
    private long memberIdx;     // 주문한 회원번호

    @Schema(description = "결제 수단", example = "카드")
    private String payMethod;   // 결제수단

    @Schema(description = "주문 총 금액", example = "40000")
    private int totalPrice;     // 주문건 총금액

    @Schema(description = "주소", example = "경기도 시흥시 진말1로 30")
    private String address;     // 주소

    @Schema(description = "상세주소", example = "101동 101호")
    private String detailAddress;// 상세주소

    @Schema(description = "주문자명", example = "홍길동")
    private String name;        // 이름

    @Schema(description = "우편번호", example = "12345")
    private int postCode;       // 우편번호

    @Schema(description = "주문자 연락처", example = "01011113333")
    private String phone;       // 주문자 연락처

    @Schema(description = "결제여부", example = "true")
    private boolean isPayed;    // 결제여부

    @Schema(description = "주문시간", example = "2025-06-30 14:30:00")
    private Date oderAt;        // 주문시간

    @Schema(description = "주문수량", example = "30")
    private int quantity;       // 주문수량

}
