/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.edu.ups.modelo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.*;



/**
 *
 * @author claum
 */
@Entity
public class User implements Serializable{
    private static final long serialVersionUID = 1L;
    
    @Id
    private String cedula;
    
    private String nombre;
    
    private String apellido;
    
    @Column(unique = true, nullable = false)
    private String correo;
    
    @Column(nullable = false)
    private String password;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Phone> telefonos;
    
    public User(){
        telefonos = new ArrayList<Phone>();
    }

    public User(String cedula, String nombre, String apellido, String correo, String pass) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo = correo;
        this.password = pass;
        telefonos = new ArrayList<Phone>();

    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPass() {
        return password;
    }

    public void setPass(String pass) {
        this.password = pass;
    }

    
    public List<Phone> getTelefonos() {
        return telefonos;
    }

    public void setTelefonos(List<Phone> telefonos) {
        this.telefonos = telefonos;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 83 * hash + Objects.hashCode(this.password);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final User other = (User) obj;
        if (!Objects.equals(this.correo, other.correo)) {
            return false;
        }
        if (!Objects.equals(this.password, other.password)) {
            return false;
        }
        return true;
    }
    
    public void deletePhone(Phone phone) {
    	if(telefonos.contains(phone)) {
    		this.telefonos.remove(phone);
        	phone.setUser(null);
    	}
    }
    
    public void addPhone(Phone phone) {
    	if(!telefonos.contains(phone)) {
    		this.telefonos.add(phone);
        	phone.setUser(this);
    	}
    }

	@Override
	public String toString() {
		return "User [cedula=" + cedula + ", nombre=" + nombre + ", apellido=" + apellido + ", correo=" + correo
				+ ", pass=" + password + ", telefonos=" + telefonos + "]";
	}

    
    
}
