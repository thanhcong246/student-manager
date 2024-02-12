package com.example.restfull_student_manager.repository;

import com.example.restfull_student_manager.entity.StudentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StudentRepository extends JpaRepository<StudentEntity, Long> {
    public boolean existsByNameAndPhoneAndEmailAndAgeAndSexAndAddress( // ten phai dat dung cu phap nhu nay code moi chay
            String name,
            String phone,
            String email,
            int age,
            String sex,
            String address
    );
    public boolean existsById(Long id);
}
