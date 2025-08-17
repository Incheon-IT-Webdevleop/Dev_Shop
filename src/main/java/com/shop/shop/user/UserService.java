package com.shop.shop.user;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService{
    private final UserMapper userMapper;

    public String selectOne() {
//        System.out.println(userMapper.selectOne());
//        return userMapper.selectOne();r
        return null;
    }

    // 중복 검사
    public boolean isDuplicated(String type, String value){
        
        int count = 0;

        switch (type) {
            // 이메일 검사 부터 
            case "email":
                count = userMapper.countByEmail(value);
                break;
            default:
                break;
        }
        
        // 하나라도 있으면 카운트가 변해 1이면 존재하므로 중복 true
        return count > 0;
    }

    public void insertUser(UserRequestDTO user){
        userMapper.insertUser(user);
    }

}
