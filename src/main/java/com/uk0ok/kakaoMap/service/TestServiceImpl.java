package com.uk0ok.kakaoMap.service;

import com.uk0ok.kakaoMap.mapper.TestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class TestServiceImpl implements TestService {
    private TestMapper testMapper;

    @Autowired
    public TestServiceImpl(TestMapper testMapper) {
        this.testMapper = testMapper;
    }

    @Override
    public List<Map<String, Object>> getTest() {

        return testMapper.getTest();
    }


}
