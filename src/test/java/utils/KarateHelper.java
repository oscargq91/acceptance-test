package utils;

import java.util.List;

public class KarateHelper {
    public static List<String> generateRandomUser() {
        return DataGenerator.generateRandomUser();
    }
    public static String generateDate(){
        return DataGenerator.generateDate();
    }
}
