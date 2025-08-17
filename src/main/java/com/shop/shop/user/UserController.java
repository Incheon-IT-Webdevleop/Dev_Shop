package com.shop.shop.user;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@RequiredArgsConstructor
@Slf4j
@Tag(name = "유저 인증", description = "유저 인증 API")
@RequestMapping("/api")
public class UserController {
    private final UserService userService;

    // 중복검사
    @PostMapping("/duplication")
    @Operation(summary = "중복검사", description = "중복되면 403 , 중복없으면 200")
    @ApiResponse(responseCode = "200", description = "사용 가능한 이메일")
    @ApiResponse(responseCode = "403", description = "이미 존재하는 이메일")
    public ResponseEntity<?> duplication(@RequestParam("type") String type, @RequestParam("value") String value){
 
        boolean duplicated = userService.isDuplicated(type, value);
        
        if(duplicated){
            // 값이 있으니 중복
            return ResponseEntity.status(403).body("이미 사용중인 " + type + "입니다.");
        }else{
            // 값이 없으니 중복 안됨
            return  ResponseEntity.ok("사용 가능한 " + type + "입니다.");
        }
    }

    // 회원가입
    @PostMapping("/auth/signUp")
    @Operation(summary = "회원가입", description = "중복되면 403 , 중복없으면 200")
    @ApiResponse(responseCode = "201", description = "성공")
    @ApiResponse(responseCode = "400", description = "잘못된 요청")
    public ResponseEntity<?> signUp(@RequestBody UserRequestDTO user){
        
        userService.insertUser(user);
      
        return  ResponseEntity.status(201).body("회원 가입이 성공적으로 되었습니다.");
    }
}
