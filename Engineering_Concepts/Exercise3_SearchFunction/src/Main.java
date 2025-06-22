import java.util.Arrays;
import java.util.Comparator;

public class Main {
    // Linear Search
    public static Product linearSearch(Product[] products, String name) {
        for (Product product : products) {
            if (product.productName.equalsIgnoreCase(name)) {
                return product;
            }
        }
        return null;
    }

    // Binary Search (on sorted array)
    public static Product binarySearch(Product[] products, String name) {
        int low = 0, high = products.length - 1;

        while (low <= high) {
            int mid = (low + high) / 2;
            int comparison = products[mid].productName.compareToIgnoreCase(name);

            if (comparison == 0) return products[mid];
            else if (comparison < 0) low = mid + 1;
            else high = mid - 1;
        }

        return null;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(101, "Shoes", "Footwear"),
            new Product(102, "T-Shirt", "Apparel"),
            new Product(103, "Laptop", "Electronics"),
            new Product(104, "Watch", "Accessories"),
            new Product(105, "Phone", "Electronics")
        };

        // Linear Search
        Product result1 = linearSearch(products, "Laptop");
        System.out.println("Linear Search Result: " + result1);

        // Binary Search (requires sorting first)
        Arrays.sort(products, Comparator.comparing(p -> p.productName));
        Product result2 = binarySearch(products, "Laptop");
        System.out.println("Binary Search Result: " + result2);
    }
}
