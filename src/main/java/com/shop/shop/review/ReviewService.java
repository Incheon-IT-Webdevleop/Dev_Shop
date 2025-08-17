package com.shop.shop.review;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Slf4j
@Transactional
@RequiredArgsConstructor
public class ReviewService {
    private final ReviewMapper reviewMapper;

    // 리뷰 전체조회
    public List<ReviewDto> findAllReview() {
        System.out.println(reviewMapper.findAllReview());
        return reviewMapper.findAllReview();
    }
}
