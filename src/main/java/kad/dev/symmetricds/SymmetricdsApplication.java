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


    @Bean
    CommandLineRunner commandLineRunner(Repo repo) {
        StringBuilder sb = new StringBuilder("xxx1, xxx2");
        sb.append((char) 10);
        sb.append(" xxx3");

        return args -> {
            List<Client> clients = List.of(
                    Client.builder()
                            .name("Hamza1 ELKADDARI1")
                            .comment(sb.toString())
                            .build(),
                    Client.builder()
                            .name("Hamza2 ELKADDARI2")
                            .comment("yyy1;,.yyy2")
                            .build(),
                    Client.builder()
                            .name("Hamza3 ELKADDARI3")
                            .comment("zzz1")
                            .build()
            );
            repo.saveAll(clients);
        };
    }
}
