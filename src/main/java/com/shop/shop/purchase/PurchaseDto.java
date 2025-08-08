package com.shop.shop.purchase;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

@Data
public class PurchaseDto {

    @Schema(description = "매입 고유번호", example = "1")
    private long purchaseIdx;

    @Schema(description = "매입 날짜", example = "2025-03-04")
    private Date purchaseData;

    @Schema(description = "거래처명", example = "(주)대한민국")
    private String correspondent;   // 거래처명

    @Schema(description = "사업자 등록번호", example = "123001111")
    private int correspondentNum;   // 사업자번호

    @Schema(description = "거래처 연락처", example = "01012346789")
    private int correspondentPhone; // 거래처연락처

    @Schema(description = "상품 옵션", example = "사이즈")
    private String productOption;   // 상품옵션

    @Schema(description = "상품원가(매입가)", example = "34000")
    private int productCost;        // 상품원가(매입가)

    @Schema(description = "매입 수량", example = "100")
    private int quantity;           // 매입수량

    @Schema(description = "작성 상태", example = "true")
    private boolean status;         // 작성상태
}
