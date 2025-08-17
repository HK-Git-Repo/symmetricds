package kad.dev.symmetricds;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.sql.SQLException;
import java.util.List;

@SpringBootApplication
public class SymmetricdsApplication {

    public static void main(String[] args) {
        SpringApplication.run(SymmetricdsApplication.class, args);
    }


    /*@Bean
    CommandLineRunner commandLineRunner(Repo repo) {
        return args -> {
            List<Client> clients = List.of(
                    Client.builder()
                            .name("Hamza1 ELKADDARI1")
                            .build(),
                    Client.builder()
                            .name("Hamza2 ELKADDARI2")
                            .build(),
                    Client.builder()
                            .name("Hamza3 ELKADDARI3")
                            .build()
            );
            repo.saveAll(clients);
        };
    }*/
}
