users
id name userName deviceToken image createdAt 

carTypes
id name image price sets createdAt 

drivers
id userId lat lng  carId zoneId passport drivingLicense carImage carModleId carMakeYear status(int) createdAt

Areas 
id name status createdAt

zones
id name polygon status createdAt

Trips
id startPoint endPoint startAddress endAdress userId driverId price carId OTP status payment createdAt
