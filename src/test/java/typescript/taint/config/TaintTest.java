package typescript.taint.config;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.junit.Before;
import org.junit.Test;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Comparator;
import java.util.Objects;

import static junit.framework.TestCase.assertEquals;
import static junit.framework.TestCase.assertNotNull;

public class TaintTest {

    private static final String ENV_TRANSLATOR_EXE = "LIBSL_TRANSLATOR_EXECUTABLE";
    private static final String ARG_TARGET = "--target=taint-config-json";
    private static final String ARG_VERBOSE = "--verbose";

    private static final Path PATH_SPEC_ROOT = Path.of("spec");
    private static final Path PATH_OUTPUT_ROOT = Path.of("json");
    private static final Path PATH_ACTUAL = PATH_OUTPUT_ROOT.resolve("actual");
    private static final Path PATH_EXPECTED = PATH_OUTPUT_ROOT.resolve("expected");

    @Before
    public void removeFolder() throws IOException {
        final var pathToBeDeleted = Path.of(".").toRealPath().resolve(PATH_ACTUAL);

        if (Files.exists(pathToBeDeleted)) {
            Files.walk(pathToBeDeleted)
                    .sorted(Comparator.reverseOrder())
                    .map(Path::toFile)
                    .forEach(File::delete);
        }
    }

    @Test
    public void specsCheckerTest() throws IOException, ParseException, InterruptedException {
        final var translatorPath = System.getenv(ENV_TRANSLATOR_EXE);
        assertNotNull(translatorPath);

        final var cwd = Path.of(".").toRealPath();
        final var argWorkDir = "--work-dir=" + cwd.resolve(PATH_SPEC_ROOT);
        final var argOutputDir = "--output-dir=" + cwd.resolve(PATH_ACTUAL);

        // Maybe add path param - $Shell ? If user wants to run with another shell
        final var proc = new ProcessBuilder(new String[]{
                translatorPath,
                ARG_TARGET,
                argWorkDir,
                argOutputDir,
                ARG_VERBOSE
        })
                .inheritIO()
                .start();

        assertEquals(0, proc.waitFor());
        specsCompare(cwd);
    }

    private void specsCompare(Path projectPath) throws IOException, ParseException {
        final var expected_jsons_dir = projectPath.resolve(PATH_EXPECTED);
        final var actual_jsons_dir = projectPath.resolve(PATH_ACTUAL);

        final var parser = new JSONParser();

        //List of all files and directories (name only)
        for (var cur_json : Objects.requireNonNull(actual_jsons_dir.toFile().list())) {
            final var path_of_expected_json = expected_jsons_dir.resolve(cur_json);
            final var path_of_actual_json = actual_jsons_dir.resolve(cur_json);

            try (final var actual_reader = new FileReader(path_of_actual_json.toFile());
                 final var expected_reader = new FileReader(path_of_expected_json.toFile())) {
                final var actual_file = parser.parse(actual_reader);
                final var expected_file = parser.parse(expected_reader);

                final var actual_json = (JSONArray) actual_file;
                final var expected_json = (JSONArray) expected_file;

                assertEquals(expected_json.toJSONString(), actual_json.toJSONString());
            }
        }
    }
}
