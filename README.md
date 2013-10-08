demo: 

http://domain-check.herokuapp.com/api/v1/whois/google.com


###REST API v1 Resources


| Resource       | Description |
| ------------- |:-------------:| 
| GET /api/v1/whois/:id      | :id is domain name like "strikingly.com" |
| GET /api/v1/host/:id       | :id is domain name like "strikingly.com" |



####app specific files:

app/controller/api/v1/host_controller.rb

app/controller/api/v1/whois_controller.rb

app/models/host_service.rb

app/models/whois_service.rb

spec/*