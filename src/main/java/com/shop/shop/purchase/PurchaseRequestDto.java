package com.shop.shop.purchase;

import java.time.LocalDateTime;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.Data;

@Data
public class PurchaseRequestDto {
    @NotBlank(message = "매입 날짜는 필수 입력 사항입니다.")
    @FutureOrPresent // Now이거나 미래
    private LocalDateTime purchaseData;

    @NotBlank(message = "거래처명은 필수 입력 사항입니다.")
    private String correspondent;

    @NotBlank(message = "사업자등록번호는 필수 입력 사항입니다.")
    @Pattern(regexp = "^[0-9]{10}$",
            message = "사업자등록번호는 10자리 숫자여야 합니다.")
    private int correspondentNum;

    @NotBlank(message = "거래처 연락처는 필수 입력 사항입니다.")
    private int correspondentPhone;

    @NotBlank(message = "상품 옵션은 필수 입력 사항입니다.")
    private String productOption;

    @NotBlank(message = "상품원가(매입가)는 필수 입력 사항입니다.")
    private int productCost;

    @NotBlank(message = "매입 수량은 필수 입력 사항입니다.")
    @PositiveOrZero // 0 이상
    private int quantity;








}
