
// These import statements give you access to all of JUnit's features.
import static org.junit.Assert.*;
import org.junit.*;
import java.util.*;

/**
 * JUnit test class for Assignment3.
 */
public class Assignment3Test {

    @Before
    public void setUp() {
        // Ensure consistent decimal formatting across different systems (e.g., uses '.'
        // not ',')
        Locale.setDefault(Locale.US);
    }

    /*
     * Test: Checks if the help message is correctly returned when the -h flag is
     * used.
     * Path Covered: compute() -> getHelpText()
     * Result: pass
     */
    @Test
    public void testCompute_HelpFlag() {
        String[] args = { "-h" };
        String expectedOutput = "java Assignment3\n" +
                "    Arguments\n" +
                "        -ln, --list-of-numbers\n" +
                "            List of numbers to compute statistics with\n\n" +
                "        -sm, --statistics-mode\n" +
                "            Statistics to apply to the list of numbers. Options are:\n" +
                "            1. Calculate Mean\n" +
                "            2. Calculate Median\n" +
                "            3. Calculate Mode\n" +
                "            4. Calculate Standard Deviation\n" +
                "            5. Print All Computed Averages\n" +
                "            6. Quit\n\n" +
                "        -h, --help\n" +
                "            Prints this message\n\n" +
                "        -im, --interactive-mode\n" +
                "            Triggers the interactive mode from Assignment 2\n";
        String actualOutput = Assignment3.compute(args);
        assertEquals(expectedOutput.trim(), actualOutput.trim());
    }

    /*
     * Test: Checks a standard mean calculation.
     * Path Covered: compute() -> getMeanValue()
     * Result: pass
     */
    @Test
    public void testCompute_MeanCalculation() {
        String[] args = { "-ln", "10 20 30", "-sm", "1" };
        assertEquals("The Mean is: 20.0", Assignment3.compute(args));
    }

    /*
     * Test: Checks the median calculation for a list with an odd number of
     * elements.
     * Path Covered: compute() -> getMedianValue()
     * Result: pass
     */
    @Test
    public void testCompute_MedianOdd() {
        String[] args = { "-ln", "1 5 2 8 7", "-sm", "2" };
        assertEquals("The Median is: 5.0", Assignment3.compute(args));
    }

    /*
     * Test: Checks the median for an even-sized list, which specifically tests the
     * medianGetMidValue helper method.
     * Path Covered: compute() -> getMedianValue() -> medianGetMidValue()
     * Result: pass
     */
    @Test
    public void testCompute_MedianEven() {
        String[] args = { "-ln", "1 6 2 8", "-sm", "2" };
        assertEquals("The Median is: 4.0", Assignment3.compute(args));
    }

    /*
     * Test: Checks the mode calculation, which covers all three mode-related helper
     * methods.
     * Path Covered: compute() -> getModeList() -> makeUniform(), modePopulateMap(),
     * modeGetOrderedMode()
     * Result: pass
     */
    @Test
    public void testCompute_ModeCalculation() {
        String[] args = { "-ln", "1 2 2 3 3 3 4", "-sm", "3" };
        assertEquals("The Mode is: 3.0", Assignment3.compute(args));
    }

    /*
     * Test: Checks the new standard deviation calculation.
     * Path Covered: compute() -> getStandardDeviation() -> getMeanValue()
     * Result: pass
     */
    @Test
    public void testCompute_StdDevCalculation() {
        String[] args = { "-ln", "1 2 3", "-sm", "4" };
        assertEquals("The Standard Deviation is: 0.8", Assignment3.compute(args));
    }

    /*
     * Test: Checks the "Print All" option, ensuring all calculation methods are
     * called.
     * Path Covered: compute() -> getMeanValue(), getMedianValue(), getModeList(),
     * getStandardDeviation()
     * Result: pass
     */
    @Test
    public void testCompute_PrintAll() {
        String[] args = { "-ln", "1 2 3", "-sm", "5" };
        String expectedOutput = "The Mean is: 2.0\n" +
                "The Median is: 2.0\n" +
                "The Mode is: 1.0 2.0 3.0\n" +
                "The Standard Deviation is: 0.8";
        assertEquals(expectedOutput, Assignment3.compute(args));
    }

    /*
     * Test: Checks the quit message for mode 6.
     * Path Covered: compute()
     * Result: pass
     */
    @Test
    public void testCompute_QuitMessage() {
        String[] args = { "-ln", "1 2 3", "-sm", "6" };
        assertEquals("The response is: Good Bye :)", Assignment3.compute(args));
    }

    /*
     * Test: Checks the error message for an invalid, non-numeric statistics mode.
     * Path Covered: compute()
     * Result: pass
     */
    @Test
    public void testCompute_InvalidModeString() {
        String[] args = { "-ln", "1 2 3", "-sm", "abc" };
        assertEquals("The response is: Invalid option", Assignment3.compute(args));
    }

    /*
     * Test (Edge Case): Checks calculations with a single number input.
     * Path Covered: compute() -> getMeanValue(), getMedianValue(), getModeList(),
     * getStandardDeviation()
     * Result: pass
     */
    @Test
    public void testCompute_SingleNumberInput() {
        String[] args = { "-ln", "42", "-sm", "5" }; // Use "Print All"
        String expectedOutput = "The Mean is: 42.0\n" +
                "The Median is: 42.0\n" +
                "The Mode is: 42.0\n" +
                "The Standard Deviation is: 0.0";
        assertEquals(expectedOutput, Assignment3.compute(args));
    }

    /*
     * Test (Edge Case): Checks behavior with an empty input string.
     * Path Covered: compute() -> sanitize()
     * Result: pass
     */
    @Test
    public void testCompute_EmptyInput() {
        String[] args = { "-ln", "", "-sm", "1" };
        assertEquals("Missing arguments", Assignment3.compute(args));
    }

    /*
     * Test (Edge Case): Checks behavior with purely non-numeric input.
     * Path Covered: compute() -> sanitize()
     * Result: pass
     */
    @Test
    public void testCompute_NonNumericInput() {
        String[] args = { "-ln", "a b c", "-sm", "1" };
        assertEquals("Missing arguments", Assignment3.compute(args));
    }

    /*
     * Test (Edge Case): Checks behavior when a flag is provided with no value.
     * Path Covered: compute() -> getHelpText()
     * Result: pass
     */
    @Test
    public void testCompute_FlagWithNoValue() {
        String[] args = { "-ln", "1 2 3", "-sm" };
        assertTrue(Assignment3.compute(args).contains("java Assignment3"));
    }

    /*
     * Test (Edge Case): Checks if long-form flags work correctly.
     * Path Covered: compute() -> getMeanValue()
     * Result: pass
     */
    @Test
    public void testCompute_LongFormFlags() {
        String[] args = { "--list-of-numbers", "10 20 30", "--statistics-mode", "1" };
        assertEquals("The Mean is: 20.0", Assignment3.compute(args));
    }

    /*
     * Test (Edge Case): Checks calculations with all negative numbers.
     * Path Covered: compute() -> getMeanValue(), getMedianValue(), getModeList(),
     * getStandardDeviation()
     * Result: pass
     */
    @Test
    public void testCompute_NegativeNumbers() {
        String[] args = { "-ln", "-10 -20 -30", "-sm", "5" };
        String expectedOutput = "The Mean is: -20.0\n" +
                "The Median is: -20.0\n" +
                "The Mode is: -30.0 -20.0 -10.0\n" +
                "The Standard Deviation is: 8.2";
        assertEquals(expectedOutput, Assignment3.compute(args));
    }

    /*
     * Test: Checks median calculation with semicolon delimiters.
     * Path Covered: compute() -> sanitize() -> getMedianValue()
     * Result: pass
     */
    @Test
    public void testCompute_MedianWithSemicolons() {
        String[] args = { "-ln", "3;4;5", "-sm", "2" };
        assertEquals("The Median is: 4.0", Assignment3.compute(args));
    }

    /*
     * Test (Edge Case): Checks a malformed command where the '-sm' flag is missing.
     * Path Covered: compute() -> getHelpText()
     * Result: pass
     */
    @Test
    public void testCompute_MissingSmFlag() {
        String[] args = { "-ln", "2 3 5", "2" };
        assertTrue(Assignment3.compute(args).contains("java Assignment3"));
    }

    /*
     * Test (Edge Case): Checks mode calculation when there are multiple modes.
     * Path Covered: compute() -> getModeList()
     * Result: pass
     */
    @Test
    public void testCompute_MultipleModes() {
        String[] args = { "-ln", "2.5 2.5 3.5 3.5", "-sm", "3" };
        assertEquals("The Mode is: 2.5 3.5", Assignment3.compute(args));
    }

    /*
     * Test (Edge Case): Checks mode calculation when inputs have mixed integer and
     * double formats for the same number.
     * Path Covered: compute() -> getModeList() -> makeUniform()
     * Result: pass
     */
    @Test
    public void testCompute_ModeWithMixedIntAndDouble() {
        String[] args = { "-ln", "1 1.0 2 2.0 3.0", "-sm", "3" };
        assertEquals("The Mode is: 1.0 2.0", Assignment3.compute(args));
    }

    /*
     * Test: Checks Print All with input that requires sanitizing.
     * Path Covered: compute() -> sanitize() -> ...all calc methods
     * Result: pass
     */
    @Test
    public void testCompute_PrintAllWithSanitizedInput() {
        String[] args = {"-ln", "trash 7 !!! 8.5 begin", "-sm", "5"};
        String expectedOutput = "The Mean is: 7.8\n" +
                                "The Median is: 7.8\n" +
                                "The Mode is: 7.0 8.5\n" +
                                "The Standard Deviation is: 0.8";
        assertEquals(expectedOutput, Assignment3.compute(args));
    }

    /*
     * Test (Edge Case): Checks quit message when the -ln flag is missing.
     * Path Covered: compute()
     * Result: pass
     */
    @Test
    public void testCompute_QuitWithoutLnFlag() {
        String[] args = {"-sm", "6"};
        assertTrue(Assignment3.compute(args).contains("java Assignment3"));
    }

    /*
     * Test (Edge Case): Checks error for an invalid mode number greater than 6.
     * Path Covered: compute()
     * Result: pass
     */
    @Test
    public void testCompute_InvalidModeTooHigh() {
        String[] args = { "-ln", "3 4 5", "-sm", "7" };
        assertEquals("The response is: Invalid option", Assignment3.compute(args));
    }

}