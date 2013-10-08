**ruby-2.0.0-p247**


**Rails 4.0.0**


demo: 

http://domain-check.herokuapp.com/api/v1/whois/news.sina.com.cn

http://domain-check.herokuapp.com/api/v1/whois/strikingly.com

http://domain-check.herokuapp.com/api/v1/whois/www.strikingly.com

http://domain-check.herokuapp.com/api/v1/host/strikingly.com

http://domain-check.herokuapp.com/api/v1/host/www.strikingly.com

####Notes on "whois":

I assume that domain like 'news.sina.com.cn' is a valid **whois** query as documented in google doc. (it's not a valid query in command line **whois**)


###REST API v1 Resources


| Resource       | Description | Success | Fail |
| ------------- |:-------------:| -------:|:-----|
| GET /api/v1/whois/:id      | :id is domain name like "strikingly.com"| {'response': {xxx}}| status: 404 {'error': xxx}|
| GET /api/v1/host/:id       | :id is domain name like "strikingly.com" | {'response': {xxx}} | status: 404 {'error': xxx}|



####app specific files:

app/controller/api/v1/host_controller.rb

app/controller/api/v1/whois_controller.rb

app/models/host_service.rb

app/models/whois_service.rb

app/modles/domain.rb

spec/*

####Run test

`rspec`