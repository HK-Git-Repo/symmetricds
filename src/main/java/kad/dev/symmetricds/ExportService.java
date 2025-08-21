package kad.dev.symmetricds;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@Service
public class ExportService {
    // /bin/sh -c "$(curl -fsSL https://sq.io/install.sh)"
    private static final String FILE_PATH = "scripts/export.sh";

    public void export() throws IOException, InterruptedException {
        try {
            ProcessBuilder pb = new ProcessBuilder();
            pb.command(FILE_PATH, "Client");
            pb.redirectErrorStream(true);
            pb.inheritIO();
            Process process = pb.start();

            process.waitFor();

            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }
        } catch(IOException | InterruptedException e) {
            System.out.println("############ --> "+e.getMessage());
            throw e;
        }
    }
}
