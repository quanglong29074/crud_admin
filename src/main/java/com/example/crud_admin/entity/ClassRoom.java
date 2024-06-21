package com.example.crud_admin.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "class_room")
public class ClassRoom {
    @Column(name = "class_name")
    private String className;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_class")
    private int idClass;
    @Column(name = "number_member")
    private int numberMember;

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public int getIdClass() {
        return idClass;
    }

    public void setIdClass(int idClass) {
        this.idClass = idClass;
    }

    public int getNumberMember() {
        return numberMember;
    }

    public void setNumberMember(int numberMember) {
        this.numberMember = numberMember;
    }

}

