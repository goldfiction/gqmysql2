gqmysql=require "../../gqmysql2"
_=require "lodash"

o=
  connection:
    host:"mysql"
    user:"admin"
    password:"mysql47284728"
    database:"db"
    route:"/api/db"
    table:"test"
  key:
    name:"test700"
  data:
    name:"test700"
    value:"666"
    fasthash:"D"
  limit:10

o2=
  connection:
    host:"mysql"
    user:"admin"
    password:"mysql47284728"
    database:"db"
    route:"/api/db"
    table:"test"
  key:
    name:"test700"
  data:
    name:"test700"
    value:"999"
    fasthash:"D"
  limit:10

it "should be able to require",(done)->
  gqmysql=require "../../gqmysql2"
  console.log "gqmysql2 required successfully"
  done()

it "should be able to create",(done)->
  gqmysql.upsert _.clone(o),(e,o)->
    console.dir o.result
    done e

it "should not be able to create twice, but update",(done)->
  gqmysql.upsert _.clone(o2),(e,o)->
    console.dir o.result
    done e

it "should be able to find",(done)->
  gqmysql.find _.clone(o),(e,o)->
    console.dir o.result
    done e

it "should be able to delete",(done)->
  gqmysql.delete _.clone(o),(e,o)->
    console.dir o.result
    done e

it "should not be able to delete twice",(done)->
  gqmysql.delete _.clone(o),(e,o)->
    console.dir o.result
    done e