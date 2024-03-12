# README

##### Prerequisites

The setups steps expect following tools installed on the system.

- Ruby 3.2.1
- Rails 7.0.8
- Redis
- Posgresql
- Git

##### 1. Navigate to the repository

```bash
cd data-importer
```

##### 2. Setup the application 

The following command will setup the database:

```bash
bin/setup
```

##### 3. Start the API application

This will start the crontab importer, start the redis server, sidekiq and rails server with URL http://localhost:3000

```bash
bin/dev
```

##### 4. Testing  
The code is covered with RSpec tests that can be executed with:
```bash
rspec spec/
```

##### 5. Start application   

The imported employees will be shown on the http://localhost:3000 root path
