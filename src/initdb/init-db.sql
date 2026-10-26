CREATE TABLE token_family(
  token_family_id CHAR(36)    NOT NULL PRIMARY KEY,
  user_id         VARCHAR(64) NOT NULL,
  is_revoked      BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expires_at      TIMESTAMP   NOT NULL 
);

CREATE TABLE refresh_token (
  token_hash      CHAR(64)    NOT NULL PRIMARY KEY,
  token_family_id CHAR(36)    NOT NULL,
	is_used         BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expires_at      TIMESTAMP   NOT NULL,
  CONSTRAINT fk_refresh_token_family
    FOREIGN KEY (token_family_id)
    REFERENCES token_family (token_family_id)
    ON DELETE CASCADE
);
