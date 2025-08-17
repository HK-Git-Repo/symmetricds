package kad.dev.symmetricds;

import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api")
@AllArgsConstructor
public class Controller {

    private ExportService exportService;

    private Repo repo;

    @PostMapping("/export")
    public void export() throws IOException, InterruptedException {
        exportService.export();
    }

    @GetMapping("/get")
    public ResponseEntity<List<Client>> get() {
        return ResponseEntity.ok(this.repo.findAll());
    }
}
