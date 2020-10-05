/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ducnt.utils;

import ducnt.dtos.UserDTO;
import java.io.Serializable;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author ngota
 */
public class MailUtil implements Serializable {

    private static final String SENDER_MAIL = "stever123410@gmail.com";
    private static final String PASSWORD = "peqazazmjfssguqs";

    public static void sendEmail(String userEmail, String code) throws Exception {
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); //TLS
        Session session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_MAIL, PASSWORD);
            }
        });
        Message mess = new MimeMessage(session);
        mess.setFrom(new InternetAddress(SENDER_MAIL));
        mess.setRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
        mess.setSubject("MiniSocialNetwork Verification Code");
        mess.setText("Your verification code is " + code);
        Transport.send(mess);
    }
}
