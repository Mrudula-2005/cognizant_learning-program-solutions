public class Main {

    // Recursive method to calculate future value
    public static double forecastValue(double currentValue, double growthRate, int years) {
        if (years == 0) return currentValue;
        return forecastValue(currentValue * (1 + growthRate), growthRate, years - 1);
    }

    public static void main(String[] args) {
        double initialValue = 10000; // ₹10,000
        double growthRate = 0.08;    // 8% annual growth
        int years = 5;

        double futureValue = forecastValue(initialValue, growthRate, years);

        System.out.printf("Future value after %d years: ₹%.2f\n", years, futureValue);
    }
}
