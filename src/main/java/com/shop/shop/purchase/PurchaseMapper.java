package com.shop.shop.purchase;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PurchaseMapper {
    // 매입 목록 조회
    List<PurchaseDto> selectAll();

    // 매입 정보 등록
    List<PurchaseRequestDto> getPurchaseInfo();
}
