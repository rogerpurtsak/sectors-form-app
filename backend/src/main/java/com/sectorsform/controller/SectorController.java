package com.sectorsform.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sectorsform.dto.SectorDto;
import com.sectorsform.service.SectorService;

@RestController
@RequestMapping("/api/sectors")
public class SectorController {

    private final SectorService service;

    public SectorController(SectorService service) {
        this.service = service;
    }

    @GetMapping
    public List<SectorDto> getAll() {
        return service.getAll();
    }
}
