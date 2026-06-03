-- =============================================================
-- sectors
-- Hierarchical list of industry sectors.
-- parent_id points to another row in the same table (NULL = root).
-- =============================================================
CREATE TABLE sectors (
    id         INTEGER PRIMARY KEY,
    name       VARCHAR(255)             NOT NULL,
    parent_id  INTEGER                  REFERENCES sectors(id),
    level      SMALLINT                 NOT NULL DEFAULT 0,
    sort_order INTEGER                  NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- =============================================================
-- user_profiles
-- One row per submitted form, identified by session_id.
-- session_id is UNIQUE so the same session cannot create
-- two separate profiles.
-- =============================================================
CREATE TABLE user_profiles (
    id             BIGSERIAL PRIMARY KEY,
    session_id     VARCHAR(255)             NOT NULL UNIQUE,
    name           VARCHAR(255)             NOT NULL,
    agree_to_terms BOOLEAN                  NOT NULL DEFAULT FALSE,
    created_at     TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE user_profile_sectors (
    user_profile_id     BIGINT NOT NULL,
    sector_id           INTEGER NOT NULL,
    PRIMARY KEY (user_profile_id, sector_id),
    FOREIGN KEY (user_profile_id) REFERENCES user_profiles(id) ON DELETE CASCADE,
    FOREIGN KEY (sector_id) REFERENCES sectors(id)
);