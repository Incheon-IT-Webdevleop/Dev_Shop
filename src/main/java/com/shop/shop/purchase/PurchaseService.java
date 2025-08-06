package com.shop.shop.purchase;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class PurchaseService implements PurchaseMapper{
    private final PurchaseMapper purchaseMapper;

    @Override
    public String selectOne() {
        System.out.println(purchaseMapper.selectOne());
        return purchaseMapper.selectOne();
    }
}
