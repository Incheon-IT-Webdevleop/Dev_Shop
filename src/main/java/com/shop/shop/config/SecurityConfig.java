package com.shop.shop.config;

import com.shop.shop.purchase.PurchaseService;
import com.shop.shop.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
public class SecurityConfig {

    @Autowired
    UserService userService;
    @Autowired
    PurchaseService purchaseService;

    @Bean
    public SecurityFilterChain filterChain (HttpSecurity http) throws Exception {
        http.authorizeHttpRequests((httpReq) -> {
            httpReq
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
                        .loginPage("/auth/login")             // 로그인할 view page url 정의
                        .loginProcessingUrl("/auth/login.do") // 로그인을 처리할 URL 정의 : POST 방식
                        .usernameParameter("email")               // 로그인에 사용할 id 변수명
                        .passwordParameter("password")              // 로그인에 사용할 password 변수
                        //.defaultSuccessUrl("/")                 // 로그인 성공시 이동할 page url 정의
                        //.failureUrl("/member/login")     // 로그인 실패시 이동할 page url 정의
                        // fetch/axios 처리에서는 아래와같이 사용
                        .successHandler((request, response, exception) -> {
                            System.out.println("로그인 성공!!!");
                            response.setContentType("application/json");    // 응답 방식을 JSON으로 변경
                            response.getWriter().println("true");           //JSON 형식의 true 응답
                        })
                        .failureHandler((request, response, exception) -> {
                            System.out.println("로그인 실패!!! : " + exception.getMessage() );
                            exception.printStackTrace(); // 스택 트레이스 출력
                            response.setContentType("application/json");
                            response.getWriter().println("false");
                        })
        );

        // 6. 시큐리티 로그아웃 (시큐리티에서 제공하는 로그아웃 기능 커스텀)
        // 1). 시큐리티 설정클래스에서 로그인 관련된 설정 코드를 작성한다.
        http.logout(logoutform ->
                logoutform
                        .logoutUrl("/auth/logout.do")          // 로그아웃 요청할 url : GET 방식
                        .logoutSuccessUrl("/")                  // 로그아웃 성공시 이동할 page url 정의
                        .invalidateHttpSession(true)            // 로그아웃 성공시 (로그인) 세션 초기화

        );
        // 2).로그인시 암호화된 패스워드를 검증할 암호화 클래스

        // 7. 로그인을 처리할 서비스 객체 정의
        //http.userDetailsService(userService);

        // 8. 시큐리티에서 Oauth2 로그인 페이지와 (커스텀/오버라이딩/재정의) 서비스 정의
//        http.oauth2Login(oauth2Login -> {
//            oauth2Login
//                    .loginPage("/auth/login")
//                    .userInfoEndpoint(userinfo -> {
//                        userinfo.userService(userService); // oauth2에서 로그인 성공시 유저 정보를 받을 객체 정의
//                    });
//        });

        // cors 설정
//        http
//                .cors(cors -> cors.configurationSource(corsConfigurationSource()));

        // 2. http 객체를 빌드/실행하여 보안 필터 체인을 생성
        return http.build();
    }
}
