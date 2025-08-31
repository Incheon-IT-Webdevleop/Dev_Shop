package com.shop.shop.user;

import java.util.Collections;
import java.util.Map;

import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {

    private final @Lazy UserService userService;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest)
            throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = new DefaultOAuth2UserService().loadUser(userRequest);

        String provider = userRequest.getClientRegistration().getRegistrationId(); // google, naver
        String email = null;
        String name = null;
        String phone = null;
        String nameAttributeKey = null;
        Map<String, Object> attributes = null;

        if (provider.equals("google")) {
            email = oAuth2User.getAttribute("email");
            name = oAuth2User.getAttribute("name");
        } else if (provider.equals("naver")) {
            Map<String, Object> response = oAuth2User.getAttribute("response");
            email = (String) response.get("email");
            name = (String) response.get("name");
            phone = (String) response.get("mobile");
        }

        // DB 조회
        UserDTO user = userService.findByEmail(email);

        if (user == null) {
            // 신규 회원이면 등록
            UserRequestDTO newUser = new UserRequestDTO();
            newUser.setEmail(email);
            newUser.setName(name);
            newUser.setProvider(provider.toUpperCase());
            newUser.setPassword("1");
            newUser.setPhone(phone);
            userService.insertUser(newUser);
        }

        // 구글과 네이버의 email을 불러오는 방법이 다르다
        if (provider.equals("google")) {
            email = oAuth2User.getAttribute("email");
            name = oAuth2User.getAttribute("name");
            attributes = oAuth2User.getAttributes();
            nameAttributeKey = "id"; // 네이버는 'id'가 유니크
            System.out.println("nameAttributeKey : " + nameAttributeKey);
        } else if (provider.equals("naver")) {
            Map<String, Object> response = oAuth2User.getAttribute("response");
            email = (String) response.get("email");
            name = (String) response.get("name");
            attributes = response;
            nameAttributeKey = "email";
        }
        return new DefaultOAuth2User(
            Collections.singleton(new SimpleGrantedAuthority("ROLE_USER")),
            attributes,
            nameAttributeKey
            );
        }
}