package com.shop.shop.purchase;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PurchaseMapper {
    String selectOne();
}
