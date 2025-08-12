package com.shop.shop.purchase;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class PurchaseService {
    private final PurchaseMapper purchaseMapper;

    public PageInfo<PurchaseDto> getPurchasesWithPaging(int page, int size) {
        // 페이징 자동처리
        PageHelper.startPage(page, size);

        List<PurchaseDto> purchaseDtoList = purchaseMapper.selectAll();

        return new PageInfo<>(purchaseDtoList);
    }
}
