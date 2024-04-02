package karate;

import com.intuit.karate.junit5.Karate;

import static utils.ConstantFeatures.USER_MANAGEMENT;

public class UserRunner {

    @Karate.Test
    Karate product_alias() {
        return Karate.run(USER_MANAGEMENT).relativeTo(getClass());
    }
}
