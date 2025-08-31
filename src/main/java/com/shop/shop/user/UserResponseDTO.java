package com.shop.shop.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class UserResponseDTO {
    @Schema(description = "고객 고유번호", example = "1")
    private Long id;
    
    @Schema(description = "고객 이메일", example = "qwer@naver.com")
    private String email;

    @Schema(description = "고객 비밀번호", example = "qwer1234")
    private String password;

    @Schema(description = "고객 이름", example = "홍길동")
    private String name;

    @Schema(description = "고객 로그인타입", example = "naver")
    private String provider;
}
