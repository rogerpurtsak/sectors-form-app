package com.sectorsform.dto;

import java.util.List;

public record UserProfileResponse(
        String sessionId,
        String name,
        List<Integer> sectorIds,
        boolean agreeToTerms
) {}
