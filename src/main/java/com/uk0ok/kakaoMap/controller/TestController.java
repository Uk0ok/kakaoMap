package com.uk0ok.kakaoMap.controller;

import com.uk0ok.kakaoMap.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;


import java.util.List;
import java.util.Map;

@ResponseBody
@RestController
public class TestController {
    private TestService testService;

    @Autowired
    public TestController(TestService testService) {
        this.testService = testService;
    }

    @RequestMapping(value = "/getTest", method = RequestMethod.GET)
    public List<Map<String, Object>> getTest() {
        // List<Map<>> 잘 사용 안한다. anti pattern
        // model
        return testService.getTest();
    }

    /**
     * 1. DB연동해서 좌표값 가져오기
     * 2. 좌표값으로 지도에 찍기
     */

}
