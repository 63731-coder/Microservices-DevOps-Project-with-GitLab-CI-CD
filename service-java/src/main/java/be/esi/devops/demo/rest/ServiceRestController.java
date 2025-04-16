package be.esi.devops.demo.rest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import org.springframework.beans.factory.annotation.Value;

@RestController
public class ServiceRestController {

    @Value("${flask.url:http://localhost:5000}")
    private String flaskUrl;

    @GetMapping("/proxy")
    public ResponseEntity<String> getMessageFromFlask() {
        try {
            RestTemplate restTemplate = new RestTemplate();
            String url = flaskUrl + "/api/message";
            String response = restTemplate.getForObject(url, String.class);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                .body("Service Flask injoignable !");
        }
    }
}
