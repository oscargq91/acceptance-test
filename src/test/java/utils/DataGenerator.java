package utils;

import com.github.javafaker.Faker;

public class DataGenerator {
    private static final Faker faker = new Faker();

    public static String generateRandomName() {
        return faker.name().fullName();
    }
}
