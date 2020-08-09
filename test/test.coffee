gqmysql=require "../../gqmysql2"
_=require "lodash"

val1=Math.floor(Math.random()*1000)
val2=val1+100

# make sure you create a db called db
# then create a table called test
# test should have 4 fields:
# 1. id   primary, AI
# 2. name  varchar(256)
# 3. value  varchar(256)
# 4. fasthash  varchar(1)

o=
  connection:
    host:"mysql"
    user:"root"
    password:"78567856"
    database:"db"
    route:"/api/db"
    table:"test"
  key:
    name:"test700"
  data:
    name:"test700"
    value:val1
    fasthash:"D"
  limit:10
  
getVal1=()->
  _.clone o

getVal2=()->
  ret=getVal1()
  ret.data.value=val2
  ret

describe "should be able to ",()->
  after (done)->
    process.exit 0
    done()
  
  it "require",(done)->
    gqmysql=require "../../gqmysql2"
    console.log "gqmysql2 required successfully"
    done()
  
  it "create",(done)->
    gqmysql.upsert getVal1(),(e,o)->
      console.dir o.result
      done e
  
  it "not create twice, but update",(done)->
    gqmysql.upsert getVal2(),(e,o)->
      console.dir o.result
      done e
  
  it "find",(done)->
    gqmysql.find getVal1(),(e,o)->
      console.dir o.result
      done e
  
  it "delete",(done)->
    gqmysql.delete getVal1(),(e,o)->
      console.dir o.result
      done e
  
  it "not delete twice",(done)->
    gqmysql.delete getVal1(),(e,o)->
      console.dir o.result
      done e