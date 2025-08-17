package kad.dev.symmetricds;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

@Service
public class ExportService {
    // /bin/sh -c "$(curl -fsSL https://sq.io/install.sh)"
    public void export() throws IOException, InterruptedException {
        // Path inside JAR resources
        String path = new ClassPathResource("scripts/export.sh").getPath();
        System.out.println("***************** "+path);
        ProcessBuilder pb = new ProcessBuilder();
pb.command(path, "Client");
        pb.redirectErrorStream(true);
pb.inheritIO();
        Process process = pb.start();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
            reader.lines().forEach(System.out::println);
        }

        int exitCode = process.waitFor();
        if (exitCode != 0) {
            throw new RuntimeException("Export failed, exit code: " + exitCode);
        }
    }
}
