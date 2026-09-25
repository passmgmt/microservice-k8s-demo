package com.example.demo;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

@WebMvcTest(GreetingController.class)
class GreetingControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void returnsGreetingForProvidedName() throws Exception {
        mockMvc.perform(get("/api/v1/greetings").param("name", "Kubernetes"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Hello, Kubernetes!"))
                .andExpect(jsonPath("$.service").value("microservice-k8s-demo"))
                .andExpect(jsonPath("$.timestamp").exists());
    }
}
