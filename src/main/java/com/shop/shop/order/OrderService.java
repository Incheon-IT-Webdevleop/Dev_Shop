package com.shop.shop.order;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class OrderService {
    private final OrderMapper orderMapper;

    public List<Map<String, Object>> getOderByMonth() {
        System.out.println(orderMapper.getOderByMonth());
        return orderMapper.getOderByMonth();
    }
}
