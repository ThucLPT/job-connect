package Controller;

import org.apache.commons.codec.binary.Base64;

public class PasswordEncryption {

    public static String encrypt(String password) {
        return new String(Base64.encodeBase64(password.getBytes()));
    }

    public static String decrypt(String encrypted) {
        return new String(Base64.decodeBase64(encrypted.getBytes()));
    }
}
