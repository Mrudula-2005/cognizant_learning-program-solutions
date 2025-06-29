import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

public class MyServiceTest {

    @Test
    public void testVerifyInteraction() {
        ExternalApi mockApi = mock(ExternalApi.class);
        when(mockApi.getData()).thenReturn("Test Data");

        MyService service = new MyService(mockApi);
        service.fetchData();

        verify(mockApi).getData(); // Verifies that getData() was called once
    }
}
