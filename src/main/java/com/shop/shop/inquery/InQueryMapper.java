package com.shop.shop.inquery;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface InQueryMapper {
    List<InqueryDto> findAllInquery();
}
