package com.example.demo;

import java.time.Instant;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class GreetingController {

    private final String applicationName;

    public GreetingController(@Value("${spring.application.name}") String applicationName) {
        this.applicationName = applicationName;
    }

    @GetMapping("/greetings")
    public Greeting greeting(@RequestParam(defaultValue = "world") String name) {
        return new Greeting("Hello, " + name + "!", applicationName, Instant.now());
    }

    public record Greeting(String message, String service, Instant timestamp) {
    }
}
