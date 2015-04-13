using System.Data;

using Discuz.Common;
using Discuz.Data;
using Discuz.Config;
using Discuz.Entity;

namespace Discuz.Forum
{

	/// <summary>
	/// ��¼��־������
	/// </summary>
	public class LoginLogs
	{
        private static object lockHelper = new object();

		/// <summary>
		/// ���Ӵ�����������ش������, �粻���ڵ�¼������־����
		/// </summary>
		/// <param name="ip">ip��ַ</param>
        /// <returns>int</returns>
		public static int UpdateLoginLog(string ip, bool update)
		{
            lock (lockHelper)
            {
                DataTable dt = Discuz.Data.LoginLogs.GetErrLoginRecordByIP(ip);           
                if (dt.Rows.Count > 0)
                {
                    //���ڼ�¼
                    int errcount = Utils.StrToInt(dt.Rows[0][0].ToString(), 0);
                    if ((Utils.StrDateDiffMinutes(dt.Rows[0][1].ToString(), 0) <= 15 && errcount > 0) || update)
                    {
                        //��������ʱ��Ϊ15����֮�ڣ��Ҵ����������0�������ߣ���Ҫ���Ӽ�����
                        if ((errcount >= 5) || (!update))
                        {
                            //����������5���������ӣ�ֱ�ӷ��ء����� �����������¼��ֱ�ӷ���
                            return errcount;
                        }
                        else
                        {
                            //���Ӵ����¼������
                            Discuz.Data.LoginLogs.AddErrLoginCount(ip);
                            return errcount + 1;
                        }
                    }
                    else
                    {
                        //�����������0������ʱ�䳬��

                        //ԭ����Ϊ������15���ӣ���1��
                        //�޸ĺ󣺴���15���ӣ���0��������Ȼ����1��������������֤��
                        //ɾ����ռ�¼�ĺ����޸�Ϊ����errcountΪ0��ɾ��������ɾ��    
                        if(errcount > 0) Discuz.Data.LoginLogs.ResetErrLoginCount(ip);
                        return 1;
                    } 
                }
                else
                {
                    if (update)
                    {
                        //����һ�������¼��ԭ��¼Ϊ0
                        try
                        {
                            Discuz.Data.LoginLogs.AddErrLoginRecord(ip);
                        }
                        catch (System.Exception ex) { ex.ToString(); }
                        return 1;
                    }
                    else
                    {
                        //����ѯ��ԭ��¼Ϊ0
                        return 0;
                    }
                    
                }
            }
		}

		/// <summary>
		/// ɾ��ָ��ip��ַ�ĵ�¼������־
        /// �˴���Ҫ���а�ȫ��ǿ������Ϊ��ȷ�û��������ɾ����¼������ȵ�15���Ӻ��ɾ�����������ϴδ���15����
		/// </summary>
		/// <param name="ip">ip��ַ</param>
        /// <returns>int</returns>
		public static int DeleteLoginLog(string ip)
		{
            return Utils.IsIP(ip.Trim()) ? Discuz.Data.LoginLogs.DeleteErrLoginRecord(ip.Trim()) : 0;	
        }
	}
}
