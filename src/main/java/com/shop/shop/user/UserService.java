package com.shop.shop.user;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService implements UserMapper{
    private final UserMapper userMapper;


    @Override
    public String selectOne() {
        System.out.println(userMapper.selectOne());
        return userMapper.selectOne();
    }
}
