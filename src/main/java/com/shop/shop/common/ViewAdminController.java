package com.shop.shop.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class ViewAdminController {

    // 관리자페이지 - 메인 페이지
    @GetMapping("")
    public String index() {
        return "admin/index";
    }
}
