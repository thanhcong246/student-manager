package com.example.restfull_student_manager.controller;

import com.example.restfull_student_manager.entity.StudentEntity;
import com.example.restfull_student_manager.model.Student;
import com.example.restfull_student_manager.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")
public class StudentController {
    @Autowired
    StudentService studentService;

    @GetMapping("searchStudent")
    public List<Student> searchStudent(@RequestParam String keyword) {
        return studentService.searchStudentByNameOrPhoneOrEmail(keyword);
    }

    @GetMapping("/students")
    public List<Student> getAllStudents() {
        return studentService.getAllStudents();
    }

    @GetMapping("student/{id}")
    public Student getStudentById(@PathVariable Long id) {
        return studentService.getStudentById(id);
    }

    @PostMapping("addStudent")
    public String addStudent(@RequestBody StudentEntity studentAdd) {
        return studentService.addStudent(studentAdd);
    }

    @PutMapping("updateStudent/{id}")
    public String updateStudent(@PathVariable Long id, @RequestBody StudentEntity studentUpdate) {
        studentUpdate.setId(id);
        return studentService.updateStudent(studentUpdate);
    }

    @DeleteMapping("/removeStudent/{id}")
    public String deleteStudent(@PathVariable Long id) {
        return studentService.deleteStudent(id);
    }
}
