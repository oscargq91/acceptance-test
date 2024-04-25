package utils;

import com.github.javafaker.Faker;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class DataGenerator {
    private static final Faker faker = new Faker();

    public static List<String> generateRandomUser() {
        String username =faker.name().username();
        List<String> names = new ArrayList<String>();
        names.add(username.concat(faker.lorem().characters(2)));
        names.add(username.concat("@gmail.com"));
        names.add(faker.lorem().characters(10));
        return names;
    }
    public static String generateDate() {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime adjustedDateTime = now.minusHours(7);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSSSSS");
        String formattedDateTime = adjustedDateTime.format(formatter);

        return formattedDateTime;
    }




}
