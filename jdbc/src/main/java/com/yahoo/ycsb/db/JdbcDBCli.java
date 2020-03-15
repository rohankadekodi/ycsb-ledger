/**
 * Copyright (c) 2010 - 2016 Yahoo! Inc. All rights reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you 
 * may not use this file except in compliance with the License. You
 * may obtain a copy of the License at 
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, 
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
 * implied. See the License for the specific language governing
 * permissions and limitations under the License. See accompanying 
 * LICENSE file. 
 */
package com.yahoo.ycsb.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Execute a JDBC command line.
 * 
 * @author sudipto
 */
public final class JdbcDBCli {

  private static void usageMessage() {
    System.out.println("JdbcCli. Options:");
    System.out.println("  -c   SQL command to execute.");
  }

  private static void executeCommand(String sql) throws SQLException {
    String url = JdbcDBClient.CONNECTION_URL;
    if (url == null) {
      throw new SQLException("Missing connection information.");
    }

    Connection conn = null;

    conn = DriverManager.getConnection(url);
    Statement stmt = conn.createStatement();
    stmt.execute(sql);
    System.out.println("Command  \"" + sql + "\" successfully executed.");

    if (conn != null) {
      System.out.println("Closing database connection.");
      conn.close();
    }
  }

  /**
   * @param args
   */
  public static void main(String[] args) {

    if (args.length == 0) {
      usageMessage();
      System.exit(0);
    }

    String sql = null;

    // parse arguments
    int argindex = 0;
    while (args[argindex].startsWith("-")) {
      if (args[argindex].compareTo("-c") == 0) {
        argindex++;
        if (argindex >= args.length) {
          usageMessage();
          System.exit(0);
        }
        sql = args[argindex++];
      } else {
        System.out.println("Unknown option " + args[argindex]);
        usageMessage();
        System.exit(0);
      }

      if (argindex >= args.length) {
        break;
      }
    }

    if (argindex != args.length) {
      usageMessage();
      System.exit(0);
    }

    if (sql == null) {
      System.err.println("Missing command.");
      usageMessage();
      System.exit(1);
    }

    try {
      executeCommand(sql);
    } catch (SQLException e) {
      System.err.println("Error in executing command. " + e);
      System.exit(1);
    }
  }

  /**
   * Hidden constructor.
   */
  private JdbcDBCli() {
    super();
  }
}
