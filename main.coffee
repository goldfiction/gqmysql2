gqmysql=require "gqmysql"
_=require "lodash"

connection=
  host:"localhost"
  port:3306
  user:"root"
  password:""
  database:"db"
  route:"/api/db"

createConnection=(connectionin,cb)->
  gqmysql.mysqlConnect2 _.defaultsDeep(connectionin,connection),(e,connectionReturn)->  # combine incoming connection data (connectionin) with default connection (connection)
    connectionReturn.db=connectionin.database  # make db equal to database
    cb(null,connectionReturn)

@upsert=(o,cb)->
  createConnection o.connection,(e,connection)->
    o2=_.defaults(connection,o)
    gqmysql.q_update(o2).then (o)->
      o.result = JSON.parse(o.result)
      o2.key=
        id:o.result.insertId
      gqmysql.q_get(o2).then (o)->
        o.result=JSON.parse(o.result)
        cb null,o
        connection.end()

@find=(o,cb)->
  createConnection o.connection,(e,connection)->
    o2=_.defaults(connection,o)
    gqmysql.q_get(o2).then (o)->
      o.result=JSON.parse(o.result)
      cb null,o
      connection.end()

@delete=(o,cb)->
  createConnection o.connection,(e,connection)->
    o2=_.defaults(connection,o)
    gqmysql.q_get(o2).then (o3)->
      result1=JSON.parse(o3.result)
      gqmysql.q_delete(o2).then (o)->
        o.result=result1
        cb null,o
        connection.end()