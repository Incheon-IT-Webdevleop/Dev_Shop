package com.shop.shop.inquery;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class InqueryDto {
    @Schema(description = "문의사항 고유번호", example = "1")
    private long inqueryIdx;

    @Schema(description = "문의사항 카테고리명", example = "문의사항")
    private String category;

    @Schema(description = "문의 내용", example = "A상품의 입고 일자를 알고싶습니다.")
    private String content;

    @Schema(description = "문의사항 작성 시간", example = "2025-08-10 10:00:00")
    private LocalDateTime createAt;

    @Schema(description = "문의 주문번호", example = "30")
    private long oderIdx;

    @Schema(description = "상품번호", example = "20")
    private long productIdx;

    @Schema(description = "답변???", example = "1") // db에서 왜 bigint?
    private long answer;

    @Schema(description = "답변 달린 시간", example = "2025-09-10 12:00:00")
    private LocalDateTime answerAt;
}
