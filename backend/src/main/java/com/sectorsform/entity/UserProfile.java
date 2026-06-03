package com.sectorsform.entity;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "user_profiles")
public class UserProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "session_id", nullable = false, unique = true)
    private String sessionId;

    @Column(nullable = false)
    private String name;

    @Column(name = "agree_to_terms", nullable = false)
    private boolean agreeToTerms;

    @ManyToMany
    @JoinTable(
            name = "user_profile_sectors",
            joinColumns = @JoinColumn(name = "user_profile_id"),
            inverseJoinColumns = @JoinColumn(name = "sector_id")
    )
    private Set<Sector> sectors = new HashSet<>();

    public Long    getId()           { return id; }
    public String  getSessionId()    { return sessionId; }
    public String  getName()         { return name; }
    public boolean isAgreeToTerms()  { return agreeToTerms; }
    public Set<Sector> getSectors()  { return sectors; }

    public void setSessionId(String sessionId)       { this.sessionId = sessionId; }
    public void setName(String name)                 { this.name = name; }
    public void setAgreeToTerms(boolean agreeToTerms){ this.agreeToTerms = agreeToTerms; }
    public void setSectors(Set<Sector> sectors)      { this.sectors = sectors; }
}
