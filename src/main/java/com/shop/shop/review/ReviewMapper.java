package com.shop.shop.review;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReviewMapper {
    // 리뷰 목록 전체 조회
    List<ReviewDto> findAllReview();
}
