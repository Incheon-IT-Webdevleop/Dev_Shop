package com.shop.shop.purchase;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/purchase")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "매입정보 API", description = "매입정보 API 확인")
public class PurchaseController {
    private final PurchaseService purchaseService;

    @GetMapping("/select.do")
    @ResponseBody
    @Operation(summary = "selectOne", description = "get selectOne")
    @ApiResponse(responseCode = "200",
            description = "조회성공",
            content = @Content(mediaType = "/text/plain", schema = @Schema(type = "string")))
    public ResponseEntity<String> selectOne() {
        String purchase = purchaseService.selectOne();
        return ResponseEntity.ok(purchase);
    }

}
