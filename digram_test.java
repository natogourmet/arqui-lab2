public abstract class Building {
   private int numberOfFloors;
   private int numberOfWindows;
   public int getNumberOfFloors() {
       return numberOfFloors;
   }
   //Getter and Setters for Specs of houses.
   public void setNumberOfFloors(int numberOfFloors) {
       this.numberOfFloors = numberOfFloors;
   }
   public int getNumberOfWindows() {
       return numberOfWindows;
   }
   public void setNumberOfWindows(int numberOfWindows) {
       this.numberOfWindows = numberOfWindows;
   }
   public String toString() {
       String result = "Specifications of the Building";
       return result;
   }
}

public interface CreatePlayer {
    
    public abstract void setName(String name);
    
    public abstract String getName();
    
    public abstract void setNickname(String name);
    
    public abstract String getNickname();

}

public class Garage extends Building {
   private int numberOfCars;
   private String garageConstruction;
   private int length;
   private int width;
   public Garage(int numberOfWindows, int length, int width, int numberOfCars, String floorCovering) {
       super.setNumberOfFloors(1);
       super.setNumberOfWindows(numberOfWindows);
       this.length = length;
       this.width = width;
       this.numberOfCars = numberOfCars;
       this.garageConstruction = floorCovering;
   }
   //getters and setters
   public int getNumberOfCars() {
       return numberOfCars;
   }
   public void setNumberOfCars(int numberOfCars) {
       this.numberOfCars = numberOfCars;
   }
   public String getFloorCovering() {
       return garageConstruction;
   }
   public void setFloorCovering(String garageConstruction) {
       this.garageConstruction = garageConstruction;
   }
   public int getLength() {
       return length;
   }
   public void setLength(int length) {
       this.length = length;
   }
   public int getWidth() {
       return width;
   }
   public void setWidth(int width) {
       this.width = width;
   }
   public String toString() {
       String result = "Specifications of the Garage" + "\n\tLength: " + this.getLength() + "\n\tWidth: " + this.getWidth()
               + "\n\tFloor Covering: " + this.getFloorCovering() + "\n\tNumber of Cars: " + this.getNumberOfCars()
               + "\n";
       return result;
   }
}
import java.util.Scanner;

public class Grades {

    private static Object String;

    public static void main(String[] args) {
        
        Scanner keyboard = new Scanner(System.in);
        int Grades;
        
        char A = 'A';
        char B = 'B';
        char C = 'C';
        char D = 'D';
        char F = 'F';
        String ERROR;
        
        System.out.println("Enter your grade:");
        Scanner reader = new Scanner(System.in);
        Grades = reader.nextInt();
        
        if (Grades >= 90 && Grades <=100)
        {
        System.out.printf("You have earned the letter grade : A" );
        }
        else if (Grades >= 80 && Grades <= 89)
        {
        System.out.printf("You have earned the letter grade: B");
        }
        else if (Grades >=70 && Grades <= 79)
        {
        System.out.printf("You have earned the letter grade: C");
        }
        else if (Grades >= 60 && Grades <= 69)
        {
        System.out.printf("You have earned the letter grade: D");
        }
        else if (Grades >= 0 && Grades <= 59)
        {
        System.out.printf("You have earned the letter grade: F");
        }
        else 
        {
        System.out.println("ERROR You have entered an invalid input");
        }
        
        {
            
        }
    }
}
public class House extends Building implements MLSListable {
   private Room[] rooms;
   private int numberOfBathrooms;
   public House(Room[] rooms, int numberOfBathrooms, int numberOfWindows, int numberOfFloors) {
       super.setNumberOfFloors(numberOfFloors);
       super.setNumberOfWindows(numberOfWindows);
       this.numberOfBathrooms = numberOfBathrooms;
       this.rooms = rooms;
//for-loop returns lenght of rooms
   }
   public String genRoomSpecs() {
       String result = "";
       for (int i = 0; i < rooms.length; i++) {
           result += rooms[i].toString();
       }
       return result;
   }
   //Getters and Setters of Specs. of houses. 
   //Auto generate via Rt. Click + Source + Choose
   //returns array number of rooms/bathrooms/size of each.
   public Room[] getRooms() {
       return rooms;
   }
   public void setRooms(Room[] rooms) {
       this.rooms = rooms;
   }
   public int getNumberOfBathrooms() {
       return numberOfBathrooms;
   }
   public void setNumberOfBathrooms(int numberOfBathrooms) {
       this.numberOfBathrooms = numberOfBathrooms;
   }
   public int getAvgRoomSize() {
       int result;
       int sum = 0;
 //for-loop returns calculated room sizes.
       for (int i = 0; i < this.rooms.length; i++) {
           sum += rooms[i].getLength() * rooms[i].getWidth();
       }
       result = sum / this.rooms.length;
       return result;
   }
   //calculated getters/setters for size of houses
   public String toString() {
       String result = "Specifications of the House" + "\n\tRoom Size: " + this.getAvgRoomSize() + "\n\tBathrooms: "
               + this.getNumberOfBathrooms() + "\n\tFloors: " + this.getNumberOfFloors() + "\n\tWindows: "
               + this.getNumberOfWindows() + "\n\tRooms: " + this.rooms.length + this.genRoomSpecs() + "\n";
       return result;
   }
   public String getMLSListing() {
       return "MLSListing - " + this.toString();
   }
}
//**MLSListable.java: I don't understand the error of the MLSListing**
//**"The public type MLSListable must be defined in its own file"**
//**I tried to difine it in own file but it wont let me run the program-so i left as-is***
public interface MLSListable {
   public String getMLSListing();
}
package com.paycheck;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;


public class Main extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("fxml/sample.fxml")); 
        primaryStage.setTitle("Paycheck");
        primaryStage.setScene(new Scene(root, 300, 300));
        //primaryStage.setResizable(false);
    }


    public static void main(String[] args) {
        launch(args);
    }
}
public class MyProgram {
    
    private String message;
    
    public void setVar(String s) {
        message = s;
    }
    
    public String getVar() {
        return message;
    }

}
import java.util.regex.*;
public class Parsing {

    public static void main(String[] args) {
        String myString = "Mahendra is pretty awesome (523)555-1212";
        String hardString = "Aia Bwh6a Dnk8t Ft2o Hg7o 9tnm Pomi Ab2a 5ren";
        //String myRegex = "[A-Za-z]+\\s";
        String myRegex = "[A-Z][^\\.]|[\\d][^\\.]"; 
        StringBuilder sb = new StringBuilder();
        
        Pattern checkRegex = Pattern.compile(myRegex);
        
        Matcher regexMatcher = checkRegex.matcher(hardString);
        
        while(regexMatcher.find()) {
            //System.out.println("WoHoo I found it");
            //System.out.println(regexMatcher.group().trim());
            //System.out.println(regexMatcher.start());
            //System.out.println(regexMatcher.end());
            sb = sb.append(regexMatcher.group().substring(1));
        }
        System.out.println(sb);
    }
}
import java.util.Scanner;

public class PrintMenu {

    public static void main(String[] args) {
        
        int cheeze = 2;
        int taco = 5;
        int soda = 4;
        int salsa = 20;
        int mayo = 17;
        int butter = 900;
        int count = 0;
        int choice = 0;
        int sum = 0;
        Scanner input = new Scanner(System.in);

        while (choice !=7) {
        
        System.out.println("select a option");
        System.out.println("1) cheeze cost 2 bucks");
        System.out.println("2) taco  cost 5 bucks");
        System.out.println("3) soda cost 4 bucks");
        System.out.println("4) salsa cost 20 bucks");
        System.out.println("5) mayo cost 17 bucks");
        System.out.println("6) butter cost 900 bucks");
        System.out.println("7) exit menu");
    
    choice = input.nextInt();
        
            System.out.println("choose now");
            
            switch(choice){
            
            
            case 1:
                sum += cheeze;
                break;
            case 2:
                sum += salsa;
                break;
            case 3: 
                sum += taco;
                break;
            case 4:
                sum +=soda;
                break;
            case 5:
                sum += mayo;
                break;
            case 6:
                sum += butter;
                break;
            case 7: 
                System.out.printf("ur total is " + sum + " bucks");
                break;
            }
        }
        
    }
}
public class Room implements Comparable<Room> {
    private int length;
    private int width;
    private String floorCovering;
    private int numberOfClosets;

    public Room(int length, int width, String floorCovering, int numberOfClosets) {
        this.length = length;
        this.width = width;
        this.floorCovering = floorCovering;
        this.numberOfClosets = numberOfClosets;
    }

    // getters and setters
    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public String getFloorCovering() {
        return floorCovering;
    }

    public void setFloorCovering(String floorCovering) {
        this.floorCovering = floorCovering;
    }

    public int getNumberOfClosets() {
        return numberOfClosets;
    }

    public void setNumberOfClosets(int numberOfClosets) {
        this.numberOfClosets = numberOfClosets;
    }

    public String toString() {
        String result = "\n\t\tLength: " + this.getLength() + " Width: " + this.getWidth() + " Closets: "
                + this.getNumberOfClosets() + " Floor Covering: " + this.getFloorCovering();
        return result;
    }

    // if-else returns calculations about size of houses on MLSListing
    // not sure if this is where the ' -1 ' comes into play? tried to debug to
    // see.
    // a.compareTo(b) == -b.compareTo(a) must always be true.
    // compareTo must be implemented if you want to sort items.
    // here we are sorting items in an array based on each houses
    // Specifications.
    public int compareTo(Room arg0) {
        if (this.getLength() * this.getWidth() < arg0.getLength() * arg0.getWidth()) {
            return -1;// compareTo if b is bigger then the result is ' -1 '.
            // changing compareTo value doesn't effect code to much it just
            // returns diff values.
            // experimented with return -1, -2, 42
        } else if (this.getLength() * this.getWidth() > arg0.getLength() * arg0.getWidth()) {
            return 1;// if a is bigger then the result is ' +1 '
        } else {
            return 0;// if compareTo is equal return 0
        }
    }

    // compareTo apply here??
    // a.compareTo(b) == -b.compareTo(a) must always be true.
    // compareTo has to return true..
    /*
     * The first Room compared to second Room: 0 The first Room is equal to
     * second Room in size. Third room compared to first Room: 1 The third Room
     * is equal to first Room in size. The third Room compared to second Room:
     * -1
     */
    public boolean equals(Object houseStats) {
        boolean result = false;// expieremt with true/false, return true/false.
                                // didn't see chg in results??
        if (!(houseStats instanceof Room)) {
            return false;
        }
        if (this.getLength() * this.getWidth() == ((Room) houseStats).getLength() * ((Room) houseStats).getWidth()) {
            result = true;
        }
        return result;
    }
}
import java.util.Scanner;

public class Switcharoo {

    public static void main(String[] args) {
        
        int choice = 140;
        int choice1 = -42;
        int choice2 = 85;
        Scanner s =new Scanner(System.in);
        System.out.println("Enter a choice");
        choice = s.nextInt();
        

        switch (choice){
        case 100: 
            System.out.printf("You have earned the letter grade :A");
            break;
        case 85: 
            
            System.out.printf("You have earned the letter grade : B\n end of program");
            break;
        case 70: 
            System.out.printf("You have earned the letter grade : C");
            break;
        case 60:
            System.out.printf("You have earned the letter grade : D");
            break;
        case 280/2: 
            //choice = 140;
        case -84/2:
            //choice = -42;
            System.out.println("ERROR You have entered and invaled grade");
            default:
            System.out.println("end of program");
            break;
            }
    }
}
import java.util.ArrayList;

public class Test {
    public static void main(String[] args) {

        ArrayList<Building> buildingsArray = new ArrayList<Building>();

        Room additionalRoom = new Room(2, 2, "Laminate Wood Flooring", 2);
        Room firstRoom = new Room(2, 3, "Blue Carpet", 1);
        Room secondRoom = new Room(3, 2, "Red Carpet", 1);
        Room thirdRoom = new Room(3, 3, "Green Carpet", 2);
        Room diningRoom = new Room(4, 5, "Hardwood/Bamboo", 3);
        Room livingRoom = new Room(5, 5, "Tile", 4);
//added additional house,garage and roomSet with no stats to experiment what code is doing.
        Room[] roomSet1 = { additionalRoom, firstRoom, secondRoom, thirdRoom };
        Room[] roomSet2 = { diningRoom, livingRoom };
        Room[] roomSet3 = { firstRoom, thirdRoom, secondRoom };
        Room[] roomSet4 = { livingRoom, secondRoom, additionalRoom };
        Room[] roomSet5 = { additionalRoom, diningRoom, livingRoom, thirdRoom };


        House house1 = new House(roomSet1, 2, 2, 3);
        House house2 = new House(roomSet2, 2, 4, 1);
        House house3 = new House(roomSet3, 3, 2, 2);
        House house4 = new House(roomSet4, 4, 4, 3);
        House house5 = new House(roomSet5, 0, 0, 0);

        Garage garage1 = new Garage(700, 500, 500, 102, "Block/Brick-Traditional");
        Garage garage2 = new Garage(1, 1, 1, 3, "Open (No Door attactched)");
        Garage garage3 = new Garage(2, 6, 7, 4, "Breezeway-Open Ended Garage");
        Garage garage4 = new Garage(1, 1, 1, 1, "3 Car Garage");
        Garage garage5 = new Garage(0, 0, 0, 0, "3 Car Garage");

        buildingsArray.add(house1);
        buildingsArray.add(house2);
        buildingsArray.add(house3);
        buildingsArray.add(house4);
        buildingsArray.add(house5);
        buildingsArray.add(garage1);
        buildingsArray.add(garage2);
        buildingsArray.add(garage3);
        buildingsArray.add(garage4);
        buildingsArray.add(garage5);

        for (Building aBuilding : buildingsArray) {
//a.compareTo(b)  ==  -b.compareTo(a)  must always be true.***
//not sure where this comes to play?         
//a-b if a is bigger, the result is positive (+1) else,
//if b is bigger the result is negative, if they're equal its 0.
            /*The first Room compared to second Room: 0
            The first Room is equal to second Room in size.
            Third room compared to first Room: 1
            The third Room is equal to first Room in size.
            The third Room compared to second Room: -1
            */
            if (aBuilding instanceof House) {
                housePassMethod((House) aBuilding);
            } else {
                System.out.println(aBuilding.toString());
            }
        }

        System.out.println("The first Room compared to second Room: " + firstRoom.compareTo(secondRoom));
        if (firstRoom.equals(secondRoom)) {
            System.out.println("The first Room is equal to second Room in size.");
        } else {
            System.out.println("The first Room is not equal to second Room in size.");
        }

        System.out.println("Third room compared to first Room: " + thirdRoom.compareTo(firstRoom));
        if (thirdRoom.equals(firstRoom)) {
            System.out.println("The third Room is equal to first Room in size.");
        } else {
            System.out.println("The third Room is not equal to first Room in size.");
        }
//2 additional if-else statements to compare results. Not sure if successful or not??
        System.out.println("The third Room compared to second Room: " + secondRoom.compareTo(thirdRoom));
        if (thirdRoom.equals(secondRoom)) {
            System.out.println("The second Room is equal to the third Room in size.");
        } else {
            System.out.println("The second Room is not equal to third Room in size.");
        }
        
        System.out.println("The first Room compared to second Room: " + firstRoom.compareTo(additionalRoom));
        if (firstRoom.equals(additionalRoom)) {
            System.out.println("The first Room is equal to the additional Room in size.");
        } else {
            System.out.println("The first Room is not equal to the additional Room in size.");
        }
    }

    public static void housePassMethod(MLSListable house) {

        System.out.println(house.getMLSListing());

    }
}
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.SwingConstants;
import javax.swing.JTextField;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class UserGraphic {

    private JFrame frame;
    private JLabel lblTitleLabel;
    private JTextField inputTextField;
    private JButton btnGetMessage;
    private JLabel lblOutputMessage;
    private MyProgram mp;
    /**
     * Launch the application.
     */
    public static void main(String[] args) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                try {
                    UserGraphic window = new UserGraphic();
                    window.frame.setVisible(true);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * Create the application.
     */
    public UserGraphic() {
        initialize();
    }

    /**
     * Initialize the contents of the frame.
     */
    private void initialize() {
        frame = new JFrame();
        frame.setBounds(100, 100, 450, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().setLayout(null);
        
        mp = new MyProgram();
        
        lblTitleLabel = new JLabel("First Program");
        lblTitleLabel.setHorizontalAlignment(SwingConstants.CENTER);
        lblTitleLabel.setBounds(142, 26, 159, 31);
        frame.getContentPane().add(lblTitleLabel);
        
        inputTextField = new JTextField();
        inputTextField.setBounds(157, 83, 130, 26);
        frame.getContentPane().add(inputTextField);
        inputTextField.setColumns(10);
        
        btnGetMessage = new JButton("Click Me");
        btnGetMessage.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                mp.setVar(getMessage());
                setMessage(mp.getVar());
            }
        });
        btnGetMessage.setToolTipText("Something fun");
        btnGetMessage.setBounds(167, 132, 117, 29);
        frame.getContentPane().add(btnGetMessage);
        
        lblOutputMessage = new JLabel("");
        lblOutputMessage.setBounds(156, 212, 145, 31);
        frame.getContentPane().add(lblOutputMessage);
    }
    
    public String getMessage() {
        return inputTextField.getText();
    }
    
    public void setMessage(String s) {
        lblOutputMessage.setText(s);
    }
    
}