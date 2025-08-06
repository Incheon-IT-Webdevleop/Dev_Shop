package com.shop.shop.purchase;

import lombok.Data;

import java.util.Date;

@Data
public class PurchaseDto {
    Date purchaseData;      // 매입날짜
    String correspondent;   // 거래처명
    int correspondentNum;   // 사업자번호
    int correspondentPhone; // 거래처연락처
    String productOption;   // 상품옵션
    int productCost;        // 상품원가(매입가)
    int quantity;           // 매입수량
    boolean status;         // 작성상태
}
