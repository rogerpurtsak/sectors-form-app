package com.sectorsform.service;

import com.sectorsform.dto.SectorDto;
import com.sectorsform.repository.SectorRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SectorService {

    private final SectorRepository repository;

    public SectorService(SectorRepository repository) {
        this.repository = repository;
    }

    public List<SectorDto> getAll() {
        return repository.findAllByOrderBySortOrderAsc()
                .stream()
                .map(s -> new SectorDto(s.getId(), s.getName(), s.getParentId(), s.getLevel(), s.getSortOrder()))
                .toList();
    }
}
