SET sql_mode = STRICT_ALL_TABLES;

DROP TABLE if EXISTS Upvote;
DROP TABLE if EXISTS Review;
DROP TABLE if EXISTS Property;
DROP TABLE if EXISTS User;


CREATE TABLE User (
    user_id CHAR(36),

    first_name VARCHAR(32) NULL,
    last_name VARCHAR(32) NULL,
    email VARCHAR(80) NOT NULL UNIQUE,
    password CHAR(60) NOT NULL,

    join_date DATETIME,
    last_login_date DATETIME,

    PRIMARY KEY (user_id)
);

CREATE TABLE Property (
    street VARCHAR(64),
    city VARCHAR(64),
    

    landlord_id CHAR(36),

    state CHAR(2) NOT NULL,
    type VARCHAR(30),
    next_lease_date DATE,
    beds TINYINT UNSIGNED,
    baths DECIMAL(3,1) UNSIGNED,
    area INT UNSIGNED,

    rent DECIMAL(8,2) UNSIGNED,

    file_name VARCHAR(255),
    pic_link VARCHAR(100),
    verified BOOLEAN,

    PRIMARY KEY (street, city),
    FOREIGN Key (landlord_id) REFERENCES Landlord (landlord_id)
);

CREATE TABLE Review (
    review_id INT UNSIGNED AUTO_INCREMENT,

    user_id CHAR(36) NULL,

    street VARCHAR(64),
    city VARCHAR(64),
    

    body VARCHAR(500),
    rating DECIMAL(3,1) UNSIGNED,
    post_date DATETIME,

    PRIMARY KEY (review_id),
    FOREIGN KEY (user_id) REFERENCES User (user_id),
    FOREIGN Key (street, city) REFERENCES Property (street, city)
);

CREATE TABLE Upvote (
    review_id INT UNSIGNED,
    user_id CHAR(36),

    PRIMARY KEY (review_id, user_id),
    FOREIGN KEY (review_id) REFERENCES Review (review_id),
    FOREIGN KEY (user_id) REFERENCES User (user_id)
);

CREATE TABLE Landlord (
    landlord_id CHAR(36),

    user_id CHAR(36),

    
    phone CHAR(12),
    email VARCHAR(80),

    street VARCHAR(64),
    city VARCHAR(64),
    

    file_name VARCHAR(255),

    PRIMARY KEY (landlord_id),
    FOREIGN KEY (user_id) REFERENCES User (user_id)
);

CREATE TABLE SavedProperty (
    user_id CHAR(36),

    street VARCHAR(64),
    city VARCHAR(64),
    

    PRIMARY KEY (user_id, street, city),
    FOREIGN KEY (user_id) REFERENCES User (user_id),
    FOREIGN Key (street, city) REFERENCES Property (street, city)
);

/* City of Spokane Tax Info */

CREATE TABLE ParcelData (
    street VARCHAR(50),
    city VARCHAR(50),
   

    pid VARCHAR(50),

    owner_name VARCHAR(100),
    gross_sale_price DECIMAL(9, 2),
    excise_nbr VARCHAR(20),
    transfer_type VARCHAR(50),
    prop_use_desc VARCHAR(30),
    tax_code_area VARCHAR(4),
    acreage DECIMAL(4,2),
    InspectionYear INT,
    row_num INT,

    PRIMARY KEY (street, city, pid)
);

CREATE TABLE ParcelFeature (
    id INT NOT NULL AUTO_INCREMENT, 
    pid VARCHAR(50) NOT NULL,
    feat_code VARCHAR(10),
    feat_desc VARCHAR(50),

    PRIMARY KEY (id)
);

CREATE TABLE ParcelFloor (
    id INT NOT NULL AUTO_INCREMENT, 

    pid VARCHAR(50) NOT NULL,
    bldg_num VARCHAR(3),
    floor VARCHAR(50),
    sq_ft SMALLINT UNSIGNED,
    fin_area SMALLINT UNSIGNED,
    beds TINYINT UNSIGNED,
    baths DECIMAL(3,1) UNSIGNED,

    PRIMARY KEY (id)
);