package typescript.taint.config;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.junit.Test;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Path;
import java.util.Objects;

import static junit.framework.TestCase.assertEquals;
import static junit.framework.TestCase.assertNotNull;

public class TaintTest {

    private static final String TRANSLATOR_ENV = "LIBSL_TRANSLATOR_EXECUTABLE";
    private static final String TARGET_TAINT = "--target=taint-config-json";
    private static final String VERBOSE_OPT = "--verbose";

    @Test
    public void specsCheckerTest() throws IOException, ParseException {
        String translatorPath = System.getenv(TRANSLATOR_ENV);
        assertNotNull(translatorPath);
        String projectPath = String.valueOf(Path.of(".").toRealPath());
        String workDir = "--work-dir=" + projectPath + "/spec";
        String outputDir = "--output-dir=" + projectPath + "/result";
        // Maybe add path to command line ?  "/opt/homebrew/bin/bash"
        String[] args = new String[]{"/opt/homebrew/bin/bash", translatorPath, TARGET_TAINT, workDir, outputDir, VERBOSE_OPT};
        Process proc = new ProcessBuilder(args).start();
        specsCompare(projectPath);
    }

    private void specsCompare(String projectPath) throws IOException, ParseException {
        String expected_jsons_dir = projectPath + "/json/expected";
        String actual_jsons_dir = projectPath + "/result";
        JSONParser parser = new JSONParser();
        File actualDirectory = new File(actual_jsons_dir);
        //List of all files and directories
        for (String cur_json : Objects.requireNonNull(actualDirectory.list())) {
            String path_of_expected_json = expected_jsons_dir + "/" + cur_json.replace(".json", " [expected].json");
            String path_of_actual_json = actual_jsons_dir + "/" + cur_json;

            try (InputStreamReader actual_reader = new FileReader(path_of_actual_json);
                 InputStreamReader expected_reader = new FileReader(path_of_expected_json)) {
                Object actual_file = parser.parse(actual_reader);
                Object expected_file = parser.parse(expected_reader);
                JSONArray actual_json = (JSONArray) actual_file;
                JSONArray expected_json = (JSONArray) expected_file;
                assertEquals(expected_json.toJSONString(), actual_json.toJSONString());
            }
        }
    }
}
