package com.sectorsform.dto;

import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

import java.util.List;

public record UserProfileRequest(
        @NotBlank(message = "Session ID is required")
        String sessionId,

        @NotBlank(message = "Name is required")
        @Size(max = 100, message = "Name must not exceed 100 characters")
        String name,

        @NotEmpty(message = "At least one sector must be selected")
        List<Integer> sectorIds,

        @AssertTrue(message = "Terms must be accepted")
        boolean agreeToTerms
) {}
