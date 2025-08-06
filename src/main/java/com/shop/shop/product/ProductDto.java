package com.shop.shop.product;

import lombok.Data;

@Data
public class ProductDto {
    private long productIdx; // 상품번호
    private String productName; // 상품명
    private int price; // 상품가격
    private int productCode; // 상품코드
    private long productCategoryIdx; // 상품카테고리아이디
}
