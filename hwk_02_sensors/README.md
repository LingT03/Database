# Instructions

Design an E/R Model based on the following data requirements: 

* there are sensors of different types, depending on their application (consumer/home, smart infrastructure, security/surveillance, healthcare, environmental, etc.)
* a sensor can only be of one type
* a sensor is built by a manufacturer 
* a sensor can have the ability to measure one or more things (eg, pressure, temperature, etc.)
* for each thing measured by a sensor, there can be multiple readings

Your E/R model should be able to represent the following entity sets: 

* Sensors
* Types
* Manufacturers
* Measurements
* Readings

There is no need to represent attributes in your entity sets. 

Your solution should represent the following relationships: 

* Sensors and Types
* Sensors and Measurements
* Sensors and Manufacturers
* Measurementes and Readings

# Submission

You should submit a single text file named **sensors.erd** with your design. Use the template shared with you. Make sure to write your name in the comments section. 

# Grading

In this assignment you are expected to represent 4 relationships. Other than making sure that each relationship is connecting the right entity sets, you should verify the cardinality (one or many) of each side of the relationships and whether it is required or not. One point will be deducted every time you make 2 mistakes. 

# Professor Feedback 
a sensor is associated with only 1 type
a type may not be in association with a sensor
a (sensor) measurement is associated with one specific sensor
a reading is associated with one specific (sensor) measurement
total: 3/5

# Fixes
relationship Use {
    Sensors [~~1..1~~ 0..1] -> Types [~~1..N~~ 1..1]] 
}

relationship Possess {
    Sensors [~~1..N~~ 1..1] -> Measurements [1..N]
}

relationship Builds {
    Sensors [0..N] -> Manufacturers [1..1]
}

relationship Records {
    Measurements [~~1..N~~ 1..1] -> Readings [0..N]
}

