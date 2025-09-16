BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "password" (
    "id" bigserial PRIMARY KEY,
    "service" text NOT NULL,
    "iv" text NOT NULL,
    "password" text NOT NULL,
    "_userPasswordsUserId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "username" text NOT NULL,
    "salt" text NOT NULL,
    "master" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_username_unique_idx" ON "user" USING btree ("username");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "password"
    ADD CONSTRAINT "password_fk_0"
    FOREIGN KEY("_userPasswordsUserId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR password_manager
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('password_manager', '20250916175346727', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250916175346727', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
