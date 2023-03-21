package com.benson.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
public class HelloWorldController {

    @GetMapping("/live")
    public String live(){
        return "Hello Zeabur SpringBoot - " + UUID.randomUUID();
    }

}
