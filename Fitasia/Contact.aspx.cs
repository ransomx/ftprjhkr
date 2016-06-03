using Fitasia.logic;
using System;
using System.Net;
using System.Net.Mail;

namespace Fitasia
{
    public partial class Contacts : FormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User u = (User)Session["LoggedUser"];
            if (u != null)
            {
                TxtName.Text = u.Name;
                TxtEmail.Text = u.Email;
            }
        }

        protected void BtnSend_Click(object sender, EventArgs e)
        {
            string email = TxtEmail.Text.Trim();
            string name = TxtName.Text.Trim();
            string topic = TxtTopic.Text;
            string text = TxtInput.Text;

            SendContactEmail(email,name,topic,text);
            clearFields();
            LblMessage.Text = "A message was sent, thank you for your response";

            LblMessage.Visible = true;
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
        }

        protected void SendContactEmail(String email, String name, String topic, String text)
        {
            using (MailMessage mm = new MailMessage("Practicaltester@gmail.com", "Fitasiaserviceteam@gmail.com"))
            {
                mm.Subject = "Account Activation";
                string body = "Message from " + name + ",";
                body += text;
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true; //email: fitasiaserviceteam@gmail.com - 123456789abcdE
                NetworkCredential NetworkCred = new NetworkCredential("Practicaltester@gmail.com", "826451379");
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }
        }

        protected void clearFields()
        {
            TxtInput.Text = "";
            TxtTopic.Text = "";
        }
    }
}