package com.sectorsform.service;

import com.sectorsform.dto.UserProfileRequest;
import com.sectorsform.dto.UserProfileResponse;
import com.sectorsform.entity.Sector;
import com.sectorsform.entity.UserProfile;
import com.sectorsform.repository.SectorRepository;
import com.sectorsform.repository.UserProfileRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

import java.util.HashSet;
import java.util.List;

@Service
@Transactional
public class UserProfileService {

    private final UserProfileRepository profileRepository;
    private final SectorRepository sectorRepository;

    public UserProfileService(UserProfileRepository profileRepository,
                              SectorRepository sectorRepository) {
        this.profileRepository = profileRepository;
        this.sectorRepository = sectorRepository;
    }

    public UserProfileResponse save(UserProfileRequest request) {
        UserProfile profile = profileRepository
                .findBySessionId(request.sessionId())
                .orElseGet(UserProfile::new);

        profile.setSessionId(request.sessionId());
        profile.setName(request.name());
        profile.setAgreeToTerms(request.agreeToTerms());
        profile.setSectors(new HashSet<>(sectorRepository.findAllById(request.sectorIds())));

        UserProfile saved = profileRepository.save(profile);

        List<Integer> sectorIds = saved.getSectors()
                .stream()
                .map(Sector::getId)
                .toList();

        return new UserProfileResponse(
                saved.getSessionId(),
                saved.getName(),
                sectorIds,
                saved.isAgreeToTerms()
        );
    }

    public UserProfileResponse getBySessionId(String sessionId) {
        UserProfile profile = profileRepository.findBySessionId(sessionId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        List<Integer> sectorIds = profile.getSectors().stream().map(Sector::getId).toList();
        return new UserProfileResponse(
                profile.getSessionId(),
                profile.getName(),
                sectorIds,
                profile.isAgreeToTerms()
        );
    }
}
