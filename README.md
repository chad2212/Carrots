# Carrots
Final Project for 438 for Spring 2017 by Shungheon Chad Chai, Kristen Koyanagi, and Alan Soetikno

Carrots is an iOS application that is comprised of three key components: a fridge, an expiration tracker, and a recipe book. 

### Fridge
The Fridge stores food items into 4 main categories: Meat, Produce, Dairy, and Other. You can navigate easily to add grocery items which will track the name of the item, the amount, the measurement unit, the location (refrigerator, pantry, or freezer), purchase date, and expiration date. Note: all fields must be filled in order to input the grocery item

### Expiration
The Expiration tab pulls the grocery items that you input in the Fridge tab and orders them by expiration date. If you click on the item, you can check the purchase date as well. 

### Recipe
You can manually insert recipes from online which include instructions for the recipe as well as ingredients. Based on what you have in your fridge, the stored recipes will check what ingredients you currently have and order based on least number of missing ingredients. Recipes will show checkboxes next to the ingredients currently in your possesion and x's for ones you do not have. 

## Feature List:
* Add/delete grocery items into the refrigerator, pantry, or freezer
* Add expiration date and purchase date to grocery items with a UIDatePicker
* Order items based on expiration date
* Add/remove new recipes into your database
* Recipes will look at the ingredients you current have and order based on number of missing ingredients

## Technonologies Used
* XCode
* SQLite3

## Possible Next Steps
* Pulling from a database of recipes using an API
* Conversations of ingredient measurements to accurately compare different measurement types
* Scan receipts or barcodes to input grocery items into storage






