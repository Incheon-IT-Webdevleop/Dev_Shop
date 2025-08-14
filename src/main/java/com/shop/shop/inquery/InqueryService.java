package com.shop.shop.inquery;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class InqueryService{
    private final InQueryMapper inQueryMapper;

    public List<InqueryDto> findAllInquery() {
        System.out.println(inQueryMapper.findAllInquery());
        return inQueryMapper.findAllInquery();
    }
}
