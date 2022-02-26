-- SQLINES DEMO *** le SQL Developer Data Modeler 20.4.0.374.0801
-- SQLINES DEMO *** -02-26 13:02:47 EST
-- SQLINES DEMO *** le Database 21c
-- SQLINES DEMO *** le Database 21c



-- SQLINES DEMO *** no DDL - MDSYS.SDO_GEOMETRY

-- SQLINES DEMO *** no DDL - XMLTYPE

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE batch (
    bid               BIGINT NOT NULL COMMENT 'Batch ID',
    bnum              BIGINT NOT NULL COMMENT 'Batch number',
    bstatus           TINYINT NOT NULL COMMENT '0 - In warehouse
1 - In transit
2 - arrived
',
    btrack            VARCHAR(40) NOT NULL COMMENT 'Tracking number',
    donations_did     VARCHAR(40) NOT NULL,
    carrier_cid       TINYINT,
    warehouse_wid     TINYINT,
    manufacturer_mid  TINYINT NOT NULL,
    product_pid       TINYINT NOT NULL,
    shipment_sid      VARCHAR(40) NOT NULL,
    request_rid       VARCHAR(40)
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN batch.bid IS
    'Batch ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN batch.bnum IS
    'Batch number'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN batch.bstatus IS
    '0 - In warehouse
1 - In transit
2 - arrived
'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN batch.btrack IS
    'Tracking number'; */

ALTER TABLE batch ADD CONSTRAINT batch_pk PRIMARY KEY ( bid );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE carrier (
    cid    TINYINT NOT NULL COMMENT 'Carrier ID',
    cname  VARCHAR(10) NOT NULL COMMENT 'Carrier Name'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN carrier.cid IS
    'Carrier ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN carrier.cname IS
    'Carrier Name'; */

ALTER TABLE carrier ADD CONSTRAINT carrier_pk PRIMARY KEY ( cid );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE donations (
    did       VARCHAR(40) NOT NULL COMMENT 'Donations ID',
    dtotal    BIGINT NOT NULL COMMENT 'Total number',
    dmin      BIGINT NOT NULL COMMENT 'The smallest number this supply can be divided into. E.g. 1000 masks are packed into smaller packets each contains 10 masks. MUST > 0 and is a divisible of total number.',
    user_uid  VARCHAR(40)
);

ALTER TABLE donations COMMENT
    'Donations, stored in Firestore';

/* Moved to CREATE TABLE
COMMENT ON COLUMN donations.did IS
    'Donations ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN donations.dtotal IS
    'Total number'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN donations.dmin IS
    'The smallest number this supply can be divided into. E.g. 1000 masks are packed into smaller packets each contains 10 masks. MUST > 0 and is a divisible of total number.'; */

ALTER TABLE donations ADD CONSTRAINT donations_pk PRIMARY KEY ( did );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE manufacturer (
    mid    TINYINT NOT NULL COMMENT 'Manufacturer ID',
    mname  VARCHAR(40) NOT NULL COMMENT 'Manufacturer NAME'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN manufacturer.mid IS
    'Manufacturer ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN manufacturer.mname IS
    'Manufacturer NAME'; */

ALTER TABLE manufacturer ADD CONSTRAINT manufacturer_pk PRIMARY KEY ( mid );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE manufacturer_product (
    manufacturer_mid  TINYINT NOT NULL,
    product_pid       TINYINT NOT NULL
);

ALTER TABLE manufacturer_product ADD CONSTRAINT manufacturer_product_pk PRIMARY KEY ( manufacturer_mid,
                                                                                      product_pid );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE product (
    pid          TINYINT NOT NULL,
    pname        VARCHAR(25) NOT NULL COMMENT 'Product name',
    request_rid  VARCHAR(40),
    rptotal      BIGINT
);

ALTER TABLE product
    ADD CHECK ( ( request_rid IS NULL
                  AND rptotal IS NULL )
                OR ( request_rid IS NOT NULL
                     AND rptotal IS NOT NULL ) );

/* Moved to CREATE TABLE
COMMENT ON COLUMN product.pname IS
    'Product name'; */

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( pid );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE request (
    rid       VARCHAR(40) NOT NULL COMMENT 'Request ID',
    rpid      BIGINT NOT NULL COMMENT 'Request product type, ArrayList',
    user_uid  VARCHAR(40)
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN request.rid IS
    'Request ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN request.rpid IS
    'Request product type, ArrayList'; */

ALTER TABLE request ADD CONSTRAINT request_pk PRIMARY KEY ( rid );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE shipment (
    sid    VARCHAR(40) NOT NULL COMMENT 'Shipment/Package ID.',
    stype  TINYINT NOT NULL COMMENT '0 - Ground
1 - Air
2 - Sea'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN shipment.sid IS
    'Shipment/Package ID.'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN shipment.stype IS
    '0 - Ground
1 - Air
2 - Sea'; */

ALTER TABLE shipment ADD CONSTRAINT shipment_pk PRIMARY KEY ( sid );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE `USER` (
    `UID`   VARCHAR(40) NOT NULL,
    ufname  VARCHAR(20) NOT NULL COMMENT 'User''s first name',
    ulname  VARCHAR(20) NOT NULL COMMENT 'User''s last name',
    usex    DOUBLE NOT NULL COMMENT 'Male - 1 Female 0',
    uemail  VARCHAR(40) NOT NULL,
    utype   TINYINT NOT NULL COMMENT '0 - Super Admin
1 - Warehouse Admin
2 - Regional Admin
1 - general user
... TODO'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN `USER`.ufnam` IS
    'User''s first name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN `USER`.ulnam` IS
    'User''s last name'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN `USER`.use` IS
    'Male - 1 Female 0'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN `USER`.utyp` IS
    '0 - Super Admin
1 - Warehouse Admin
2 - Regional Admin
1 - general user
... TODO'; */

ALTER TABLE `USER` ADD CONSTRAINT user_pk PRIMARY KEY ( `UID` );

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE warehouse (
    wid       TINYINT NOT NULL COMMENT 'Warehouse ID',
    waddr1    VARCHAR(80) NOT NULL COMMENT 'Warehouse address line 1',
    waddr2    VARCHAR(20) NOT NULL COMMENT 'Warehouse address line 2',
    wcity     VARCHAR(20) NOT NULL COMMENT 'Warehouse City',
    wstate    VARCHAR(20) NOT NULL COMMENT 'Warehouse State/Provience',
    wcountry  VARCHAR(20) NOT NULL COMMENT 'Warehouse Country',
    wzip      BIGINT NOT NULL COMMENT 'Warehouse zip code'
);

/* Moved to CREATE TABLE
COMMENT ON COLUMN warehouse.wid IS
    'Warehouse ID'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN warehouse.waddr1 IS
    'Warehouse address line 1'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN warehouse.waddr2 IS
    'Warehouse address line 2'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN warehouse.wcity IS
    'Warehouse City'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN warehouse.wstate IS
    'Warehouse State/Provience'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN warehouse.wcountry IS
    'Warehouse Country'; */

/* Moved to CREATE TABLE
COMMENT ON COLUMN warehouse.wzip IS
    'Warehouse zip code'; */

ALTER TABLE warehouse ADD CONSTRAINT warehouse_pk PRIMARY KEY ( wid );

ALTER TABLE batch
    ADD CONSTRAINT batch_carrier_fk FOREIGN KEY ( carrier_cid )
        REFERENCES carrier ( cid );

ALTER TABLE batch
    ADD CONSTRAINT batch_donations_fk FOREIGN KEY ( donations_did )
        REFERENCES donations ( did );

ALTER TABLE batch
    ADD CONSTRAINT batch_manufacturer_fk FOREIGN KEY ( manufacturer_mid )
        REFERENCES manufacturer ( mid );

ALTER TABLE batch
    ADD CONSTRAINT batch_product_fk FOREIGN KEY ( product_pid )
        REFERENCES product ( pid );

ALTER TABLE batch
    ADD CONSTRAINT batch_request_fk FOREIGN KEY ( request_rid )
        REFERENCES request ( rid );

ALTER TABLE batch
    ADD CONSTRAINT batch_shipment_fk FOREIGN KEY ( shipment_sid )
        REFERENCES shipment ( sid );

ALTER TABLE batch
    ADD CONSTRAINT batch_warehouse_fk FOREIGN KEY ( warehouse_wid )
        REFERENCES warehouse ( wid );

ALTER TABLE donations
    ADD CONSTRAINT donations_user_fk FOREIGN KEY ( user_uid )
        REFERENCES `USER` ( `UID` );

-- SQLINES DEMO *** ength exceeds maximum allowed length(30) 
ALTER TABLE manufacturer_product
    ADD CONSTRAINT manufacturer_product_manufacturer_fk FOREIGN KEY ( manufacturer_mid )
        REFERENCES manufacturer ( mid );

-- SQLINES DEMO *** ength exceeds maximum allowed length(30) 
ALTER TABLE manufacturer_product
    ADD CONSTRAINT manufacturer_product_product_fk FOREIGN KEY ( product_pid )
        REFERENCES product ( pid );

ALTER TABLE product
    ADD CONSTRAINT product_request_fk FOREIGN KEY ( request_rid )
        REFERENCES request ( rid );

ALTER TABLE request
    ADD CONSTRAINT request_user_fk FOREIGN KEY ( user_uid )
        REFERENCES `USER` ( `UID` );



-- SQLINES DEMO *** per Data Modeler Summary Report: 
-- 
-- SQLINES DEMO ***                        10
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                        23
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** DY                      0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***  TYPE                   0
-- SQLINES DEMO ***  TYPE                   0
-- SQLINES DEMO ***  TYPE BODY              0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** EGMENT                  0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** ED VIEW                 0
-- SQLINES DEMO *** ED VIEW LOG             0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- 
-- SQLINES DEMO ***                         0
-- SQLINES DEMO ***                         0
-- 
-- SQLINES DEMO ***                         0
-- 
-- SQLINES DEMO ***                         0
-- SQLINES DEMO *** A                       0
-- SQLINES DEMO *** T                       0
-- 
-- SQLINES DEMO ***                         2
-- SQLINES DEMO ***                         0
