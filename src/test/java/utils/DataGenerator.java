package utils;

import com.github.javafaker.Faker;

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

}
