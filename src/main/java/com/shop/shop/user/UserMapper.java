package com.shop.shop.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    // 테스트
    String selectOne();

    // 이메일로 가입된 유저 유무
    int countByEmail(String email);

    // 회원 가입
    void insertUser(UserRequestDTO user);

    // 이메일로 유저 찾기
    UserDTO findByEmail(String email);

    // OAuth 회원가입
    void insertUserFromOAuth(UserDTO user);
}
