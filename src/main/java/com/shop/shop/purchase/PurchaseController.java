package com.shop.shop.purchase;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.github.pagehelper.PageInfo;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/purchase")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "매입정보 API", description = "매입정보 API 확인")
public class PurchaseController {
    private final PurchaseService purchaseService;

    @GetMapping("/selectAll.do")
    @ResponseBody
    @Operation(summary = "selectAll", description = "페이징 처리된 모든 매입정보 불러오기")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "매입정보 불러오기 성공",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = PageInfo.class))),
            @ApiResponse(responseCode = "500",
                    description = "서버 에러",
                    content = @Content(mediaType = "application/json"))
    })
    public ResponseEntity<PageInfo<PurchaseDto>> selectAll(
            @Parameter(description = "페이지 번호", example = "1")
            @RequestParam(defaultValue = "1") int page,

            @Parameter(description = "페이지 크기", example = "10")
            @RequestParam(defaultValue = "10") int size) {
        PageInfo<PurchaseDto> pageInfo = purchaseService.getPurchasesWithPaging(page, size);

        return ResponseEntity.ok(pageInfo);
    }

}
