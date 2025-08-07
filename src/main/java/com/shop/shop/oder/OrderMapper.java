package com.shop.shop.oder;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderMapper {
    List<OrderDto> getOderByMonth();
}
