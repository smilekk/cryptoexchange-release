

-- BEGIN generate DDL --

DROP DATABASE IF EXISTS ui;

CREATE DATABASE ui;

DROP USER IF EXISTS ui_rw@'%';

CREATE USER ui_rw@'%' IDENTIFIED BY 'ui_rw_password';

GRANT SELECT,INSERT,DELETE,UPDATE ON ui.* TO ui_rw@'%' WITH GRANT OPTION;

DROP USER IF EXISTS ui_ro@'%';

CREATE USER ui_ro@'%' IDENTIFIED BY 'ui_ro_password';

GRANT SELECT ON ui.* TO ui_ro@'%' WITH GRANT OPTION;

USE ui;

CREATE TABLE password_auths (
  id BIGINT AUTO_INCREMENT NOT NULL,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  userId BIGINT NOT NULL,
  version BIGINT NOT NULL,
  random VARCHAR(32) NOT NULL,
  passwd VARCHAR(100) NOT NULL,
  CONSTRAINT UNI_USERID UNIQUE (userId),
  PRIMARY KEY(id)
) Engine=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;


CREATE TABLE registration_requests (
  id BIGINT AUTO_INCREMENT NOT NULL,
  createdAt BIGINT NOT NULL,
  expiresAt BIGINT NOT NULL,
  referrerId BIGINT NOT NULL,
  code VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  lang VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL,
  passwd VARCHAR(100) NOT NULL,
  CONSTRAINT UNI_EMAIL UNIQUE (email),
  PRIMARY KEY(id)
) Engine=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;


CREATE TABLE sms_messages (
  id BIGINT AUTO_INCREMENT NOT NULL,
  sent BOOL NOT NULL,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  version BIGINT NOT NULL,
  content VARCHAR(200) NOT NULL,
  PRIMARY KEY(id)
) Engine=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;


CREATE TABLE bind_requests (
  id BIGINT AUTO_INCREMENT NOT NULL,
  createdAt BIGINT NOT NULL,
  expiresAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  userId BIGINT NOT NULL,
  version BIGINT NOT NULL,
  type VARCHAR(50) NOT NULL,
  bindData VARCHAR(1000) NOT NULL,
  CONSTRAINT UNI_USERID_TYPE UNIQUE (userId, type),
  PRIMARY KEY(id)
) Engine=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;


CREATE TABLE mail_messages (
  id BIGINT AUTO_INCREMENT NOT NULL,
  sent BOOL NOT NULL,
  retry INTEGER NOT NULL,
  createdAt BIGINT NOT NULL,
  nextRetryAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  userId BIGINT NOT NULL,
  version BIGINT NOT NULL,
  sentBy VARCHAR(32) NOT NULL,
  type VARCHAR(50) NOT NULL,
  mailTo VARCHAR(100) NOT NULL,
  name VARCHAR(200) NOT NULL,
  mailData VARCHAR(1000) NOT NULL,
  mailSubject VARCHAR(1000) NOT NULL,
  INDEX IDX_RETRY (nextRetryAt),
  PRIMARY KEY(id)
) Engine=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;


CREATE TABLE user_profiles (
  userId BIGINT NOT NULL,
  createdAt BIGINT NOT NULL,
  organizationId BIGINT NOT NULL,
  referrerId BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  version BIGINT NOT NULL,
  withdrawUntil BIGINT NOT NULL,
  email VARCHAR(50) NOT NULL,
  lang VARCHAR(50) NOT NULL,
  mobile VARCHAR(32) NOT NULL,
  name VARCHAR(50) NOT NULL,
  referrerCode VARCHAR(32) NOT NULL,
  tel VARCHAR(32) NOT NULL,
  CONSTRAINT UNI_EMAIL UNIQUE (email),
  CONSTRAINT UNI_REFERRERCODE UNIQUE (referrerCode),
  PRIMARY KEY(userId)
) Engine=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;


CREATE TABLE ga_auths (
  id BIGINT AUTO_INCREMENT NOT NULL,
  createdAt BIGINT NOT NULL,
  userId BIGINT NOT NULL,
  secretKey VARCHAR(50) NOT NULL,
  CONSTRAINT UNI_USERID UNIQUE (userId),
  PRIMARY KEY(id)
) Engine=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;


CREATE TABLE site_messages (
  id BIGINT AUTO_INCREMENT NOT NULL,
  markRead BOOL NOT NULL,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  userId BIGINT NOT NULL,
  version BIGINT NOT NULL,
  sentBy VARCHAR(32) NOT NULL,
  name VARCHAR(200) NOT NULL,
  content VARCHAR(1000) NOT NULL,
  PRIMARY KEY(id)
) Engine=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;


CREATE TABLE signin_logs (
  id BIGINT AUTO_INCREMENT NOT NULL,
  createdAt BIGINT NOT NULL,
  userId BIGINT NOT NULL,
  ip VARCHAR(50) NOT NULL,
  location VARCHAR(50) NOT NULL,
  CONSTRAINT UNI_USERID UNIQUE (userId),
  PRIMARY KEY(id)
) Engine=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;


CREATE TABLE mail_templates (
  id BIGINT AUTO_INCREMENT NOT NULL,
  createdAt BIGINT NOT NULL,
  updatedAt BIGINT NOT NULL,
  version BIGINT NOT NULL,
  lang VARCHAR(50) NOT NULL,
  type VARCHAR(50) NOT NULL,
  mailSubject VARCHAR(1000) NOT NULL,
  mailBody TEXT NOT NULL,
  CONSTRAINT UNI_TYPE_LANG UNIQUE (type, lang),
  PRIMARY KEY(id)
) Engine=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;

-- END generate DDL --
