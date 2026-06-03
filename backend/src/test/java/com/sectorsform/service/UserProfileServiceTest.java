package com.sectorsform.service;

import com.sectorsform.dto.UserProfileRequest;
import com.sectorsform.dto.UserProfileResponse;
import com.sectorsform.entity.UserProfile;
import com.sectorsform.repository.SectorRepository;
import com.sectorsform.repository.UserProfileRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class UserProfileServiceTest {

    @Mock private UserProfileRepository profileRepository;
    @Mock private SectorRepository sectorRepository;
    @InjectMocks private UserProfileService service;

    @Test
    void save_createsNewProfile_whenSessionIdNotFound() {
        UserProfileRequest request = new UserProfileRequest("session-1", "Alice", List.of(1), true);

        UserProfile saved = profileWithValues("session-1", "Alice");

        when(profileRepository.findBySessionId("session-1")).thenReturn(Optional.empty());
        when(sectorRepository.findAllById(any())).thenReturn(List.of());
        when(profileRepository.save(any())).thenReturn(saved);

        UserProfileResponse response = service.save(request);

        assertThat(response.name()).isEqualTo("Alice");
        assertThat(response.sessionId()).isEqualTo("session-1");
    }

    @Test
    void save_updatesExistingProfile_whenSessionIdExists() {
        UserProfileRequest request = new UserProfileRequest("session-1", "Bob", List.of(1), true);

        UserProfile existing = profileWithValues("session-1", "Alice");
        UserProfile updated  = profileWithValues("session-1", "Bob");

        when(profileRepository.findBySessionId("session-1")).thenReturn(Optional.of(existing));
        when(sectorRepository.findAllById(any())).thenReturn(List.of());
        when(profileRepository.save(any())).thenReturn(updated);

        UserProfileResponse response = service.save(request);

        assertThat(response.name()).isEqualTo("Bob");
    }

    @Test
    void getBySessionId_returnsResponse_whenProfileExists() {
        UserProfile profile = profileWithValues("session-1", "Alice");
        when(profileRepository.findBySessionId("session-1")).thenReturn(Optional.of(profile));

        UserProfileResponse response = service.getBySessionId("session-1");

        assertThat(response.name()).isEqualTo("Alice");
        assertThat(response.agreeToTerms()).isTrue();
    }

    @Test
    void getBySessionId_throws404_whenProfileMissing() {
        when(profileRepository.findBySessionId("missing")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> service.getBySessionId("missing"))
                .isInstanceOf(ResponseStatusException.class);
    }

    private UserProfile profileWithValues(String sessionId, String name) {
        UserProfile p = new UserProfile();
        p.setSessionId(sessionId);
        p.setName(name);
        p.setAgreeToTerms(true);
        p.setSectors(Set.of());
        return p;
    }
}
