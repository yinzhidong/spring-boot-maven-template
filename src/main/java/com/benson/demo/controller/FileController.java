package com.benson.demo.controller;

import com.benson.demo.pojos.dto.FileDTO;
import com.benson.demo.services.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/files")
public class FileController {
    @Autowired
    private FileService fileService;



    @GetMapping("/list")
    public List<FileDTO> getFileList(@RequestParam(required = false) String path)
            throws IOException {
        return fileService.getFileList(path);
    }


    @GetMapping("/download/{filePath}")
    public void downloadFile(@PathVariable String filePath, HttpServletResponse response)
            throws IOException {
        fileService.downloadFile(response, filePath);
    }



    @GetMapping("/editPath")
    public void editPath(@RequestParam String path){
        fileService.setRootPath(path);
    }

    // @GetMapping("/download")
    // public ResponseEntity<Resource> downloadFile(@RequestParam("path") String path, HttpServletRequest request)
    //         throws IOException {
    //
    //     Path fullPath = fileService.resolvePath(path);
    //     File file = fullPath.toFile();
    //
    //     Resource resource = new UrlResource(fullPath.toUri());
    //     String contentType = request.getServletContext().getMimeType(file.getAbsolutePath());
    //
    //     if (contentType == null) {
    //         contentType = "application/octet-stream";
    //     }
    //
    //
    //     return ResponseEntity.ok()
    //             .contentType(MediaType.parseMediaType(contentType))
    //             .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + file.getName())
    //             .body(resource);
    // }
}