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

		try{
		PrintWriter writer = new PrintWriter("file.txt", "UTF-8");
		for(int i=0;i<100;i++){
			String myName = values;
			for(int j=0;j<myName.length();j++){
				if(myName.charAt(j)=='{'){
					int r= (int)(Math.random() *10) +0;
					myName=myName.substring(0,j)+String.valueOf(r)+myName.substring(j+1);
				}
				else if(myName.charAt(j)=='?'){
					myName=myName.substring(0,j)+String.valueOf(i)+myName.substring(j+1);

				}
				else if(myName.charAt(j)=='}'){
					int r= (int)(Math.random() *6) +0;
					myName=myName.substring(0,j)+String.valueOf(r)+myName.substring(j+1);
				}
				else if(myName.charAt(j)=='<'){
					int r= (int)(Math.random() *4) +6;
					myName=myName.substring(0,j)+String.valueOf(r)+myName.substring(j+1);
				}
				else if(myName.charAt(j)=='>'){
					int r= (int)(Math.random() *2) +0;
					myName=myName.substring(0,j)+String.valueOf(r)+myName.substring(j+1);
				}

			}
			if(entries.equals(""))
					writer.println("insert into "+tablename+" values ("+myName+");");
			else
			writer.println("insert into "+tablename+" ("+entries+") values ("+myName+");");
		}
		writer.close();
		}catch(IOException e){e.printStackTrace();}
	}
}
