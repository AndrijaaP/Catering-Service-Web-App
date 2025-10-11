package model;

public class Role {
    private int role_id;
    private String naziv_role;

    public Role() {}
    public Role(int role_id, String naziv_role) {
        this.role_id = role_id;
        this.naziv_role = naziv_role;
    }

    public int getRole_id() { return role_id; }
    public void setRole_id(int role_id) { this.role_id = role_id; }
    public String getNaziv_role() { return naziv_role; }
    public void setNaziv_role(String naziv_role) { this.naziv_role = naziv_role; }
}