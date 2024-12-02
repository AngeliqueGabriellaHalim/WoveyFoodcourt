package com.example.TubesManPro;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import lombok.NonNull;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(@NonNull ResourceHandlerRegistry registry) {
        // Serve files from the uploads folder (new folder)
        registry.addResourceHandler("/Assets/**")
                .addResourceLocations("file:/C:/Users/Junita Hariyati/OneDrive - Universitas Katolik Parahyangan/Semester 5/ManPro/Wovey Foodcourt/Project/Arlo/uploads/Assets");

        // Serve files from the static folder (old folder)
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }

}