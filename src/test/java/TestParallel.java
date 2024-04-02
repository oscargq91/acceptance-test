import utils.ConstantManagement;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestParallel {

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath),
                new String[]{ConstantManagement.JSON}, ConstantManagement.TRUE);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File(ConstantManagement.BUILD), ConstantManagement.PROJECT_NAME);
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

    @Test
    void testAll() {
        Results results = Runner.path(ConstantManagement.CLASS_PATH_KARATE).outputCucumberJson(ConstantManagement.TRUE)
                .tags(ConstantManagement.IGNORE).parallel(ConstantManagement.ONE);
        generateReport(results.getReportDir());
        assertEquals(ConstantManagement.ZERO, results.getFailCount(), results.getErrorMessages());
    }
}