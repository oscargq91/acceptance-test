package karate;

import com.intuit.karate.junit5.Karate;

import static utils.ConstantFeatures.VALIDATE_BUSINESS_RULES;

public class ValidateBusinessRulesRunner {

    @Karate.Test
    Karate product_alias() {
        return Karate.run(VALIDATE_BUSINESS_RULES).relativeTo(getClass());
    }
}
