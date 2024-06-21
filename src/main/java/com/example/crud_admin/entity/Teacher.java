package com.example.crud_admin.entity;
import jakarta.persistence.*;

@Entity
@Table(name = "teacher")
public class Teacher {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_teacher")
    private int idTeacher;

    @Column(name = "teacher_name", length = 255)
    private String teacherName;

    @Column(name = "description", length = 255)
    private String description;

    @Column(name = "thumbnail", length = 255)
    private String thumbnail;

    @ManyToOne
    @JoinColumn(name = "id_class", referencedColumnName = "id_class")
    private ClassRoom classRoom;

    // Getters and Setters

    public int getIdTeacher() {
        return idTeacher;
    }

    public void setIdTeacher(int idTeacher) {
        this.idTeacher = idTeacher;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public ClassRoom getClassRoom() {
        return classRoom;
    }

    public void setClassRoom(ClassRoom classRoom) {
        this.classRoom = classRoom;
    }
}