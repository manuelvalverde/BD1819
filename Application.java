import java.util.Scanner;
import java.io.PrintWriter;
import java.io.IOException;


public class Application{
	public static void main(String[] args){
		Scanner reader = new Scanner(System.in);  // Reading from System.in
		System.out.println("Enter the table:");
		String tablename = reader.nextLine();
		System.out.println("Enter the entries i.e entryA,entryB,...:");
		String entries = reader.nextLine();
		System.out.println("Enter the values i.e vA,vB,...:");
		String values = reader.nextLine();
		try{
			PrintWriter writer = new PrintWriter("file.txt", "UTF-8");
			for(int i=0;i<100;i++)
				writer.println("insert into "+tablename+" ("+entries+") values ("+values+i+");");
				writer.close();
		}catch(IOException e){e.printStackTrace();}
	}
}
