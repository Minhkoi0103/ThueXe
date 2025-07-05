
package model;

public class User {

    private String userName;
    private String phoneNumber;
    private String identity_number;
    private String address;
    private String  status;
    private long userID;
    private String userEmail;
    private String userPass;
    private String userRole;

    public User() {
    }

    public User( String userName, String userEmail, String userPass,
                String phoneNumber, String identity_number, String address, String status, String userRole) {
        this.userName = userName;
        this.userEmail = userEmail;
        this.userPass = userPass;
        this.phoneNumber = phoneNumber;
        this.identity_number = identity_number;
        this.address = address;
        this.status = status;
        this.userRole = userRole;
    }

    public long getUserID() {
        return userID;
    }

    public void setUserID(long userID) {
        this.userID = userID;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass;
    }

    public String isUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getPhoneNumber() {
        return phoneNumber;
    }
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    public String getIdentityNumber() {
        return identity_number;
    }
    public void setIdentityNumber(String identity_number) {
        this.identity_number = identity_number;
    }
    public String getAddress() {
        return address;
    }
    public String getUserPassword() {
        return userPass;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getUserRole() {
        return userRole;
    }
}
