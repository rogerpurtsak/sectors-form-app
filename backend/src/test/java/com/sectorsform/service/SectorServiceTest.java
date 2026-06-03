package com.sectorsform.service;

import com.sectorsform.dto.SectorDto;
import com.sectorsform.entity.Sector;
import com.sectorsform.repository.SectorRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class SectorServiceTest {

    @Mock private SectorRepository repository;
    @InjectMocks private SectorService service;

    @Test
    void getAll_returnsMappedDtos() {
        Sector s = mock(Sector.class);
        when(s.getId()).thenReturn(1);
        when(s.getName()).thenReturn("Manufacturing");
        when(s.getParentId()).thenReturn(null);
        when(s.getLevel()).thenReturn((short) 0);
        when(s.getSortOrder()).thenReturn(1);

        when(repository.findAllByOrderBySortOrderAsc()).thenReturn(List.of(s));

        List<SectorDto> result = service.getAll();

        assertThat(result).hasSize(1);
        assertThat(result.get(0).name()).isEqualTo("Manufacturing");
        assertThat(result.get(0).level()).isEqualTo((short) 0);
    }

    @Test
    void getAll_returnsEmptyList_whenNoSectors() {
        when(repository.findAllByOrderBySortOrderAsc()).thenReturn(List.of());

        assertThat(service.getAll()).isEmpty();
    }
}
