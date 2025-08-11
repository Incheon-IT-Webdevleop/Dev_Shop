package com.shop.shop.order;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class OrderService implements OrderMapper {
    private final OrderMapper orderMapper;

    @Override
    public List<OrderDto> getOderByMonth() {
        System.out.println(orderMapper.getOderByMonth());
        return orderMapper.getOderByMonth();
    }
}
