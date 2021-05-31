import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Logger;

public class BankApp {
    private Logger log;
    public BankApp(){
        this.log=Logger.getLogger("log4jLog");
    }
    public Connection getConnection() throws SQLException {
        Connection conn=null;
        Properties connProperties = new Properties();
        connProperties.put("user","appuser");
        connProperties.put("password","qazwsx");
        try {
            conn= DriverManager.getConnection("jdbc:postgresql://localhost/bank_app", connProperties);
        }catch (SQLException e){
            log.info("Error occurred while database connection");
            throw e;
        }
        log.info("Success connection to Database");
        return conn;
    }

    public static void main(String[]args) throws SQLException,ClassNotFoundException{
        BankApp bankApp=new BankApp();
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            bankApp.log.info("Can't load driver");
            throw e;
        }

        bankApp.getConnection();
    }
}
