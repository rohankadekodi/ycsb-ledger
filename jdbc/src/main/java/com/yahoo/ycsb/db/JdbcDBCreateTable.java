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
 * Utility class to create the table to be used by the benchmark.
 * 
 * @author sudipto
 */
public final class JdbcDBCreateTable {

  private static void usageMessage() {
    System.out.println("Create Table Client. Options:");
    System.out.println("  -n   name of the table.");
    System.out.println("  -f   number of fields (default 10).");
  }

  private static void createTable(String tablename) throws SQLException {
    String url = "jdbc:sqlite:/mnt/pmem_emul/ycsb?journal_mode=WAL";
    //String url = "jdbc:sqlite:/mnt/pmem_emul/ycsb";
    //int fieldcount = Integer.parseInt(JdbcDBClient.FIELD_COUNT_PROPERTY_DEFAULT);
    int fieldcount = 10;
    
    if (url == null) {
      throw new SQLException("Missing connection information.");
    }

    Connection conn = null;

    conn = DriverManager.getConnection(url);
    Statement stmt = conn.createStatement();

    StringBuilder sql = new StringBuilder("DROP TABLE IF EXISTS ");
    sql.append(tablename);
    sql.append(";");

    stmt.execute(sql.toString());

    sql = new StringBuilder("CREATE TABLE ");
    sql.append(tablename);
    sql.append(" (YCSB_KEY VARCHAR PRIMARY KEY");

    for (int idx = 0; idx < fieldcount; idx++) {
      sql.append(", FIELD");
      sql.append(idx);
      sql.append(" TEXT");
    }

    sql.append(");");

    stmt.execute(sql.toString());

    System.out.println("Table " + tablename + " created..");

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

    String tablename = null;
    int fieldcount = -1;

    // parse arguments
    int argindex = 0;
    while (args[argindex].startsWith("-")) {
      if (args[argindex].compareTo("-n") == 0) {
        argindex++;
        if (argindex >= args.length) {
          usageMessage();
          System.exit(0);
        }
        tablename = args[argindex++];
      } else if (args[argindex].compareTo("-f") == 0) {
        argindex++;
        if (argindex >= args.length) {
          usageMessage();
          System.exit(0);
        }
        try {
          fieldcount = Integer.parseInt(args[argindex++]);
        } catch (NumberFormatException e) {
          System.err.println("Invalid number for field count");
          usageMessage();
          System.exit(1);
        }
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

    if (tablename == null) {
      System.err.println("table name missing.");
      usageMessage();
      System.exit(1);
    }

    if (fieldcount > 0) {
      //fieldcount = Integer.parseInt(JdbcDBClient.FIELD_COUNT_PROPERTY_DEFAULT);
      fieldcount = 10;
    }

    try {
      createTable(tablename);
    } catch (SQLException e) {
      System.err.println("Error in creating table. " + e);
      System.exit(1);
    }
  }

  /**
   * Hidden constructor.
   */
  private JdbcDBCreateTable() {
    super();
  }
}
