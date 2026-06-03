package com.sectorsform.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "sectors")
public class Sector {

    @Id
    private Integer id;

    @Column(nullable = false)
    private String name;

    @Column(name = "parent_id")
    private Integer parentId;

    @Column(nullable = false)
    private Short level;

    @Column(name = "sort_order", nullable = false)
    private Integer sortOrder;

    public Integer getId()       { return id; }
    public String  getName()     { return name; }
    public Integer getParentId() { return parentId; }
    public Short   getLevel()    { return level; }
    public Integer getSortOrder(){ return sortOrder; }
}
