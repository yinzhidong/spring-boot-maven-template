package com.benson.ZeaburMavenTest.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
public class HelloWorldController {

    @GetMapping("/")
    public String index(){
        return "Hello Zeabur SpringBoot - " + UUID.randomUUID().toString();
    }

}
