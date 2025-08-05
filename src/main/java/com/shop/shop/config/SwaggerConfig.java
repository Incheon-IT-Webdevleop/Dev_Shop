package com.shop.shop.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .components(new Components())
                .info(apiInfo());
    }

    @Bean
    public Info apiInfo() {
        return new Info()
                .title("Shoppingmall Project SwaggerAPI ")
                .description("Springdoc을 사용한 Swagger UI 테스트")
                .version("2.2.0");
    }
}
