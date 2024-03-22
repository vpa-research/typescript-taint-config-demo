package typescript.taint.config;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.junit.Before;
import org.junit.Test;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Comparator;
import java.util.Objects;

import static junit.framework.TestCase.assertEquals;
import static junit.framework.TestCase.assertNotNull;

public class TaintTest {

    private static final String TRANSLATOR_ENV = "LIBSL_TRANSLATOR_EXECUTABLE";
    private static final String TARGET_TAINT = "--target=taint-config-json";
    private static final String VERBOSE_OPT = "--verbose";
    private static final String ACTUAL_PATH = "/json/actual";
    private static final String EXPECTED_PATH = "/json/expected";

    @Before
    public void removeFolder() throws IOException {
        Path pathToBeDeleted = Path.of(Path.of(".").toRealPath() + ACTUAL_PATH);
        if (Files.exists(pathToBeDeleted)) {
            Files.walk(pathToBeDeleted)
                    .sorted(Comparator.reverseOrder())
                    .map(Path::toFile)
                    .forEach(File::delete);
        }
    }

    @Test
    public void specsCheckerTest() throws IOException, ParseException, InterruptedException {
        String translatorPath = System.getenv(TRANSLATOR_ENV);
        assertNotNull(translatorPath);
        String projectPath = String.valueOf(Path.of(".").toRealPath());
        String workDir = "--work-dir=" + projectPath + "/spec";
        String outputDir = "--output-dir=" + projectPath + ACTUAL_PATH;
        // Maybe add path param - $Shell ? If user wants to run with another shell
        String[] args = new String[]{translatorPath, TARGET_TAINT, workDir, outputDir, VERBOSE_OPT};
        Process proc = new ProcessBuilder(args).start();
        assertEquals(0, proc.waitFor());
        specsCompare(projectPath);
    }

    private void specsCompare(String projectPath) throws IOException, ParseException {
        String expected_jsons_dir = projectPath + EXPECTED_PATH;
        String actual_jsons_dir = projectPath + ACTUAL_PATH;
        JSONParser parser = new JSONParser();
        File actualDirectory = new File(actual_jsons_dir);
        //List of all files and directories
        for (String cur_json : Objects.requireNonNull(actualDirectory.list())) {
            String path_of_expected_json = expected_jsons_dir + "/" + cur_json;
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
