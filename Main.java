package sqlConverter;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class Main {

	public static void main(String[] args) {
		//System.out.println(getString("actor"));
		//System.out.println(getString("director"));
		//System.out.println(getString("movie"));
		//System.out.println(getString("series"));
		//System.out.println(getString("user"));
		//System.out.println(getString("character"));
		//	System.out.println(getString("moviecomments"));
		//	System.out.println(getString("seriescomments"));
		System.out.println(getString("moviecharacter"));
		//System.out.println(getString("seriescharacter"));
	}
	public static String getString(String fileName) {
		String csvFile = "/Users/Morga/Documents/Github/SQL_Proj08/" + fileName + ".csv";
        BufferedReader br = null;
        String line = "";
        String cvsSplitBy = ",";
        String toWrite = "INSERT INTO " + fileName + 
        		"\nVALUES\n";

        try {
        	
            br = new BufferedReader(new FileReader(csvFile));
            br.readLine(); //get column names out
            
            while ((line = br.readLine()) != null) {
            	
            	line = line.replaceAll("'", "`");
            	line = line.replaceAll("\"", "`");
            	
                // use comma as separator
            	String toWriteLine = "\t(";
                String[] cells = line.split(cvsSplitBy);
                for (String cell:cells) {
	            	if (!(cell.matches("[0-9]+")) && !(cell.matches("NULL"))) {
	            		cell = "'" + cell + "'";
	            	}
	            	toWriteLine += cell + ",";
                }
                toWrite += toWriteLine.substring(0, toWriteLine.length() - 1) + "),\n";
            	
            	//toWrite += "\t(" + line + "),\n";

            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return toWrite.substring(0, toWrite.length() - 2) + ";";
	}
}
