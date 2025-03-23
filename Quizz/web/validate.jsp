<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quiz Result</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f7f7f7;
      margin: 0;
      padding: 0;
    }
    .container {
      max-width: 600px;
      margin: 50px auto;
      background-color: #fff;
      padding: 30px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      border-radius: 8px;
      text-align: center;
    }
    h1 {
      color: #333;
    }
    .result {
      font-size: 18px;
      margin: 20px 0;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Quiz Result</h1>
  <%
      Connection con = null;
      PreparedStatement ps = null;
      ResultSet rs = null;
      int score = 0;
      int total = 0;
      try {
          Class.forName("oracle.jdbc.driver.OracleDriver");
          con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "abhi");
          String sql = "SELECT * FROM questions ORDER BY id";
          ps = con.prepareStatement(sql);
          rs = ps.executeQuery();
          while(rs.next()){
              total++;
              int id = rs.getInt("id");
              String correctAnswer = rs.getString("correctAnswer");
              String userAnswer = request.getParameter("q" + id);
              if(userAnswer != null && userAnswer.equalsIgnoreCase(correctAnswer)){
                  score++;
              }
          }
  %>
  <div class="result">
    You scored <strong><%= score %></strong> out of <strong><%= total %></strong>.
  </div>
  <%
      } catch(Exception e) {
          out.println("Error: " + e.getMessage());
      } finally {
          if(rs != null) try { rs.close(); } catch(Exception e){}
          if(ps != null) try { ps.close(); } catch(Exception e){}
          if(con != null) try { con.close(); } catch(Exception e){}
      }
  %>
</div>
</body>
</html>
