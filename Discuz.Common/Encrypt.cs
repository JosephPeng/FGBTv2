using System;
using System.IO;
using System.Text;
using System.Security.Cryptography;

using Discuz.Common;
 
namespace Discuz.Common
{ 
	/// <summary> 
	/// ����
	/// </summary> 
	public class AES
	{ 
		//Ĭ����Կ����
		private static byte[] Keys = { 0x41, 0x72, 0x65, 0x79, 0x6F, 0x75, 0x6D, 0x79, 0x53, 0x6E, 0x6F, 0x77, 0x6D, 0x61, 0x6E, 0x3F };

		public static string Encode(string encryptString, string encryptKey)
		{
			encryptKey = Utils.GetSubString(encryptKey, 32, "");
			encryptKey = encryptKey.PadRight(32, ' ');

			RijndaelManaged rijndaelProvider = new RijndaelManaged();
			rijndaelProvider.Key = Encoding.UTF8.GetBytes(encryptKey.Substring(0, 32));
			rijndaelProvider.IV = Keys;
			ICryptoTransform rijndaelEncrypt = rijndaelProvider.CreateEncryptor();
 
			byte[] inputData = Encoding.UTF8.GetBytes(encryptString);
			byte[] encryptedData = rijndaelEncrypt.TransformFinalBlock(inputData,0,inputData.Length);

			return Convert.ToBase64String(encryptedData);
		}
	
		public static string Decode(string decryptString, string decryptKey)
        {
            if (decryptString == string.Empty)
            {
                return string.Empty;
            }
			try
			{
				decryptKey = Utils.GetSubString(decryptKey, 32, "");
				decryptKey = decryptKey.PadRight(32, ' ');

				RijndaelManaged rijndaelProvider = new RijndaelManaged();
				rijndaelProvider.Key = Encoding.UTF8.GetBytes(decryptKey);
				rijndaelProvider.IV = Keys;
				ICryptoTransform rijndaelDecrypt = rijndaelProvider.CreateDecryptor();
 
				byte[] inputData = Convert.FromBase64String(decryptString);
				byte[] decryptedData = rijndaelDecrypt.TransformFinalBlock(inputData,0,inputData.Length);

				return Encoding.UTF8.GetString(decryptedData);
			}
			catch
			{
				return "";
			}

		}


        //////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////// 
        //��BT�޸ġ�����Ϊhex����
        public static string Encode2HEX(string encryptString, string encryptKey)
        {
            encryptKey = Utils.GetSubString(encryptKey, 32, "");
            encryptKey = encryptKey.PadRight(32, ' ');

            RijndaelManaged rijndaelProvider = new RijndaelManaged();

            rijndaelProvider.Key = Encoding.UTF8.GetBytes(encryptKey.Substring(0, 32));
            rijndaelProvider.IV = Keys;
            rijndaelProvider.Mode = CipherMode.ECB;
            rijndaelProvider.Padding = PaddingMode.Zeros;
            ICryptoTransform rijndaelEncrypt = rijndaelProvider.CreateEncryptor();

            byte[] inputData = Encoding.UTF8.GetBytes(encryptString);
            byte[] encryptedData = rijndaelEncrypt.TransformFinalBlock(inputData, 0, inputData.Length);

            int len = encryptedData.Length;
            string output = "";
            string tmp = "";
            for (int i = 0; i < len; i++)
            {
                tmp = String.Format("{0:X}", Convert.ToInt32(encryptedData[i]));
                if (tmp.Length < 2) tmp = "0" + tmp;
                output += tmp;
            }
            return output;
        }
        //public static string Encode2HEXFromHEX(string encryptString, string encryptKey)
        //{
        //    encryptKey = Utils.GetSubString(encryptKey, 32, "");
        //    encryptKey = encryptKey.PadRight(32, ' ');

        //    RijndaelManaged rijndaelProvider = new RijndaelManaged();
        //    rijndaelProvider.Key = Encoding.UTF8.GetBytes(encryptKey.Substring(0, 32));
        //    rijndaelProvider.IV = Keys;
        //    ICryptoTransform rijndaelEncrypt = rijndaelProvider.CreateEncryptor();

        //    encryptString = encryptString.Replace(" ", "");
        //    if (encryptString.Length <= 0) return "";
        //    byte[] inputData = new byte[encryptString.Length / 2];
        //    for (int i = 0; i < encryptString.Length; i += 2)
        //        if (!byte.TryParse(encryptString.Substring(i, 2), System.Globalization.NumberStyles.HexNumber, null, out inputData[i / 2]))
        //            inputData[i / 2] = 0;

        //    byte[] encryptedData = rijndaelEncrypt.TransformFinalBlock(inputData, 0, inputData.Length);


        //    int len = encryptedData.Length;
        //    string output = "";
        //    string tmp = "";
        //    for (int i = 0; i < len; i++)
        //    {
        //        tmp = String.Format("{0:X}", Convert.ToInt32(encryptedData[i]));
        //        if (tmp.Length < 2) tmp = "0" + tmp;
        //        output += tmp;
        //    }
        //    return output;
        //}

        public static string DecodeFromHEX(string decryptString, string decryptKey)
        {
            if (decryptString == string.Empty)
            {
                return string.Empty;
            }
            try
            {
                decryptKey = Utils.GetSubString(decryptKey, 32, "");
                decryptKey = decryptKey.PadRight(32, ' ');

                RijndaelManaged rijndaelProvider = new RijndaelManaged();
                rijndaelProvider.Key = Encoding.UTF8.GetBytes(decryptKey);
                rijndaelProvider.IV = Keys;
                rijndaelProvider.Mode = CipherMode.ECB;
                rijndaelProvider.Padding = PaddingMode.Zeros;
                ICryptoTransform rijndaelDecrypt = rijndaelProvider.CreateDecryptor();

                decryptString = decryptString.Replace(" ", "");
                if (decryptString.Length <= 0) return "";
                byte[] inputData = new byte[decryptString.Length / 2];
                for (int i = 0; i < decryptString.Length; i += 2)
                    if (!byte.TryParse(decryptString.Substring(i, 2), System.Globalization.NumberStyles.HexNumber, null, out inputData[i / 2]))
                        inputData[i / 2] = 0;

                byte[] decryptedData = rijndaelDecrypt.TransformFinalBlock(inputData, 0, inputData.Length);

                return Encoding.UTF8.GetString(decryptedData).Replace("\0", "").Trim();
            }
            catch
            {
                return "";
            }

        }
        //public static string Decode2HEXFromHEX(string decryptString, string decryptKey)
        //{
        //    if (decryptString == string.Empty)
        //    {
        //        return string.Empty;
        //    }
        //    try
        //    {
        //        decryptKey = Utils.GetSubString(decryptKey, 32, "");
        //        decryptKey = decryptKey.PadRight(32, ' ');

        //        RijndaelManaged rijndaelProvider = new RijndaelManaged();
        //        rijndaelProvider.Key = Encoding.UTF8.GetBytes(decryptKey);
        //        rijndaelProvider.IV = Keys;
        //        ICryptoTransform rijndaelDecrypt = rijndaelProvider.CreateDecryptor();

        //        decryptString = decryptString.Replace(" ", "");
        //        if (decryptString.Length <= 0) return "";
        //        byte[] inputData = new byte[decryptString.Length / 2];
        //        for (int i = 0; i < decryptString.Length; i += 2)
        //            if (!byte.TryParse(decryptString.Substring(i, 2), System.Globalization.NumberStyles.HexNumber, null, out inputData[i / 2]))
        //                inputData[i / 2] = 0;

        //        byte[] decryptedData = rijndaelDecrypt.TransformFinalBlock(inputData, 0, inputData.Length);

        //        int len = decryptedData.Length;
        //        string output = "";
        //        string tmp = "";
        //        for (int i = 0; i < len; i++)
        //        {
        //            tmp = String.Format("{0:X}", Convert.ToInt32(decryptedData[i]));
        //            if (tmp.Length < 2) tmp = "0" + tmp;
        //            output += tmp;
        //        }
        //        return output;
        //    }
        //    catch
        //    {
        //        return "";
        //    }

        //}
        //��END BT�޸ġ�
        //////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////
	}

	/// <summary> 
	/// ����
	/// </summary> 
	public class DES
	{ 
		//Ĭ����Կ����
		private static byte[] Keys = { 0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF };
		
		/// <summary>
		/// DES�����ַ���
		/// </summary>
		/// <param name="encryptString">�����ܵ��ַ���</param>
		/// <param name="encryptKey">������Կ,Ҫ��Ϊ8λ</param>
		/// <returns>���ܳɹ����ؼ��ܺ���ַ���,ʧ�ܷ���Դ��</returns>
		public static string Encode(string encryptString, string encryptKey)
		{
			encryptKey = Utils.GetSubString(encryptKey, 8, "");
			encryptKey = encryptKey.PadRight(8, ' ');
			byte[] rgbKey = Encoding.UTF8.GetBytes(encryptKey.Substring(0, 8));
			byte[] rgbIV = Keys;
			byte[] inputByteArray = Encoding.UTF8.GetBytes(encryptString);
			DESCryptoServiceProvider dCSP = new DESCryptoServiceProvider();
			MemoryStream mStream = new MemoryStream();
			CryptoStream cStream = new CryptoStream(mStream, dCSP.CreateEncryptor(rgbKey, rgbIV), CryptoStreamMode.Write);
			cStream.Write(inputByteArray, 0, inputByteArray.Length);
			cStream.FlushFinalBlock();
			return Convert.ToBase64String(mStream.ToArray());
		
		}

        /// <summary>
        /// DES�����ַ���
        /// </summary>
        /// <param name="encryptString">�����ܵ��ַ���</param>
        /// <param name="encryptKey">������Կ,Ҫ��Ϊ8λ</param>
        /// <returns>���ܳɹ����ؼ��ܺ���ַ���,ʧ�ܷ���Դ��</returns>
        public static string EncodeToHEX(byte[] inputByteArray, string encryptKey)
        {
            encryptKey = Utils.GetSubString(encryptKey, 8, "");
            encryptKey = encryptKey.PadRight(8, ' ');
            byte[] rgbKey = Encoding.UTF8.GetBytes(encryptKey.Substring(0, 8));
            byte[] rgbIV = Keys;
            //byte[] inputByteArray = Encoding.UTF8.GetBytes(encryptString);
            DESCryptoServiceProvider dCSP = new DESCryptoServiceProvider();
            MemoryStream mStream = new MemoryStream();
            CryptoStream cStream = new CryptoStream(mStream, dCSP.CreateEncryptor(rgbKey, rgbIV), CryptoStreamMode.Write);
            cStream.Write(inputByteArray, 0, inputByteArray.Length);
            cStream.FlushFinalBlock();
            return PTTools.Byte2HEXLower(mStream.ToArray());
        }

		/// <summary>
		/// DES�����ַ���
		/// </summary>
		/// <param name="decryptString">�����ܵ��ַ���</param>
		/// <param name="decryptKey">������Կ,Ҫ��Ϊ8λ,�ͼ�����Կ��ͬ</param>
		/// <returns>���ܳɹ����ؽ��ܺ���ַ���,ʧ�ܷ�Դ��</returns>
		public static string Decode(string decryptString, string decryptKey)
		{
			try
			{
				decryptKey = Utils.GetSubString(decryptKey, 8, "");
				decryptKey = decryptKey.PadRight(8, ' ');
				byte[] rgbKey = Encoding.UTF8.GetBytes(decryptKey);
				byte[] rgbIV = Keys;
				byte[] inputByteArray = Convert.FromBase64String(decryptString);
				DESCryptoServiceProvider DCSP = new DESCryptoServiceProvider();
		
				MemoryStream mStream = new MemoryStream();
				CryptoStream cStream = new CryptoStream(mStream, DCSP.CreateDecryptor(rgbKey, rgbIV), CryptoStreamMode.Write);
				cStream.Write(inputByteArray, 0, inputByteArray.Length);
				cStream.FlushFinalBlock();
				return Encoding.UTF8.GetString(mStream.ToArray());
			}
			catch
			{
				return "";
			}		
		}
	} 
}