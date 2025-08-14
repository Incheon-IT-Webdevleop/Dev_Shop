package com.shop.shop.review;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class ReviewDto {

    @Schema(description = "상품후기 고유번호", example = "1")
    private long reviewIdx;

    @Schema(description = "상품후기 별점", example = "5")
    private int rating;

    @Schema(description = "상품후기 내용", example = "원단의 질이 매우 좋습니다. 마감도 깔끔해요. 만족합니다!")
    private String reviewContent;

    @Schema(description = "상품후기 공개여부", example = "false")
    private boolean isSecret;

    @Schema(description = "상품후기 작성 회원의 고유번호", example = "5")
    private long memberIdx;

    @Schema(description = "후기를 작성할 상품 주문건의 고유번호", example = "2234") // 주문번호???가 필요한가????
    private long orderIdx;

    @Schema(description = "후기를 작성할 상품의 고유번호", example = "5234")
    private long productIdx;
}
