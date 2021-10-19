package com.microsoft.app;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import io.micrometer.core.instrument.MeterRegistry;
import io.micrometer.core.instrument.Counter;

@RestController
public class RootController {
	Counter requests;

	public RootController(MeterRegistry registry) {
		requests = Counter.builder("hits")
			.description("Number of hits")
			.register(registry);
	}

	@GetMapping("/")
	public String helloWorld() {
		requests.increment();
		return "Hello, World!";
	}

	@GetMapping("/healthcheck")
	public String healthCheck() {
		return "Healthy";
	}
}
