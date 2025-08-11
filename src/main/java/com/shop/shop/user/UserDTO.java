package com.shop.shop.user;

import lombok.Data;


import io.swagger.v3.oas.annotations.media.Schema;

@Data
public class UserDTO {
    @Schema(description = "고객 고유번호", example = "1")
    private String memberIdx;

    @Schema(description = "고객 이메일", example = "qwer@naver.com")
    private String email;

    @Schema(description = "고객 비밀번호", example = "qwer1234")
    private String password;
    
    @Schema(description = "고객 이름", example = "홍길동")
    private String name;

    @Schema(description = "고객 휴대폰번호", example = "010-4473-5307")
    private String phone;

    @Schema(description = "고객 로그인타입", example = "naver")
    private String loginType;

    @Schema(description = "고객 탈퇴여부", example = "true")
    private String isActive;

    @Schema(description = "고객 역할", example = "0")
    private String role;

    @Schema(description = "고객 회원가입 시각", example = "2025-08-11 20:20:20")
    private String joinAt;

    @Schema(description = "고객 마지막 로그인 시각", example = "2025-08-11 20:20:20")
    private String lastLoginAt;


}
