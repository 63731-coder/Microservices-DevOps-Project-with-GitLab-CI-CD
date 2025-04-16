package be.esi.devops.demo.rest;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.beans.factory.annotation.Autowired;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(ServiceRestController.class)
public class ServiceRestControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void shouldReturnErrorIfFlaskUnavailable() throws Exception {
        mockMvc.perform(get("/proxy"))
               .andExpect(status().isServiceUnavailable())
               .andExpect(content().string("Service Flask injoignable !"));
    }
}

