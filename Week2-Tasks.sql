-- Task 1

CREATE VIEW `OrdersView` AS
SELECT OrderID, Quantity, TotalCost as Cost FROM littlelemondb.orders
where quantity > 2

-- Task 2

CREATE TABLE `littlelemondb`.`menuitems` (
  `MenuItemsID` INT NOT NULL AUTO_INCREMENT,
  `CourseName` VARCHAR(45) NULL,
  `StarterName` VARCHAR(45) NULL,
  `DesertName` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuItemsID`));

-- Insertar datos más realistas en la tabla menuitems
INSERT INTO `littlelemondb`.`menuitems` (`CourseName`, `StarterName`, `DesertName`)
VALUES
('Grilled Chicken', 'Caesar Salad', 'Cheesecake'),
('Beef Steak', 'Tomato Soup', 'Chocolate Mousse'),
('Vegetarian Pizza', 'Garlic Bread', 'Fruit Salad'),
('Spaghetti Carbonara', 'Bruschetta', 'Tiramisu'),
('Fish and Chips', 'Coleslaw', 'Apple Pie'),
('Sushi Platter', 'Miso Soup', 'Green Tea Ice Cream'),
('BBQ Ribs', 'Cornbread', 'Peach Cobbler'),
('Chicken Curry', 'Samosas', 'Gulab Jamun'),
('Lobster Tail', 'Oysters', 'Key Lime Pie'),
('Vegan Burger', 'Sweet Potato Fries', 'Vegan Brownie');

UPDATE `littlelemondb`.`menus` SET `MenuItemsID` = '1' WHERE (`MenuID` = '1');
UPDATE `littlelemondb`.`menus` SET `MenuItemsID` = '2' WHERE (`MenuID` = '2');
UPDATE `littlelemondb`.`menus` SET `MenuItemsID` = '3' WHERE (`MenuID` = '3');
UPDATE `littlelemondb`.`menus` SET `MenuItemsID` = '4' WHERE (`MenuID` = '4');
UPDATE `littlelemondb`.`menus` SET `MenuItemsID` = '5' WHERE (`MenuID` = '5');
UPDATE `littlelemondb`.`menus` SET `MenuItemsID` = '6' WHERE (`MenuID` = '6');
UPDATE `littlelemondb`.`menus` SET `MenuItemsID` = '7' WHERE (`MenuID` = '7');
UPDATE `littlelemondb`.`menus` SET `MenuItemsID` = '8' WHERE (`MenuID` = '8');
UPDATE `littlelemondb`.`menus` SET `MenuItemsID` = '9' WHERE (`MenuID` = '9');
UPDATE `littlelemondb`.`menus` SET `MenuItemsID` = '10' WHERE (`MenuID` = '10');

ALTER TABLE `littlelemondb`.`menus` 
ADD CONSTRAINT `menus_items_menu_fk`
  FOREIGN KEY (`MenuItemsID`)
  REFERENCES `littlelemondb`.`menuitems` (`MenuItemsID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

----
SELECT cd.CustomerID, cd.Name as FullName, o.OrderID, o.TotalCost as Cost, m.Name as MenuName, mi.CourseName
FROM littlelemondb.customerdetails as cd
INNER JOIN littlelemondb.orders as o on o.CustomerID = cd.CustomerID
INNER JOIN littlelemondb.menus as m on o.MenuItemID = m.MenuItemsID
INNER JOIN littlelemondb.menuitems as mi on m.MenuItemsID = mi.MenuItemsID
ORDER BY o.TotalCost ASC

USE `littlelemondb`;
CREATE  OR REPLACE VIEW `ordersview2` AS
SELECT cd.CustomerID, cd.Name as FullName, o.OrderID, o.TotalCost as Cost, m.Name as MenuName, mi.CourseName
FROM littlelemondb.customerdetails as cd
INNER JOIN littlelemondb.orders as o on o.CustomerID = cd.CustomerID
INNER JOIN littlelemondb.menus as m on o.MenuItemID = m.MenuItemsID
INNER JOIN littlelemondb.menuitems as mi on m.MenuItemsID = mi.MenuItemsID
ORDER BY o.TotalCost ASC;

-- Task 3

SELECT m.Name AS MenuName
FROM littlelemondb.menus as m
WHERE m.MenuItemsID = ANY (
    SELECT o.MenuItemID
    FROM littlelemondb.orders as o
    GROUP BY o.MenuItemID
    HAVING SUM(o.Quantity) > 2
);

USE `littlelemondb`;
CREATE  OR REPLACE VIEW `ordersview3` AS
SELECT m.Name AS MenuName
FROM littlelemondb.menus as m
WHERE m.MenuItemsID = ANY (
    SELECT o.MenuItemID
    FROM littlelemondb.orders as o
    GROUP BY o.MenuItemID
    HAVING SUM(o.Quantity) > 2
);

ALTER TABLE `littlelemondb`.`customerdetails` 
ADD COLUMN `ContactNumber` VARCHAR(45) NOT NULL AFTER `ContactDetail`,
ADD COLUMN `Email` VARCHAR(45) NOT NULL AFTER `ContactNumber`;


-- Update customers table
UPDATE `littlelemondb`.`customerdetails` 
SET `ContactNumber` = CASE `CustomerID`
    WHEN 1 THEN '555-1234'
    WHEN 2 THEN '555-2345'
    WHEN 3 THEN '555-3456'
    WHEN 4 THEN '555-4567'
    WHEN 5 THEN '555-5678'
    WHEN 6 THEN '555-6789'
    WHEN 7 THEN '555-7890'
    WHEN 8 THEN '555-8901'
    WHEN 9 THEN '555-9012'
    WHEN 10 THEN '555-0123'
    ELSE '555-1111'
END,
`Email` = CASE `CustomerID`
    WHEN 1 THEN 'customer1@email.com'
    WHEN 2 THEN 'customer2@email.com'
    WHEN 3 THEN 'customer3@email.com'
    WHEN 4 THEN 'customer4@email.com'
    WHEN 5 THEN 'customer5@email.com'
    WHEN 6 THEN 'customer6@email.com'
    WHEN 7 THEN 'customer7@email.com'
    WHEN 8 THEN 'customer8@email.com'
    WHEN 9 THEN 'customer9@email.com'
    WHEN 10 THEN 'customer10@email.com'
    ELSE 'unknown@email.com'
END;
ALTER TABLE `littlelemondb`.`customerdetails` 
DROP COLUMN `ContactDetail`;


-- Exercise: Create optimized queries to manage and analyze data
-- Task 1

DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
  DECLARE maxQty INT;

  SELECT MAX(Quantity) INTO maxQty FROM `LittleLemonDB`.`Orders`;

  SELECT maxQty AS 'Maximum Ordered Quantity';
END;
//
DELIMITER ;

CALL GetMaxQuantity();

-- Task 2

PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM LittleLemonDB.Orders WHERE CustomerID = ?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;
DEALLOCATE PREPARE GetOrderDetail;

