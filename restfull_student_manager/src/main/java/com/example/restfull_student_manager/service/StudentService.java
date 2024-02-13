package com.example.restfull_student_manager.service;

import com.example.restfull_student_manager.entity.StudentEntity;
import com.example.restfull_student_manager.model.Student;
import com.example.restfull_student_manager.repository.StudentRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class StudentService {
    @Autowired
    StudentRepository studentRepository;

    public List<Student> searchStudentByNameOrPhoneOrEmail(String keyword) {
        StudentEntity studentExample = new StudentEntity();
        studentExample.setName(keyword);
        studentExample.setPhone(keyword);
        studentExample.setEmail(keyword);

        ExampleMatcher matcher = ExampleMatcher.matchingAny()
                .withMatcher("name", ExampleMatcher.GenericPropertyMatcher::contains)
                .withMatcher("phone", ExampleMatcher.GenericPropertyMatcher::contains)
                .withMatcher("email", ExampleMatcher.GenericPropertyMatcher::contains)
                .withIgnorePaths("id");
        Example<StudentEntity> example = Example.of(studentExample, matcher);
        List<StudentEntity> students = studentRepository.findAll(example);

        if (students.isEmpty()) {
            return null;
        }

        List<Student> custormStudents = new ArrayList<>();
        students.forEach(e -> {
            Student student = new Student();
            BeanUtils.copyProperties(e, student);
            custormStudents.add(student);
        });
        return custormStudents;
    }

    public List<Student> getAllStudents() {
        try {
            List<StudentEntity> students = studentRepository.findAll();
            List<Student> custormStudent = new ArrayList<>();
            students.forEach(e -> {
                Student student = new Student();
                BeanUtils.copyProperties(e, student);
                custormStudent.add(student);
            });
            return custormStudent;
        } catch (Exception e) {
            throw e;
        }
    }

    public Student getStudentById(Long id) {
        try {
            Optional<StudentEntity> studentEntityOptional = studentRepository.findById(id);
            if (studentEntityOptional.isPresent()) {
                StudentEntity studentEntity = studentEntityOptional.get();
                Student student = new Student();
                BeanUtils.copyProperties(studentEntity, student);
                return student;
            } else {
                return null;
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public String addStudent(StudentEntity studentAdd) {
        try {
            if (!studentRepository.existsByNameAndPhoneAndEmailAndAgeAndSexAndAddress(
                    studentAdd.getName(),
                    studentAdd.getPhone(),
                    studentAdd.getEmail(),
                    studentAdd.getAge(),
                    studentAdd.getSex(),
                    studentAdd.getAddress())) {
                studentRepository.save(studentAdd);
                return "Student add successfully";
            } else {
                return "This student already exists in the database";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public String updateStudent(StudentEntity studentUpdate) {
        try {
            if (studentRepository.existsById(studentUpdate.getId())) {
                studentRepository.save(studentUpdate);
                return "Student update successfully";
            } else {
                return "Student does not exits";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public String deleteStudent(Long id) {
        try {
            if (studentRepository.existsById(id)) {
                studentRepository.deleteById(id);
                return "Student removed successfully";
            } else {
                return "Student does not exist";
            }
        } catch (Exception e) {
            throw e;
        }
    }

}
