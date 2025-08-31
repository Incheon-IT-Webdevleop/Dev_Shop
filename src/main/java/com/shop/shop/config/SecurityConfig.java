package com.shop.shop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.shop.shop.user.CustomOAuth2UserService;
import com.shop.shop.user.CustomUserDetailsService;
import com.shop.shop.user.UserDTO;
import com.shop.shop.user.UserService;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

    private final CustomOAuth2UserService customOAuth2UserService;
    private final CustomUserDetailsService customUserDetailsService;
    private final UserService userService;


    @Bean
    public SecurityFilterChain filterChain (HttpSecurity http) throws Exception {
        http.authorizeHttpRequests((httpReq) -> {
            httpReq
                    .requestMatchers("/css/**", "/js/**", "/categoryImages/**", "/data/**", "/img/**").permitAll() // CSS, JS, 이미지 폴더에 대해 접근 허용
                    //.requestMatchers(AntPathRequestMatcher.antMatcher("/category")).hasRole("USER") // 로그인도니 모든 회원 접속 가능
                    //.requestMatchers(AntPathRequestMatcher.antMatcher("/record")).hasRole("USER") // 로그인도니 모든 회원 접속 가능
                    .requestMatchers(AntPathRequestMatcher.antMatcher("/**")).permitAll(); // 그 외 모든 접속자 허용
        });
        // 403 에러페이지 처리
        http.exceptionHandling((e) -> {
            e.accessDeniedHandler( ((request, response, accessDeniedException) -> {
                response.sendRedirect("/error403"); // URL반환
            })); // 403에러 헨들러
        });
        // 4. CSRF : post/put (BODY) 요청을 금지, 특정한 URL만 post/put 가능하도록 수동 허용
        // 개발: CSRF 사용안함, 개발 환경에서는 끄고 사용하는 경우가 많다.
        http.csrf(AbstractHttpConfigurer :: disable ); // csrf끄기 -> post/put 사용할 수 있음
        // 배포/운영 : 특정한 URL 수동으로 허용 , 운영 환경에서는 안전하게 몇몇개의 REST만 허용한다.
        // http.csrf( csrf -> csrf.ignoringRequestMatchers("csrf예외할URL") );
        // http.csrf( csrf -> csrf.ignoringRequestMatchers("/member/signup.do") ); // 회원가입 POST 예외

        // 5. 시큐리티 로그인 (시큐리티에서 제공하는 로그인 기능 커스텀)
        // JSON 형식이 아닌 Form 형식으로 지원
        http.formLogin( loginform ->
            loginform
                // 로그인할 view page url 정의
                .loginPage("/api/auth/login")             
                // 로그인을 처리할 URL 정의 : POST 방식
                .loginProcessingUrl("/api/auth/login")
                // 로그인에 사용할 id 변수명
                .usernameParameter("email")               
                // 로그인에 사용할 password 변수
                .passwordParameter("password")              
                //.defaultSuccessUrl("/")                 // 로그인 성공시 이동할 page url 정의
                //.failureUrl("/member/login")     // 로그인 실패시 이동할 page url 정의
                // fetch/axios 처리에서는 아래와같이 사용
                .successHandler((request, response, exception) -> {
                // Spring Security 인증 정보에서 이메일 가져오기
                    String email = ((UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUsername();
                    // DB에서 사용자 정보 조회
                    UserDTO user = userService.findByEmail(email);
                    // 세션에 저장
                    request.getSession().setAttribute("user", user);
                    response.setContentType("application/json");    // 응답 방식을 JSON으로 변경
                    response.getWriter().write("{\"success\":true}");
                    response.getWriter().flush();           //JSON 형식의 true 응답
                })
                .failureHandler((request, response, exception) -> {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\":false}");
                    response.getWriter().flush();       
                })
        );

        http.authenticationProvider(authenticationProvider(customUserDetailsService, passwordEncoder()));

        // 6. 시큐리티 로그아웃 (시큐리티에서 제공하는 로그아웃 기능 커스텀)
        http.logout(logout -> 
            logout
                .logoutUrl("/api/auth/logout")          // 로그아웃 요청 URL
                .invalidateHttpSession(true)               // 세션 무효화
                .deleteCookies("JSESSIONID")               // 쿠키 제거 (선택)
                .logoutSuccessHandler((request, response, authentication) -> {
                    // 세션에서 loginUser 제거 (invalidateHttpSession=true면 없어도 됨)
                    request.getSession().removeAttribute("user");

                    // JSON 응답
                    response.setContentType("application/json");
                    response.getWriter().write("{\"success\":true}");
                    response.getWriter().flush();
                })
        );

        // OAuth2
         http.oauth2Login(oauth2Login -> {
            oauth2Login
                .loginPage("/api/auth/login") // 같은 로그인 페이지 사용
                .userInfoEndpoint(userInfo -> userInfo.userService(customOAuth2UserService)) // OAuth2 사용자 정보 처리
                .defaultSuccessUrl("/"); // 로그인 성공 시 이동할 URL
        });

        return http.build();
    }

    @Bean
    public static PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider(CustomUserDetailsService userDetailsService,
                                                            PasswordEncoder passwordEncoder) {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        return authProvider;
    }
}
