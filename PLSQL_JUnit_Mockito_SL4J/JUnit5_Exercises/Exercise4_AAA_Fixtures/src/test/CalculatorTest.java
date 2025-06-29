import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

public class CalculatorTest {

    private Calculator calculator;

    @BeforeEach
    void setUp() {
        System.out.println("Setting up...");
        calculator = new Calculator();  // Arrange
    }

    @AfterEach
    void tearDown() {
        System.out.println("Tearing down...");
        calculator = null;
    }

    @Test
    void testAddition() {
        // Act
        int result = calculator.add(2, 3);

        // Assert
        assertEquals(5, result, "Addition should return the correct sum");
    }

    @Test
    void testSubtraction() {
        int result = calculator.subtract(10, 4);
        assertEquals(6, result, "Subtraction should return the correct difference");
    }

    @Test
    void testMultiplication() {
        int result = calculator.multiply(3, 4);
        assertEquals(12, result, "Multiplication should return the correct product");
    }

    @Test
    void testDivision() {
        int result = calculator.divide(20, 4);
        assertEquals(5, result, "Division should return the correct quotient");
    }

    @Test
    void testDivisionByZeroThrowsException() {
        Exception exception = assertThrows(ArithmeticException.class, () -> {
            calculator.divide(10, 0);
        });
        assertEquals("Cannot divide by zero", exception.getMessage());
    }
}
