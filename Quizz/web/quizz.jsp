<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HTML Quiz</title>
  <style>
    /* Modern, responsive CSS (without Tailwind) */
    body {
      font-family: Arial, sans-serif;
      background-color: #f7f7f7;
      margin: 0;
      padding: 0;
    }
    .container {
      max-width: 800px;
      margin: 50px auto;
      background-color: #fff;
      padding: 30px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      border-radius: 8px;
    }
    h1 {
      text-align: center;
      color: #333;
    }
    ol {
      list-style-type: decimal;
      padding-left: 20px;
    }
    li {
      margin-bottom: 20px;
    }
    input[type="radio"] {
      margin-right: 10px;
    }
    label {
      cursor: pointer;
    }
    .submit-btn {
      display: block;
      width: 100%;
      padding: 15px;
      background-color: #007BFF;
      color: #fff;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
      margin-top: 20px;
    }
    .submit-btn:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>HTML Quiz</h1>
  <form action="validate.jsp" method="post">
    <ol>
    <%
      Connection con = null;
      PreparedStatement ps = null;
      ResultSet rs = null;
      try {
          // Load Oracle JDBC Driver
          Class.forName("oracle.jdbc.driver.OracleDriver");
          // Update the connection string, username, and password as needed
          con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "abhi");
          String sql = "SELECT * FROM questions ORDER BY id";
          ps = con.prepareStatement(sql);
          rs = ps.executeQuery();
          while(rs.next()){
              int id = rs.getInt("id");
              String question = rs.getString("question");
              String optionA = rs.getString("optionA");
              String optionB = rs.getString("optionB");
              String optionC = rs.getString("optionC");
              String optionD = rs.getString("optionD");
    %>
      <li>
        <h3><%= question %></h3>
        <div>
          <input type="radio" name="q<%= id %>" value="A" id="q<%= id %>A">
          <label for="q<%= id %>A">A) <%= optionA %></label><br>
          
          <input type="radio" name="q<%= id %>" value="B" id="q<%= id %>B">
          <label for="q<%= id %>B">B) <%= optionB %></label><br>
          
          <input type="radio" name="q<%= id %>" value="C" id="q<%= id %>C">
          <label for="q<%= id %>C">C) <%= optionC %></label><br>
          
          <input type="radio" name="q<%= id %>" value="D" id="q<%= id %>D">
          <label for="q<%= id %>D">D) <%= optionD %></label>
        </div>
      </li>
    <%
          }
      } catch(Exception e) {
          out.println("Error: " + e.getMessage());
      } finally {
          if(rs != null) try { rs.close(); } catch(Exception e){}
          if(ps != null) try { ps.close(); } catch(Exception e){}
          if(con != null) try { con.close(); } catch(Exception e){}
      }
    %>
    </ol>
    <input type="submit" value="Submit" class="submit-btn">
  </form>
</div>
</body>
</html>
