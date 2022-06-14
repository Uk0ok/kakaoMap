package com.uk0ok.kakaoMap;

import com.uk0ok.kakaoMap.mapper.TestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class KakaoMapApplication {

	@Autowired
	TestMapper testMapper;

	public static void main(String[] args) {
		SpringApplication.run(KakaoMapApplication.class, args);
	}
}
