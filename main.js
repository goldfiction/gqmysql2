// Generated by CoffeeScript 1.12.7
(function() {
  var _, connection, createConnection, gqmysql;

  gqmysql = require("gqmysql");

  _ = require("lodash");

  connection = {
    host: "localhost",
    port: 3306,
    user: "root",
    password: "",
    database: "db",
    route: "/api/db"
  };

  createConnection = function(connectionin, cb) {
    return gqmysql.mysqlConnect2(_.defaultsDeep(connectionin, connection), function(e, connectionReturn) {
      connectionReturn.db = connectionin.database;
      return cb(null, connectionReturn);
    });
  };

  this.upsert = function(o, cb) {
    return createConnection(o.connection, function(e, connection) {
      var o2;
      o2 = _.defaults(connection, o);
      return gqmysql.q_update(o2).then(function(o) {
        o.result = JSON.parse(o.result);
        o2.key = {
          id: o.result.insertId
        };
        return gqmysql.q_get(o2).then(function(o) {
          o.result = JSON.parse(o.result);
          cb(null, o);
          return connection.end();
        });
      });
    });
  };

  this.find = function(o, cb) {
    return createConnection(o.connection, function(e, connection) {
      var o2;
      o2 = _.defaults(connection, o);
      return gqmysql.q_get(o2).then(function(o) {
        o.result = JSON.parse(o.result);
        cb(null, o);
        return connection.end();
      });
    });
  };

  this["delete"] = function(o, cb) {
    return createConnection(o.connection, function(e, connection) {
      var o2;
      o2 = _.defaults(connection, o);
      return gqmysql.q_get(o2).then(function(o3) {
        var result1;
        result1 = JSON.parse(o3.result);
        return gqmysql.q_delete(o2).then(function(o) {
          o.result = result1;
          cb(null, o);
          return connection.end();
        });
      });
    });
  };

}).call(this);
