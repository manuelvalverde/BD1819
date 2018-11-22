import java.util.Scanner;
import java.io.PrintWriter;
import java.io.IOException;
import java.util.Random;


public class Application{
	public static void main(String[] args){
		final int RADIX = 10;
		Scanner reader = new Scanner(System.in);  // Reading from System.in
		System.out.println("Enter the table:");
		String tablename = reader.nextLine();
		System.out.println("Enter the entries i.e entryA,entryB,...:");
		String entries = reader.nextLine();
		System.out.println("Enter the values i.e vA,vB,...:");
		String values = reader.nextLine();
		char[] chars = values.toCharArray();     
		for(int j=0;j<values.length();j++){
			if(chars[j]=='?'){
				int r= (int)(Math.random() *10) +0;
				chars[j]=Character.forDigit(r,RADIX);
			} 
		}
		values=String.valueOf(chars);
		try{
			PrintWriter writer = new PrintWriter("file.txt", "UTF-8");
			for(int i=0;i<100;i++)
				writer.println("insert into "+tablename+" ("+entries+") values ("+values+");");
				writer.close();
		}catch(IOException e){e.printStackTrace();}
	}
}
