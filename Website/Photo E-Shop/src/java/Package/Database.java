/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Package;
/**
 *
 * @author Stefan
 */
import java.sql.*;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
public class Database 
{

        public Connection myConn;
        Statement myStmt;
        ResultSet myRs;
        //ResultSet test = null;
        
	public Database() throws SQLException 
	{
            //code in classes
	    /*Connect();
            test = GetQuery("select * from \"User\"");
            while (myRs.next()) 
            {
                System.out.println(myRs.getString("UserID") + ", " + myRs.getString("Email"));
            }
            Close();*/
            
	}
        public boolean Connect() throws ClassNotFoundException
        {
            
             Class.forName("oracle.jdbc.driver.OracleDriver");
            
            boolean success = false;
            
            try
            {
                myConn = DriverManager.getConnection("jdbc:oracle:thin:@//fhictora01.fhict.local:1521/fhictora", "dbi310866", "O4g03ym3r8");
            }
            catch(SQLException ex)
            {
                //JOptionPane.showMessageDialog(null, ex.getMessage());
                System.out.println("AA");
            }
            
            if(myConn != null)
            {
                success = true;
            }
            return success;
            //return true;
        }
        // query =  select * from \"User\"
        public ResultSet GetQuery(String query) throws SQLException
        {
            try
            {
                myStmt = myConn.createStatement();
                return myRs = myStmt.executeQuery(query);
                //code om door result set te lopen in bovenliggende klasse
                /*while (myRs.next()) 
                {
                        System.out.println(myRs.getString("UserID") + ", " + myRs.getString("Email"));
                }*/
            }
            catch(SQLException ex)
            {
                throw ex;
            }
            catch(Exception ex)
            {
                throw ex;
            }
            //return null;
        }
        
        // query =  select * from \"User\"
        public ResultSet GetQuery(PreparedStatement query) throws SQLException
        {
            System.out.println("HALP");
            try
            {
                return query.executeQuery();
                //myStmt = myConn.createStatement();
                //return myRs = myStmt.executeQuery(query);
                //code om door result set te lopen in bovenliggende klasse
                /*while (myRs.next()) 
                {
                        System.out.println(myRs.getString("UserID") + ", " + myRs.getString("Email"));
                }*/
            }
            catch(SQLException ex)
            {
                throw ex;
            }
            catch(Exception ex)
            {
                throw ex;
            }
            //return null;
        }
        
        public boolean InsertQuery(String query) throws SQLException
        {
            try
            {
                myStmt = myConn.createStatement();
                myStmt.executeUpdate(query);
                
                return true;
            }
            catch (SQLException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }
        
        public boolean deleteQuery(String query)
        {
            boolean success = false;
            try
            {
                myStmt = myConn.createStatement();
                myStmt.executeUpdate(query);
                
                success = true;
            }
            catch(Exception exception)
            {
                
            }
            
            return success;
        }
        
        public boolean InsertQuery(PreparedStatement query) throws SQLException
        {
            try
            {
                query.executeUpdate();
                /*myStmt = myConn.createStatement();
                myStmt.executeUpdate(query);*/
                
                return true;
            }
            catch (SQLException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public void Close()
        {
            try
            {
                if (myRs != null) 
                {
                    myRs.close();
                }
                if (myStmt != null) 
                {
                    myStmt.close();
                }
                if (myConn != null) 
                {
                    myConn.close();
                }
            }
            catch(SQLException ex)
            {
                JOptionPane.showMessageDialog(new JFrame(), ex.getMessage());
            }
        }
            
}


