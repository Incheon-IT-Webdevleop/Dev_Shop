package com.shop.shop.user;

import com.shop.shop.dto.AddressDTO;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
public class UserRequestDTO {
    @Schema(description = "입력한 이메일", example = "qwer@naver.com")
    private String email;

    @Schema(description = "입력한 비밀번호", example = "qwer1234")
    private String password;

    @Schema(description = "비밀번호 확인", example = "qwer1234")
    private String confirmPassword;

    @Schema(description = "입력한 이름", example = "홍길동")
    private String name;

    @Schema(description = "입력한 핸드폰번호", example = "홍길동")
    private String phone;

    @Schema(description = "입력한 주소", example = "{'zipcode':'12345', 'base':'서울시 관악구 가로 1', 'detail':'105동 1006호'}")
    private AddressDTO address;

}
