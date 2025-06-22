package com.shop.shop.user;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    String selectOne();
}
