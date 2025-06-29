import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculatorTest {

    @Test
    public void testAdd() {
        Calculator calc = new Calculator();
        int result = calc.add(10, 5);
        System.out.println("Running testAdd...");
        assertEquals(15, result);
    }

    @Test
    public void testSubtract() {
        Calculator calc = new Calculator();
        int result = calc.subtract(10, 5);
        System.out.println("Running testSubtract...");
        assertEquals(5, result);
    }
}
