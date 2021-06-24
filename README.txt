Attached are 3 classes used for making a car rental program.
Rentals of Cars are added to a Driver and a text statement is generated, which has the details of the Rentals, the amount owed, and earned bonus points.

Sample usage:
```
saloon1 = Car.new('Audi A3', Car::SALOON)
suv1 = Car.new('BMW X1', Car::SUV)
driver = Driver.new('Bill Simpson')
driver.add_rental(Rental.new(suv1, 2))  # rent this SUV for 2 days
driver.add_rental(Rental.new(saloon1, 2))
statement = driver.statement
```

Sample output:
```
Car rental record for Bill Simpson
BMW X1,60
Audi A3,20
Amount owed is €80
Earned bonus points: 3
```

1. Improve and simplify the code but don't change the output of the statement.
2. Add a new method (json_statement) to Driver which gives you back the statement in JSON format. You can choose the structure of the JSON.
3. Create a rake task that runs your tests, and add a Gemfile to the project.

Please send your code submission in a zip file. There's no need for git repositories.

We're looking for demonstrated knowledge of:
- Testing
- General good coding practices e.g. separation of concerns, DRY
- Ruby idioms
- Attention to detail

What we don't need
- Rails projects
- Over engineered solutions with service layers and cloud storage
- Scaling concerns