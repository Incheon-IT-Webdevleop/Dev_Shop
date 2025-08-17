package com.shop.shop.review;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/admin/review")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "리뷰 API", description = "리뷰 API 확인")
public class ReviewController {
    private final ReviewService reviewService;

    @GetMapping("/findAll.do")
    @ResponseBody
    @Operation(summary = "findAll", description = "리뷰 전체 목록 가져오기")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "조회 성공",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = ReviewDto.class))),
            @ApiResponse(responseCode = "500",
                    description = "서버 에러",
                    content = @Content(mediaType = "application/json"))
    })
    public ResponseEntity<?> findAll() {
        try{
            List<ReviewDto> result = reviewService.findAllReview();
            if(result == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("login error");
            } else {
                return ResponseEntity.status(HttpStatus.OK).body(result);
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("server error");
        }
    }
}
