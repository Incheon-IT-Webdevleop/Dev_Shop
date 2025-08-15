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
        return "admin/main/mainView";
    }

    // 매입매출(영업관리) 페이지
    // 매입관리 - 매입목록 페이지
    @GetMapping("/salesMng/purchaseList")
    public String purchaseList() {
        return "admin/salesMng/purchaseList";
    }

    // 매입관리 - 매입등록 페이지
    @GetMapping("/salesMng/registPurchase")
    public String registPurchase() {
        return "/admin/salesMng/registPurchase";
    }

    // 매입관리 - 매입 상세조회 페이지
    @GetMapping("/salesMng/purchaseDetail")
    public String purchaseDetail() {
        return "admin/salesMng/purchaseDetail";
    }


}
