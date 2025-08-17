package com.shop.shop.inquery;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/admin/inquery")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "문의사항 API", description = "문의사항 API 확인")
public class InqeuryController {
    private final InqueryService inqueryService;


    @GetMapping("/findAll.do")
    @ResponseBody
    @Operation(summary = "findAll", description = "문의사항 전체 목록 가져오기")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "조회 성공",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = InqueryDto.class))),
            @ApiResponse(responseCode = "500",
                    description = "서버 에러",
                    content = @Content(mediaType = "application/json"))
    })
    public ResponseEntity<?> findAll() {
        try{
            List<InqueryDto> result = inqueryService.findAllInquery();
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
