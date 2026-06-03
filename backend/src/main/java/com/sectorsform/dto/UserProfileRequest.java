package com.sectorsform.dto;

import java.util.List;

public record UserProfileRequest(
    String sessionId,
    String name,
    List<Integer> sectorIds,
    boolean agreeToTerms
) {}
