package com.sectorsform.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sectorsform.dto.UserProfileRequest;
import com.sectorsform.dto.UserProfileResponse;
import com.sectorsform.service.UserProfileService;

@RestController
@RequestMapping("/api/user-profile")
public class UserProfileController {

    private final UserProfileService service;

    public UserProfileController(UserProfileService service) {
        this.service = service;
    }

    @PostMapping
    public UserProfileResponse save(@RequestBody UserProfileRequest request) {
        return service.save(request);
    }
    
}
