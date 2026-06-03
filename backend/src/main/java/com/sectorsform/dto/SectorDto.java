package com.sectorsform.dto;

public record SectorDto(
        Integer id,
        String name,
        Integer parentId,
        Short level,
        Integer sortOrder
) {}
