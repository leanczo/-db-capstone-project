### Task 1

CREATE VIEW `OrdersView` AS
SELECT OrderID, Quantity, TotalCost as Cost FROM littlelemondb.orders
where quantity > 2

### Task 2

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

### Task 3

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
);;
