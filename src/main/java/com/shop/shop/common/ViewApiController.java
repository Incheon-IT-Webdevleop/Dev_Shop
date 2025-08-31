package com.shop.shop.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api")
public class ViewApiController {

    // 메인 페이지
    @GetMapping("")
    public String main(){
        return "shop/main/mainView";
    }

    // 회원가입 페이지
    @GetMapping("/auth/signup")
    public String signupPage(){
        return "auth/signup";
    }

    // 로그인 페이지
    @GetMapping("/auth/login")
    public String loginPage(){
        return "auth/signIn";
    }
}
