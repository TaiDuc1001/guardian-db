# Database Initialization Scripts for Guardian.com.vn

This repository contains SQL scripts for initializing and populating the database for the Guardian project, an e-commerce platform for Vietnamese users.

## Files

- [define-tables.sql](define-tables.sql): This script defines the database schema, including tables and their relationships. It includes primary keys, foreign keys, and constraints to ensure data integrity. For example, it defines the `ProductOrder` table with constraints like `FK_ProductID6` and `FK_UserID6` to establish relationships with the `Product` and `User_` tables.

- [define-triggers.sql](define-triggers.sql): This script creates triggers to automate certain actions in the database. For example, the `UpdateProductInventory` trigger updates the stock quantity in the `Product` table after an order is inserted into the `ProductOrder` table. Another trigger, `CalculateDiscountedAmount`, calculates the discounted amount and final price for orders based on the associated voucher and product prices.

- [guardian-insert.sql](guardian-insert.sql): This script populates the database with initial data for various tables, including `Image_`, `Brand`, `Category`, `Product`, `Address_`, `User_`, `Event_`, `Voucher`, `Order_`, `ProductOrder`, `Review`, `UserVoucher`, `OrderStatus`, `EventProduct`, `VoucherProduct`, `PaymentTerm`, `Invoice`, `Cart`, `UserBagProducts`, and `LikedProducts`. It includes sample data for testing and development purposes.

[Relational Model](https://docs.google.com/document/d/1C92fLqebUtvI8mGA9hoGQQMfiqWUS9ViZ42HGEA05ks/edit?usp=sharing): This file contains the schema of the database structure reduced to NF3 for construction and education on the database

[Relational Table](https://docs.google.com/document/d/1gvgniLRUDQszzrov2mjDCtBJdPWaan30fykE7kwzM3o/edit?tab=t.0): This file is the backbone of our project, being the resource for the creation of every other file in this repository. It illustrates the schema, structure, triggers and more about the architecture of this model.

## Project Overview

The Guardian project aims to design and implement the database system for Guardian.com.vn, an e-commerce platform catering to Vietnamese users. The database schema includes tables for products, users, orders, reviews, vouchers, events, and more, ensuring a comprehensive and scalable system to support the platform's operations.

## License

This project is licensed under the MIT License.
