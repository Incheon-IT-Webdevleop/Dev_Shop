package com.shop.shop.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class AddressDTO {
    @Schema(description = "우편 번호", example = "12345")
    private String zipcode;

    @Schema(description = "주소", example = "서울시 관악구 가길 1")
    private String base;

    @Schema(description = "상세 주소", example = "105동 1006호")
    private String detail;
}
