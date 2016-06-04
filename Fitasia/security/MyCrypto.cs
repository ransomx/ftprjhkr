using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace Fitasia.security
{
    public class MyCrypto
    {
        public static string CreateSalt(int size)
        {
            var rng = new System.Security.Cryptography.RNGCryptoServiceProvider();
            var buff = new byte[size];
            rng.GetBytes(buff);
            return Convert.ToBase64String(buff);
        }

        public static string GenerateSHA256(string input, string salt)
        {
            byte[] bytes = Encoding.UTF8.GetBytes(input + salt);
            System.Security.Cryptography.SHA256Managed sha256 = new System.Security.Cryptography.SHA256Managed();
            byte[] hash = sha256.ComputeHash(bytes);
            return ByteArrayToHexString(hash);
        }

        private static String ByteArrayToHexString(byte[] b)
        {
            StringBuilder hex = new StringBuilder(b.Length * 2);
            foreach(byte ba in b){
                hex.AppendFormat("{0:x2}", ba);
            }
            return hex.ToString();
        }
    }
}