package com.benson.demo.services;

import com.benson.demo.pojos.dto.FileDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

@Component
@Slf4j
public class FileService {

    private static String rootPath;


    @Value("${file.server.rootPath:/}")
    public void setRootPath(String rootPath){
        FileService.rootPath = rootPath;
    }


    public List<FileDTO> getFileList(String path) throws IOException {
        Path fullPath = resolvePath(path);

        return Files.list(fullPath)
                .map(file -> new FileDTO(
                        file.getFileName().toString(),
                        Files.isDirectory(file) ? "directory" : "file",
                        path + '/' + file.getFileName().toString())
                )
                .collect(Collectors.toList());
    }



    public void downloadFile(HttpServletResponse response, String path) throws IOException {
        Path fullPath = resolvePath(path);

        if(!Files.isRegularFile(fullPath)) {
            return;
        }

        File file = fullPath.toFile();
        response.setContentType(Files.probeContentType(fullPath));
        response.setContentLengthLong(file.length());

        String encodedFileName = URLEncoder.encode(file.getName(), StandardCharsets.UTF_8);
        response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + encodedFileName);

        Files.copy(fullPath, response.getOutputStream());
        response.flushBuffer();
    }



    public String currentDir() {
        return System.getProperty("user.dir");
    }




    public byte[] getFileContent(String path) throws IOException {
        Path fullPath = resolvePath(path);
        return Files.readAllBytes(fullPath);
        // return Files.readAllBytes(fullPath, StandardCharsets.UTF_8);
    }


    // public String getFileContent(String path) throws IOException {
    //     Path fullPath = resolvePath(path);
    //     return Files.readAllBytes(fullPath, StandardCharsets.UTF_8);
    // }

    // public void createFile(String path, String content) throws IOException {
    //     Path fullPath = resolvePath(path);
    //
    //     Files.writeString(fullPath, content, StandardCharsets.UTF_8);
    // }
    //
    // public void updateFile(String path, String content) throws IOException {
    //     Path fullPath = resolvePath(path);
    //
    //     Files.writeString(fullPath, content, StandardCharsets.UTF_8);
    // }

    public void deleteFile(String path) throws IOException {
        Path fullPath = resolvePath(path);
        Files.delete(fullPath);
    }

    private Path resolvePath(String path) {
        return path != null ? Paths.get(rootPath, path) : Paths.get(rootPath);
    }
}