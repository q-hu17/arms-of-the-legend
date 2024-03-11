DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;

CREATE TABLE customer (
    customerId          INT IDENTITY,
    profession		VARCHAR(40),
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);
CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentName         VARCHAR(60),
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryMonth   INT,
    paymentExpiryYear    INT,
    CVV                  INT,  
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),
    orderDesc           VARCHAR(100),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    userid              VARCHAR(20),
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    productName         VARCHAR(40),
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Weapons');
INSERT INTO category(categoryName) VALUES ('Equipment');
INSERT INTO category(categoryName) VALUES ('Accessories');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('axe', 1, 'Specially designed for combat, suitable for use in one hand or two hands', 200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('dagger', 1, 'Stabbing weapon and has sharp edges and a sharp point at the end',150.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('spear', 1, 'Pole weapon consisting of a wooden shaft with a pointed head',120.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('sword', 1, 'Straight, double-edged weapon with a single-handed, cruciform hilt and a blade length of about 70 to 80 centimetres (28 to 31 in)', 200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('armour', 2, 'Personal body armour made from bronze, iron, or steel plates, culminating in the iconic suit of armour entirely encasing the wearer', 300.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('beartrap', 3, 'A type of foothold trap meant to catch bears', 50.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('belt', 2, 'Made with leather and metal, purse, flint, knife, dagger, whip are attached to the belt with laces', 30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('bow and arrow', 1, 'Ranged weapon system consisting of an elastic launching device (bow) and long-shafted projectiles', 200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('crossbow', 1, 'A bow mounted on an elongated frame with a built-in mechanism that holds the drawn bow string, as well as a trigger mechanism that allows the string to be released', 300.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('hand cannon', 1, 'Consists of a barrel, a handle, and sometimes a socket to insert a wooden stock', 500.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('helmet', 2, 'Combat helmet characterized by the possession of a projecting bar covering the nose and thus protecting the centre of the face', 200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('knuckles', 1, 'Pieces of metal shaped to fit around the knuckles', 150.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('necklace', 3, 'Made with gold, silver and gems', 200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('ring', 3, 'Protect your finger joints and bring you good luck', 300.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('staff', 1, 'Pole weapon with a metal tip, 6 feet long', 100.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('talisman', 3, 'With magical power than can protect and heal you', 500.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('wand', 1, 'Thin, light-weight rod that is held with one hand, and is traditionally made of wood', 100.00);

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 200);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 150);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 120);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 200);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 300);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 200);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 300);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 500);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (11, 1, 5, 200);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (12, 1, 10, 150);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (13, 1, 4, 200);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (14, 1, 2, 300);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (15, 1, 3, 100);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (16, 1, 7, 500);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (17, 1, 1, 100);

INSERT INTO customer (profession, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('warrior', 'Ingvar', 'Ivor', 'i.ivor@gmail.com', '204-111-2222', '103 Dreary Track', 'Iyesgarth', 'IY', 'R3X 45T', 'Canada', 'ingvar', 'test');
INSERT INTO customer (profession, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('witch', 'Earline', 'Eir', 'e.eir@hotmail.ca', '572-342-8911', '222 Moon Route', 'Emall', 'EM', '22222', 'United States', 'earline', 'eir');
INSERT INTO customer (profession, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('archer', 'Seraphina', 'Sacerdos', 'seraphina@charity.org', '333-444-5555', '333 Westval Pathway', 'Spalding', 'SP', '33333', 'United States', 'sera', 'password');
INSERT INTO customer (profession, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('priest', 'Germund', 'Gerverg', 'germund@ger.com', '250-807-2222', '444 Churchriden Walk', 'Garigill', 'GA', 'V1V 2X9', 'Canada', 'germund', 'pw');
INSERT INTO customer (profession, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('paladin','Ailbhe', 'Agelastus', 'ailbhe@uiowa.edu', '555-666-7777', '555 Lumsend Avenue', 'Armskirk', 'AR', '52241', 'United States', 'aib', 'age');

UPDATE Product SET productImageURL = 'img/axe.jpeg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/dagger.jpeg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/spear.jpeg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/sword.jpeg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/armor.jpeg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/beartrap.jpeg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/belt.jpeg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/bow.jpeg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/crossbow.jpeg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/gun.jpeg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/helmet.jpeg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/knuckles.jpeg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/necklace.jpeg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/ring.jpeg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/staff.jpeg' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/talisman.jpeg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/wand.jpeg' WHERE ProductId = 17;

INSERT INTO paymentmethod (paymentName, paymentType, paymentNumber, paymentExpiryMonth, paymentExpiryYear, CVV, customerId) VALUES ('Ingvar Ivor', 'Visa', '1111222233334444', 4, 2024, 111, 1);
INSERT INTO paymentmethod (paymentName, paymentType, paymentNumber, paymentExpiryMonth, paymentExpiryYear, CVV, customerId) VALUES ('Earline Eir', 'Mastercard', '2222333344445555', 5, 2025, 222, 2);
INSERT INTO paymentmethod (paymentName, paymentType, paymentNumber, paymentExpiryMonth, paymentExpiryYear, CVV, customerId) VALUES ('Seraphina Sacerdos', 'American Express', '3333444455556666', 6, 2026, 333, 3);
INSERT INTO paymentmethod (paymentName, paymentType, paymentNumber, paymentExpiryMonth, paymentExpiryYear, CVV, customerId) VALUES ('Germund Gerverg', 'Visa', '4444555566667777', 7, 2027, 444, 4);
INSERT INTO paymentmethod (paymentName, paymentType, paymentNumber, paymentExpiryMonth, paymentExpiryYear, CVV, customerId) VALUES ('Ailbhe Agelastus', 'Mastercard', '5555666677778888', 8, 2028, 555, 5);




