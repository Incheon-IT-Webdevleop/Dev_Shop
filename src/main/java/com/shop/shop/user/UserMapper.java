package com.shop.shop.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    String selectOne();

    int countByEmail(String email);

    void insertUser(UserRequestDTO user);
}
