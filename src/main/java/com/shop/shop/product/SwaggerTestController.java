package com.shop.shop.product;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api")
@RestController
@Tag(name = "swagger API test", description = "api test 입니다.")
@RequiredArgsConstructor
public class SwaggerTestController {

    @Operation(summary = "헬로1", description = "get hello")
    @ApiResponse(responseCode = "200",
            description = "성공",
            content = @Content(mediaType = "/text/plain", schema = @Schema(type = "string")))
    @GetMapping("/hello")
    public ResponseEntity<String> hello() {
        System.out.println("swagger test hello1");
        return ResponseEntity.ok("hello world");
    }

    @Operation(summary = "헬로2", description = "post hello")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "리턴 성공",
                    content = @Content(mediaType = "/text/plain", schema = @Schema(type = "string"))),
            @ApiResponse(responseCode = "500",
                    description = "서버 에러",
                    content = @Content(mediaType = "application/json"))
    })
    @PostMapping("/hello/{name}")
    public ResponseEntity<String> hello2(@Parameter(description = "이름", example = "홍길동") @PathVariable String name) {
        if(name.equals("aa")) {
            throw new IllegalArgumentException("유효하지 않은 이름입니다.");
        }
        String body = "hello" +name ;
        return ResponseEntity.ok(body);
    }



}
