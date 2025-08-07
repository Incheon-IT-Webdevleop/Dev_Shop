package com.shop.shop.purchase;

import lombok.Data;

import java.util.Date;

@Data
public class PurchaseDto {
    private Date purchaseData;      // 매입날짜
    private String correspondent;   // 거래처명
    private int correspondentNum;   // 사업자번호
    private int correspondentPhone; // 거래처연락처
    private String productOption;   // 상품옵션
    private int productCost;        // 상품원가(매입가)
    private int quantity;           // 매입수량
    private boolean status;         // 작성상태
}
