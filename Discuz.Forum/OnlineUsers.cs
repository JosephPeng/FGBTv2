using System;
using System.Web;
using System.Data;
using System.Collections.Generic;

using Discuz.Common;
using Discuz.Data;
using Discuz.Config;
using Discuz.Entity;
using Discuz.Common.Generic;

namespace Discuz.Forum
{
    /// <summary>
    /// �����û�������
    /// </summary>
    public class OnlineUsers
    {
        private static object SynObject = new object();
        /// <summary>
        /// ȫ�־�̬��������¼�ο��õ�userid��ʼ�ջ�ȡ��С�ģ�Ϊ������
        /// </summary>
        private static int minonlineuserid = 0;

        /// <summary>
        /// ��������û�������
        /// </summary>
        /// <returns>�û�����</returns>
        public static int GetOnlineAllUserCount()
        {
            int onlineUserCountCacheMinute = GeneralConfigs.GetConfig().OnlineUserCountCacheMinute;
            if (onlineUserCountCacheMinute == 0)
                return Discuz.Data.OnlineUsers.GetOnlineAllUserCount();

            Discuz.Cache.DNTCache cache = Discuz.Cache.DNTCache.GetCacheService();
            int onlineAllUserCount = TypeConverter.ObjectToInt(cache.RetrieveObject("/Forum/OnlineUserCount"));
            if (onlineAllUserCount != 0)
                return onlineAllUserCount;

            onlineAllUserCount = Discuz.Data.OnlineUsers.GetOnlineAllUserCount();
            //Discuz.Cache.ICacheStrategy ics = new RssCacheStrategy();
            //ics.TimeOut = onlineUserCountCacheMinute * 60;
            //cache.LoadCacheStrategy(ics);
            cache.AddObject("/Forum/OnlineUserCount", onlineAllUserCount, onlineUserCountCacheMinute * 60);
            //cache.LoadDefaultCacheStrategy();
            return onlineAllUserCount;
        }

        /// <summary>
        /// ���ػ����������û�����
        /// </summary>
        /// <returns>�����������û�����</returns>
        public static int GetCacheOnlineAllUserCount()
        {
            int count = TypeConverter.StrToInt(Utils.GetCookie("onlineusercount"), 0);
            if (count == 0)
            {
                count = OnlineUsers.GetOnlineAllUserCount();
                Utils.WriteCookie("onlineusercount", count.ToString(), 3);
            }
            return count;
        }

        /// <summary>
        /// ����֮ǰ�����߱��¼(��������Ӧ�ó����ʼ��ʱ������)
        /// </summary>
        /// <returns></returns>
        public static int InitOnlineList()
        {
            return Discuz.Data.OnlineUsers.CreateOnlineTable();
        }

        /// <summary>
        /// ��λ���߱�, ���ϵͳδ����, ����Ӧ�ó�����������, �򲻻����´���
        /// </summary>
        /// <returns></returns>
        public static int ResetOnlineList()
        {
            try
            {

                // �����������ϵͳ����ʱ��С��10����
                if (System.Environment.TickCount < 600000 && System.Environment.TickCount > 0)
                    return Discuz.Data.OnlineUsers.CreateOnlineTable();

                return -1;
            }
            catch
            {
                try
                {
                    return Discuz.Data.OnlineUsers.CreateOnlineTable();
                }
                catch
                {
                    return -1;
                }
            }
        }

        /// <summary>
        /// �������ע���û�������
        /// </summary>
        /// <returns>�û�����</returns>
        public static int GetOnlineUserCount()
        {
            return Discuz.Data.OnlineUsers.GetOnlineUserCount();
        }

        #region ���ݲ�ͬ������ѯ�����û���Ϣ


        /// <summary>
        /// ���������û��б�
        /// </summary>
        /// <param name="totaluser">ȫ���û���</param>
        /// <param name="guest">�ο���</param>
        /// <param name="user">��¼�û���</param>
        /// <param name="invisibleuser">�����Ա��</param>
        /// <returns>���û��б�</returns>
        public static DataTable GetOnlineUserList(int totaluser, out int guest, out int user, out int invisibleuser)
        {
            DataTable dt = Discuz.Data.OnlineUsers.GetOnlineUserListTable();
            int highestonlineusercount = TypeConverter.StrToInt(Statistics.GetStatisticsRowItem("highestonlineusercount"), 1);

            if (totaluser > highestonlineusercount)
            {
                if (Statistics.UpdateStatistics("highestonlineusercount", totaluser.ToString()) > 0)
                {
                    Statistics.UpdateStatistics("highestonlineusertime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                    Statistics.ReSetStatisticsCache();
                }
            }
            // ͳ���û�
            //DataRow[] dr = dt.Select("userid>0");
            user = Discuz.Data.OnlineUsers.GetOnlineUserCount();// dr == null ? 0 : dr.Length;

            //ͳ�������û�
            if (EntLibConfigs.GetConfig() != null && EntLibConfigs.GetConfig().Cacheonlineuser.Enable)
                invisibleuser = Discuz.Data.OnlineUsers.GetInvisibleOnlineUserCount();
            else
            {
                DataRow[] dr = dt.Select("invisible=1");
                invisibleuser = dr == null ? 0 : dr.Length;
            }
            //ͳ���ο�
            guest = totaluser > user ? totaluser - user : 0;

            //���ص�ǰ���������û���
            return dt;
        }
        #endregion


        /// <summary>
        /// ���������û�ͼ��
        /// </summary>
        /// <returns>�����û�ͼ��</returns>
        private static DataTable GetOnlineGroupIconTable()
        {
            lock (SynObject)
            {
                Discuz.Cache.DNTCache cache = Discuz.Cache.DNTCache.GetCacheService();
                DataTable dt = cache.RetrieveObject("/Forum/OnlineIconTable") as DataTable;

                if (dt == null)
                {
                    dt = Discuz.Data.OnlineUsers.GetOnlineGroupIconTable();
                    cache.AddObject("/Forum/OnlineIconTable", dt);
                }
                return dt;
            }
        }

        /// <summary>
        /// �����û���ͼ��
        /// </summary>
        /// <param name="groupid">�û���</param>
        /// <returns>�û���ͼ��</returns>
        public static string GetGroupImg(int groupid)
        {
            string img = "";
            DataTable dt = GetOnlineGroupIconTable();
            // ���û��Ҫ��ʾ��ͼ�������򷵻�""
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    // ͼ�����ͳ�ʼΪ:��ͨ�û�
                    // �����ƥ��������Ϊƥ���ͼ��
                    if ((int.Parse(dr["groupid"].ToString()) == 0 && img == "") || (int.Parse(dr["groupid"].ToString()) == groupid))
                    {
                        img = "<img src=\"" + BaseConfigs.GetForumPath + "images/groupicons/" + dr["img"].ToString() + "\" />";
                    }
                }
            }
            return img;
        }

        #region �鿴ָ����ĳһ�û�����ϸ��Ϣ
        public static OnlineUserInfo GetOnlineUser(int olid)
        {
            return Discuz.Data.OnlineUsers.GetOnlineUser(olid);
        }

        /// <summary>
        /// ���ָ���û�����ϸ��Ϣ
        /// </summary>
        /// <param name="userid">�����û�ID</param>
        /// <param name="password">�û�����</param>
        /// <returns>�û�����ϸ��Ϣ</returns>
        private static OnlineUserInfo GetOnlineUser(int userid, string password)
        {
            //��BT�޸ġ�����password null�ж�
            if (Utils.StrIsNullOrEmpty(password)) return null;
            return Discuz.Data.OnlineUsers.GetOnlineUser(userid, password);
        }

        /// <summary>
        /// ���ָ���û�����ϸ��Ϣ���˺�����userid��Ч��һ�ɲ���useridС������û������οͣ�
        /// </summary>
        /// <returns>�û�����ϸ��Ϣ</returns>
        private static OnlineUserInfo GetOnlineUserByIP(int userid, string ip)
        {
            return Discuz.Data.OnlineUsers.GetOnlineUserByIP(userid, ip);
        }
        /// <summary>
        /// ���ָ���û�����ϸ��Ϣ���˺�����userid��Ч��һ�ɲ���useridС������û������οͣ�
        /// </summary>
        /// <returns>�û�����ϸ��Ϣ</returns>
        public static OnlineUserInfo GetOnlineUserByRkey(int userid, string rkey)
        {
            return Discuz.Data.OnlineUsers.GetOnlineUserByRkey(userid, rkey);
        }

        /// <summary>
        /// ��������û���֤���Ƿ���Ч
        /// </summary>
        /// <param name="olid">�����û�ID</param>
        /// <param name="verifycode">��֤��</param>
        /// <returns>�����û�ID</returns>
        public static bool CheckUserVerifyCode(int olid, string verifycode)
        {
            return Discuz.Data.OnlineUsers.CheckUserVerifyCode(olid, verifycode, ForumUtils.CreateAuthStr(5, false));
        }

        #endregion

        #region ����µ������û�

        /// <summary>
        /// Cookie��û���û�ID�����ĵ��û�ID��Чʱ�����߱�������һ���ο�.
        /// </summary>
        public static OnlineUserInfo CreateGuestUser(int timeout, string ip)
        {
            OnlineUserInfo onlineuserinfo = new OnlineUserInfo();

            

            onlineuserinfo.Username = "�ο�";
            onlineuserinfo.Nickname = "�ο�";
            onlineuserinfo.Password = "";
            onlineuserinfo.Groupid = 7;
            onlineuserinfo.Olimg = GetGroupImg(7);
            onlineuserinfo.Adminid = 0;
            onlineuserinfo.Invisible = 0;
            onlineuserinfo.Lastposttime = "1900-1-1 00:00:00";
            onlineuserinfo.Lastpostpmtime = "1900-1-1 00:00:00";
            onlineuserinfo.Lastsearchtime = "1900-1-1 00:00:00";
            onlineuserinfo.Lastupdatetime = Utils.GetDateTime();
            onlineuserinfo.Action = 0;
            onlineuserinfo.Lastactivity = 0;
            onlineuserinfo.Verifycode = ForumUtils.CreateAuthStr(5, false);

            onlineuserinfo.RKey = PTTools.GetRandomString(10, true);

            if (Utils.StrIsNullOrEmpty(ip))
            {
                onlineuserinfo.Ip = DNTRequest.GetIP();
            }
            else
            {
                onlineuserinfo.Ip = ip;
            }

            //�����ο͵����������ĵ��Լ���
            //lock (SynObject)
            {
                //�˴���Ҫ��֤userid���ظ����ѵ�¼�û�ʹ���Լ���userid��δ��¼�ο�ʹ�õݼ�����
                //��η�ֹ����ݼ��ĸ����ظ���
                //�١����ݿ�������useridΪΨһ���������ɷ�ֹ�ظ����ڷ�������ʱ�ظ���ȡ
                //   ���ڲ����ο͵�Ƶ�ʲ���̫�ߣ�����쳣�����Ƿ��ǿ��Խ��ܵģ�
                //�� �ԡ�minonlineuserid�Լ�������lock��
                if (minonlineuserid > -1)
                {
                    minonlineuserid = DatabaseProvider.GetInstance().GetMinOnlneUserid();
                    if (minonlineuserid > -1) minonlineuserid = -1;
                }

                //��ֵ���Լ�
                lock (SynObject)
                {
                    onlineuserinfo.Userid = --minonlineuserid;
                }
                try
                {
                    onlineuserinfo.Olid = Discuz.Data.OnlineUsers.CreateOnlineUserInfo(onlineuserinfo, timeout);
                }
                catch
                {
                    //onlineuserinfo.Olid = OnlineUsers.GetOnlineUserByIP()


                	//�����ο��쳣������ԭ��Ϊminonlineuserid��ֵ���ԣ�
                    minonlineuserid = DatabaseProvider.GetInstance().GetMinOnlneUserid();
                    lock (SynObject)
                    {
                        onlineuserinfo.Userid = --minonlineuserid;
                    }
                    try
                    {
                        onlineuserinfo.Olid = Discuz.Data.OnlineUsers.CreateOnlineUserInfo(onlineuserinfo, timeout);
                    }
                    catch
                    {
                        onlineuserinfo.Olid = -1;
                    }
                } 
            }

            //�·��ÿ�Rkey
            System.Web.HttpContext.Current.Response.Cookies["rkey"].Value = onlineuserinfo.RKey;
            System.Web.HttpContext.Current.Response.Cookies["rkey"].Expires = DateTime.MaxValue;
            System.Web.HttpContext.Current.Response.Cookies["rkey"].HttpOnly = true;

            return onlineuserinfo;
        }


        /// <summary>
        /// ����һ����Ա��Ϣ�������б��С��û�login.aspx�������û���Ϣ��ʱ,���û������ߵ���������������û������б�
        /// Rkey��������
        /// </summary>
        /// <param name="uid"></param>
        private static OnlineUserInfo CreateUser(int uid, int timeout, string ip, string rkeyexpire, int mode)
        {
            OnlineUserInfo onlineuserinfo = new OnlineUserInfo();
            if (uid > 0)
            {
                ShortUserInfo ui = Users.GetShortUserInfo(uid);
                if (ui != null)
                {
                    onlineuserinfo.Userid = uid;
                    onlineuserinfo.Username = ui.Username.Trim();
                    onlineuserinfo.Nickname = ui.Nickname.Trim();
                    onlineuserinfo.Password = ui.Password.Trim();
                    
                    //onlineuserinfo.RKey = PTUsers.GetUserRKey(uid);
                    //Rkey����Ϊÿ�����߾�������
                    if (mode == 0)
                    {
                        onlineuserinfo.RKey = PTTools.GetRandomString(10, true);
                    }
                    else
                    {
                        onlineuserinfo.RKey = "CN_" + PTTools.GetRandomString(7, true);
                    }
                    
                    onlineuserinfo.RkeyExpire = rkeyexpire;
                    onlineuserinfo.RkeyExpireTime = DateTime.Now.AddMinutes(5);
                    
                    onlineuserinfo.Groupid = short.Parse(ui.Groupid.ToString());
                    onlineuserinfo.Olimg = GetGroupImg(short.Parse(ui.Groupid.ToString()));
                    onlineuserinfo.Adminid = short.Parse(ui.Adminid.ToString());
                    onlineuserinfo.Invisible = short.Parse(ui.Invisible.ToString());
                    if (Utils.StrIsNullOrEmpty(ip))
                    {
                        onlineuserinfo.Ip = DNTRequest.GetIP();
                    }
                    else
                    {
                        onlineuserinfo.Ip = ip;
                    }
                    onlineuserinfo.Lastposttime = "1900-1-1 00:00:00";
                    onlineuserinfo.Lastpostpmtime = "1900-1-1 00:00:00";
                    onlineuserinfo.Lastsearchtime = "1900-1-1 00:00:00";
                    onlineuserinfo.Lastupdatetime = Utils.GetDateTime();
                    onlineuserinfo.LastCheckInTime = ui.LastCheckInTime;
                    onlineuserinfo.LastCheckInCount = ui.LastCheckInCount;
                    onlineuserinfo.Action = 0;
                    onlineuserinfo.Lastactivity = 0;
                    onlineuserinfo.Verifycode = ForumUtils.CreateAuthStr(5, false);

                    int newPms = PrivateMessages.GetPrivateMessageCount(uid, 0, 1);
                    int newNotices = Notices.GetNewNoticeCountByUid(uid);

                    onlineuserinfo.Newpms = short.Parse(newPms > 1000 ? "1000" : newPms.ToString());
                    onlineuserinfo.Newnotices = short.Parse(newNotices > 1000 ? "1000" : newNotices.ToString());
                    onlineuserinfo.PMSound = ui.Pmsound;
                    //onlineuserinfo.Newfriendrequest = short.Parse(Friendship.GetUserFriendRequestCount(uid).ToString());
                    //onlineuserinfo.Newapprequest = short.Parse(ManyouApplications.GetApplicationInviteCount(uid).ToString());

                    if (DNTRequest.GetPageName() == "sessionajax.aspx")
                    {
                        onlineuserinfo.Olid = -1001;
                        return onlineuserinfo;
                    }


                    try
                    {
                        //�����¼
                        int curolid = OnlineUsers.GetOlidByUid(uid);
                        if (curolid > 0)
                        {
                            PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "DelOnLineUser_New", string.Format("�û�{0}�ٴε�½��ɾ����ǰ���߼�¼��{1}", uid, curolid));
                            Discuz.Data.OnlineUsers.DeleteRows(curolid);
                        }
                        onlineuserinfo.Olid = Discuz.Data.OnlineUsers.CreateOnlineUserInfo(onlineuserinfo, timeout);
                    }
                    catch
                    {
                        System.Threading.Thread.Sleep(200);
                        PTLog.InsertSystemLog(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "InsOnLineUser_Fail", string.Format("�����û����߼�¼ʧ�ܣ�{0} -IP:{1}", uid, onlineuserinfo.Ip));

                        try
                        {
                            //�����ٴβ����¼
                            int curolid = OnlineUsers.GetOlidByUid(uid);
                            if (curolid > 0)
                            {
                                PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "DelOnLineUser_New", string.Format("�û�{0}�ٴε�½��ɾ����ǰ���߼�¼2��{1}", uid, curolid));
                                Discuz.Data.OnlineUsers.DeleteRows(curolid);
                            }
                            onlineuserinfo.Olid = Discuz.Data.OnlineUsers.CreateOnlineUserInfo(onlineuserinfo, timeout);
                        }
                        catch
                        {
                            PTLog.InsertSystemLog(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "InsOnLineUser_Fail", string.Format("�����û����߼�¼ʧ��2��{0} -IP:{1}", uid, onlineuserinfo.Ip));
                            onlineuserinfo.Olid = -1;
                        } 
                    }


                    //�·�Rkey
                    System.Web.HttpContext.Current.Response.Cookies["rkey"].Value = onlineuserinfo.RKey;
                    System.Web.HttpContext.Current.Response.Cookies["rkey"].Expires = DateTime.MaxValue;
                    System.Web.HttpContext.Current.Response.Cookies["rkey"].HttpOnly = true;

                    //////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////
                    //��BT�޸ġ�ȡ���˹���
                    
                    //��������Ա���͹�ע֪ͨ
                    //if (ui.Adminid > 0 && ui.Adminid < 4)
                    //{
                    //    if (Discuz.Data.Notices.ReNewNotice((int)NoticeType.AttentionNotice, ui.Uid) == 0)
                    //    {
                    //        NoticeInfo ni = new NoticeInfo();
                    //        ni.New = 1;
                    //        ni.Note = "�뼰ʱ�鿴<a href=\"modcp.aspx?operation=attention&forumid=0\">��Ҫ��ע������</a>";
                    //        ni.Postdatetime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                    //        ni.Type = NoticeType.AttentionNotice;
                    //        ni.Poster = "";
                    //        ni.Posterid = 0;
                    //        ni.Uid = ui.Uid;
                    //        Notices.CreateNoticeInfo(ni);
                    //    }
                    //}
                    
                    //��END BT�޸ġ�
                    //////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////

                    Discuz.Data.OnlineUsers.SetUserOnlineState(uid, 1);

                    HttpCookie cookie = HttpContext.Current.Request.Cookies["dnt"];
                    if (cookie != null)
                    {
                        cookie.Values["tpp"] = ui.Tpp.ToString();
                        cookie.Values["ppp"] = ui.Ppp.ToString();
                        if (HttpContext.Current.Request.Cookies["dnt"]["expires"] != null)
                        {
                            int expires = TypeConverter.StrToInt(HttpContext.Current.Request.Cookies["dnt"]["expires"].ToString(), 0);
                            if (expires > 0)
                            {
                                cookie.Expires = DateTime.Now.AddMinutes(TypeConverter.StrToInt(HttpContext.Current.Request.Cookies["dnt"]["expires"].ToString(), 0));
                            }
                        }
                    }

                    string cookieDomain = GeneralConfigs.GetConfig().CookieDomain.Trim();
                    if (!Utils.StrIsNullOrEmpty(cookieDomain) && HttpContext.Current.Request.Url.Host.IndexOf(cookieDomain) > -1 && ForumUtils.IsValidDomain(HttpContext.Current.Request.Url.Host))
                        cookie.Domain = cookieDomain;
                    HttpContext.Current.Response.AppendCookie(cookie);
                }
                else
                {
                    onlineuserinfo = CreateGuestUser(timeout, ip);
                }
            }
            else
            {
                onlineuserinfo = CreateGuestUser(timeout, ip);
            }




            return onlineuserinfo;
        }



        //////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////// 
        //��BT�޸ġ���� cngi_login
        
        ///// <summary>
        ///// �û�������Ϣά�����жϵ�ǰ�û������(��Ա�����ο�),�Ƿ��������б��д���,�����������»�Ա�ĵ�ǰ��,����������.
        ///// </summary>
        ///// <param name="passwordkey">�û�����</param
        ///// <param name="timeout">���߳�ʱʱ��</param>
        //public static OnlineUserInfo UpdateInfo(string passwordkey, int timeout, bool cngi_login, string cngi_ip)
        //{
        //    return UpdateInfo(passwordkey, timeout, -1, "", cngi_login, cngi_ip);
        //}


        //ԭʼ������
        /// <summary>
        /// �û�������Ϣά�����жϵ�ǰ�û������(��Ա�����ο�),�Ƿ��������б��д���,�����������»�Ա�ĵ�ǰ��,����������.
        /// ʹ�ô˺���������cookie�л�ȡuid��password��Ϣ��
        /// </summary>
        /// <param name="passwordkey">�û�����</param
        /// <param name="timeout">���߳�ʱʱ��</param>
        public static OnlineUserInfo UpdateInfo(string passwordkey, int timeout)
        {
            string ip = DNTRequest.GetIP();
            int userid = TypeConverter.StrToInt(ForumUtils.GetCookie("userid"), -1);
            string password = ForumUtils.GetCookiePassword(passwordkey);
            return UpdateInfo(passwordkey, timeout, ip, userid, password, false);
        }

        /// <summary>
        /// �û�������Ϣά�����жϵ�ǰ�û������(��Ա�����ο�),�Ƿ��������б��д���,�����������»�Ա�ĵ�ǰ��,����������.
        /// ����uid��passwd���˺�����login��cngiloginҳ����ã�����ʱcookie��Ϣ���ܻ�δ���£������Ҫ����uid��passwd
        /// �˴���passwd��MD5���룬��DES���ܵ�
        /// </summary>
        /// <param name="passwordkey">��̳passwordkey</param>
        /// <param name="timeout">���߳�ʱʱ��</param>
        /// <param name="passwd">MD5���룬��DES���ܵ�</param>
        public static OnlineUserInfo UpdateInfo(string passwordkey, int timeout, int uid, string passwd)
        {
            string ip = DNTRequest.GetIP();
            int userid = TypeConverter.StrToInt(ForumUtils.GetCookie("userid"), uid);

            //ԭ��DNT����������߼�������Ϊ�գ����cookie��ȡMD5���룬������Ϊ������ԭʼ��DES���ܵ�MD5����
            //string password = (Utils.StrIsNullOrEmpty(passwd) ? ForumUtils.GetCookiePassword(passwordkey) : ForumUtils.GetCookiePassword(passwd, passwordkey));
            
            //�µĺ���������Ϊ�գ���cookie��ȡ������ֱ��ʹ��passwd��ΪMD5����
            string password = (Utils.StrIsNullOrEmpty(passwd) ? ForumUtils.GetCookiePassword(passwordkey) : passwd);
            return UpdateInfo(passwordkey, timeout, ip, userid, password, false);
        }



        private static object SynObjectCreateOnlineUser = new object();
        private static object SynObjectUpdateOnlineRkey = new object();
        /// <summary>
        /// ��ȡ�û�olid��olineinfo
        /// �û�������Ϣά�����жϵ�ǰ�û������(��Ա�����ο�),�Ƿ��������б��д���,�����������»�Ա�ĵ�ǰ��,����������.
        /// </summary>
        /// <param name="passwordkey">��̳passwordkey</param>
        /// <param name="timeout">���߳�ʱʱ��</param>
        /// <param name="passwd">�û����루MD5��</param>
        /// <param name="ip"></param>
        /// <param name="userid"></param>
        /// <param name="cngi_login"></param>
        /// <param name="cngi_ip"></param>
        /// <returns></returns>
        public static OnlineUserInfo UpdateInfo(string passwordkey, int timeout, string ip, int userid, string password, bool cngi_login)
        {
            //���ڴ˴�֮ǰ�汾��Ҫlock��ԭ��
            //Ϊ��֤online���û���Ψһ�ԣ���ֹͬʱ�޸�����,lockΪȫ��������֤�˶δ���ȫ�ֲ���ͬʱִ�У���ֹ�����ظ����οͼ�¼���������û���¼
            // lock ----> ��online���ȡ���� ---->   NULL  ----> ���cookie����   ---->  ��ȷ ----> �û�����online
            //      |                        |                                    |
            //      |                        |                                    ---->  ���� ----> �����ο�
            //      |                        ---->   ����userid��¼  --> ���cookie����  ---> ��ȷ --->����online
            //      |                                                                    |
            //      |                                                                    --->  ���� ---> �����ο�
            //      ----> cookie�в������û���¼ ->  �����ο�                                                                    
            //                                                                           
            //ԭ��ϵͳ���ο͵�userid��Ϊ-1��ʹ��ip���ֲ�ͬ�οͣ���ͬip���û�����һ���ο�olid������˲����û���֤��ˢ�²�����
            //������ʹ��ipv6���ʵ��û�����Ϊipv6��ַ���ضϣ������ظ���
            //ԭ��ϵͳ����ͬһ���˺Ŷ�ص�ͬʱ��½������һ��olid��ͬ���������֤�����⣩��ֻ���ڲ�ͣ�ĸ����û�ip
            //
            //��������ip�����οͣ���ᵼ���ο͵���֤�����⣿���� 
            //
 
            

            //lock (SynObject)
            //{
                OnlineUserInfo onlineuser = new OnlineUserInfo();
                password = (Utils.StrIsNullOrEmpty(password) ? ForumUtils.GetCookiePassword(passwordkey) : password);
                int cookie_uid = userid;
                          
                // ��������Base64�����ַ������ɱ��Ƿ��۸�, ֱ�������Ϊ�ο͡�CNGI��½�����˴�password
                if (!cngi_login && userid > 0 && (password.Length == 0 || !Utils.IsBase64String(password)))
                    userid = -1;

                if (userid > 0) //Cookie�д����û�id�����û��Ѿ�CNGI��¼
                {
                    onlineuser = GetOnlineUser(userid, password);
                    //��������ͳ��
                    if (!DNTRequest.GetPageName().EndsWith("ajax.aspx") && GeneralConfigs.GetConfig().Statstatus == 1)
                        Stats.UpdateStatCount(false, onlineuser != null);



                    //��ǰ�û�δ����
                    if (onlineuser == null) 
                    {
                        //�ж�Cookie�е������Ƿ���ȷ
                        int ckuserid = PTUsers.CheckCookiePassword(userid, password);
                        string rkeyold = PTUsers.GetUserRKey(userid);

                        if (ckuserid > 0 && Utils.GetCookie("rkey") == rkeyold)
                        {
                            #region �û���ǰ�����ߣ�Password��ȷ��Rkey��ȷ�����������û���Ϣ

                            //������ȷ������������Ϣ //Discuz.Data.OnlineUsers.DeleteRowsByIP(ip); //????????Ϊʲô    
                            
                            int createuserok = 0;

                            //���ڲ�������ĸ���
                            lock (SynObjectCreateOnlineUser)
                            {
                                onlineuser = GetOnlineUser(userid, password);
                                if (onlineuser == null)
                                {
                                    createuserok = 1;
                                    onlineuser = CreateUser(ckuserid, timeout, ip, rkeyold, 0);
                                    
                                    //sessionajaxҳ�棬���ʳɹ�ʱ��ֱ�ӷ��أ���û�м���online��
                                    if (onlineuser.Olid == -1001) return onlineuser;
                                }
                            }

                            if (createuserok == 1)
                            {
                                if (onlineuser == null)
                                {
                                    PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "CreateFail",
                                        string.Format("UID:{0} -IP:{1} -ORKEY:{2} -NRKEY:{3}", userid, ip, Utils.GetCookie("rkey"), PTUsers.GetUserRKey(userid)));

                                    AddUserLoginRecord(userid, "[CREATE_FAIL]", onlineuser.Groupid, ip, 13, 2, password, Utils.GetCookie("rkey"));

                                    //�����ο���Ϣ
                                    return GetGuestOlinfo(timeout, ip);
                                }
                                else
                                {
                                    //����user���Rkey��¼
                                    PTUsers.UpdateUserRKey(ckuserid, onlineuser.RKey);
                                }

                                #region CNGI RKey�Ķ���У�鴦��

                                //CNGI��½�Ķ���У��
                                //��RKey��ͷΪ��CN_���������ΪCNGI��½��==10�ж�Ϊ��֤substring������
                                if (Utils.GetCookie("rkey").Length != 10 || Utils.GetCookie("rkey").Substring(0, 3) == "CN_")
                                {
                                    if (!cngi_login)
                                    {
                                        AddUserLoginRecord(userid, onlineuser.Username, onlineuser.Groupid, ip, 13, 2, password, Utils.GetCookie("rkey"));

                                        ForumUtils.ClearUserCookie();
                                        Utils.WriteCookie(Utils.GetTemplateCookieName(), "", -999999);
                                        System.Web.HttpCookie cookie = new System.Web.HttpCookie("dntadmin");
                                        cookie.HttpOnly = true;
                                        System.Web.HttpContext.Current.Response.AppendCookie(cookie);

                                        //�����ο�
                                        onlineuser = GetOnlineUserByRkey(-1, Utils.GetCookie("rkey"));

                                        if (onlineuser == null)
                                        {
                                            onlineuser = CreateGuestUser(timeout, ip);
                                            return onlineuser;
                                        }
                                        else
                                            return onlineuser;
                                    }
                                    else
                                    {
                                        AddUserLoginRecord(userid, onlineuser.Username, onlineuser.Groupid, ip, 13, 1, password, Utils.GetCookie("rkey"));
                                    }
                                }

                                #endregion

                                //������ȷ��Cookie/CNGI��½�ɹ�//֮ǰҪ�ȴ���onlineuser����Ȼ��null��
                                AddUserLoginRecord(userid, onlineuser.Username, onlineuser.Groupid, ip, 11, 1, password, Utils.GetCookie("rkey"));

                                return onlineuser;
                            }
                            else if(createuserok == 0)
                            {
                                PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "ConCurent_Create",
                                        string.Format("UID:{0} -IP:{1} -ORKEY:{2} -NRKEY:{3} --PAGE:{4}", userid, ip, Utils.GetCookie("rkey"), PTUsers.GetUserRKey(userid), DNTRequest.GetPageName()));


                            }
                            
                            #endregion
                        }
                        else
                        {
                            #region �û���ǰ�����ߣ�Password��Rkey��������Ϊ�ο�
                            //��������RkeyʧЧ

                            #region CNGI��½�����

                            if (cngi_login)
                            {
                                //CNGI��½�������û�ǰ��Ҫɾ��online����ԭ�д�uid�ļ�¼����ΪCNGI��½passwordֵ�п���Ϊ��
                                Discuz.Data.OnlineUsers.DeleteRows(Discuz.Data.OnlineUsers.GetOlidByUid(cookie_uid));

                                //����Cookie��RKey
                                ForumUtils.ClearUserCookie();
                                ForumUtils.WriteUserCookie(cookie_uid, 0, passwordkey, 0, -1);

                                onlineuser = CreateUser(cookie_uid, timeout, ip, rkeyold, 1);

                                if (onlineuser == null)
                                {
                                    AddUserLoginRecord(cookie_uid, "[CNGI_NULL]", -1, ip, 13, 3, password, Utils.GetCookie("rkey"));
                                    onlineuser = CreateGuestUser(timeout, ip);
                                    return onlineuser;
                                }

                                //CNGI������½����һ��ʱ�������cookie��û��password
                                //CNGI�Ѿ���¼������ʱ�û������������ٴε�¼�����ȴ�20����ϵͳɾ�������û�����ʣ�����ɴ��������ΪCNGI���µ�½
                                AddUserLoginRecord(cookie_uid, onlineuser.Username, onlineuser.Groupid, ip, 13, 3, password, Utils.GetCookie("rkey"));

                                return onlineuser;
                            }

                            #endregion

                            //sessionajaxҳ�����⴦��������û�cookie
                            //��Ϊ�кܶ����������sessionajaxҳ�治��cookie��������
                            if (DNTRequest.GetPageName() == "sessionajax.aspx")
                            {
                                if (ckuserid > 0)
                                {
                                    //Rkey����
                                    AddUserLoginRecord(cookie_uid, "[RKEY_EXPIRE]", 0, ip, 11, 2, password, Utils.GetCookie("rkey"));

                                    PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Detail, "Offline_PassRkey_Fail",string.Format("UID:{0} -IP:{1} -ORKEY:{2} -NRKEY:{3}", userid, ip, Utils.GetCookie("rkey"), PTUsers.GetUserRKey(userid)));
                                }
                                else
                                {
                                    //Pass����
                                    AddUserLoginRecord(cookie_uid, "[PASS_EXPIRE]", 0, ip, 11, 2, password, Utils.GetCookie("rkey"));

                                    PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Detail, "Offline_Password_Fail", string.Format("UID:{0} -IP:{1} -ORKEY:{2} -NRKEY:{3}", userid, ip, Utils.GetCookie("rkey"), PTUsers.GetUserRKey(userid)));
                                }

                                //���ؿհ���Ϣ
                                return EmptyOlinfo(2048, userid, ip);
                            }
                            else
                            {
                                if (ckuserid > 0)
                                {
                                    //Rkey����
                                    AddUserLoginRecord(cookie_uid, "[RKEY_EXPIRE_C]", 0, ip, 11, 2, password, Utils.GetCookie("rkey"));

                                    PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Detail, "Offline_RkeyE_CCook", string.Format("UID:{0} -IP:{1} -ORKEY:{2} -NRKEY:{3}", userid, ip, Utils.GetCookie("rkey"), PTUsers.GetUserRKey(userid)));
                                }
                                else
                                {
                                    //Pass����
                                    AddUserLoginRecord(cookie_uid, "[PASS_EXPIRE_C]", 0, ip, 11, 2, password, Utils.GetCookie("rkey"));

                                    PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Detail, "Offline_PassE_CCook", string.Format("UID:{0} -IP:{1} -ORKEY:{2} -NRKEY:{3}", userid, ip, Utils.GetCookie("rkey"), PTUsers.GetUserRKey(userid)));
                                }

                                //����û���ǰ��Cookie��Ϣ
                                ForumUtils.ClearUserCookie();

                                //�����ο���Ϣ
                                return GetGuestOlinfo(timeout, ip);
                            }
                                
                            

                            #endregion
                        }
                    }



                    //��ǰ�û�����
                    if(onlineuser != null)
                    {
                        if (Utils.GetCookie("rkey") == onlineuser.RKey || (Utils.GetCookie("rkey") == onlineuser.RkeyExpire && DateTime.Now < onlineuser.RkeyExpireTime))
                        {
                            #region �����û���Rkey��ȷ����Rkeyexpire��ȷ����ȡ��ǰ�û���Ϣ

                            #region CNGI Cookieȷ��

                            //��RKey��ͷΪ��CN_���������ΪCNGI��½��==10�ж�Ϊ��֤substring������
                            if (Utils.GetCookie("rkey").Length != 10 || Utils.GetCookie("rkey").Substring(0, 3) == "CN_")
                            {
                                if (!cngi_login)
                                {
                                    //RKey״̬ΪCNGI��½������CNGI��½ʧ�ܣ���δ�ܻ�ȡcngi_name��
                                    AddUserLoginRecord(userid, onlineuser.Username, onlineuser.Groupid, ip, 3, 2, password, Utils.GetCookie("rkey"));

                                    //�˴�������Cookie����ΪCNGI��½�������ִ�������Ʋ�ͻ�����CNGI��IP����ʱ���ᵼ�´�����cngi_name�ᶪʧ����Ҫ������ת��½
                                    
                                    //ForumUtils.ClearUserCookie();
                                    //Utils.WriteCookie(Utils.GetTemplateCookieName(), "", -999999);
                                    //System.Web.HttpCookie cookie = new System.Web.HttpCookie("dntadmin");
                                    //cookie.HttpOnly = true;
                                    //System.Web.HttpContext.Current.Response.AppendCookie(cookie);

                                    //�����ο�
                                    onlineuser = GetOnlineUserByRkey(-1, Utils.GetCookie("rkey"));
                                    if (onlineuser == null)
                                    {
                                        onlineuser = CreateGuestUser(timeout, ip);
                                        return onlineuser;
                                    }
                                    else
                                        return onlineuser;
                                }
                            }

                            #endregion

                            if (Utils.GetCookie("rkey") == onlineuser.RKey)
                            {
                                //��ͨ��½��ʽ��ʹ��RKeyȷ�ϵ�½
                                if (cngi_login) AddUserLoginRecord(userid, onlineuser.Username, onlineuser.Groupid, ip, 3, 1, password, Utils.GetCookie("rkey"));
                                else AddUserLoginRecord(userid, onlineuser.Username, onlineuser.Groupid, ip, 1, 1, password, Utils.GetCookie("rkey"));


                                //IP��ַ����������·�Rkey
                                if (onlineuser.Ip != ip)
                                {
                                    if ((PTTools.IsIPv4(ip) && PTTools.IsIPv6(onlineuser.Ip)) || (PTTools.IsIPv4(onlineuser.Ip) && PTTools.IsIPv6(ip)))
                                    {
                                        //���IP����Ipv4��IPv6��仯����ʱ��������ֻ����IP
                                        PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Detail, "IPChange_Keep", string.Format("UID:{0} -OIP:{1} - NIP:{2} -OldRKEY:{3} --PAGE:{4}", userid, onlineuser.Ip, ip, Utils.GetCookie("rkey"), DNTRequest.GetPageName()));
                                    }
                                    else
                                    {
                                        string newreky = PTTools.GetRandomString(10, true);
                                        
                                        //���ڲ�������ĸ���
                                        bool updaterkey = false;
                                        lock (SynObjectUpdateOnlineRkey)
                                        {
                                            onlineuser = onlineuser = GetOnlineUser(userid, password);
                                            if (Utils.GetCookie("rkey") == onlineuser.RKey)
                                            {
                                                updaterkey = true;
                                                PTUsers.SetOnlineRKey(userid, newreky);
                                            } 
                                        }   
                                        
                                        //IP��ַ���ģ�����Rkey��Ϣ
                                        if (updaterkey)
                                        {
                                            PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "IPChange_NewReky", string.Format("UID:{0} -OIP:{1} - NIP:{2} -OldRKEY:{3} -NewRKEY:{4}", userid, onlineuser.Ip, ip, Utils.GetCookie("rkey"), newreky));

                                            onlineuser.RKey = newreky;
                                        }
                                        else
                                        {
                                            PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "ConCurent_RkeyU", string.Format("UID:{0} -IP:{1} -ORKEY:{2} -NRKEY:{3}", userid, ip, Utils.GetCookie("rkey"), PTUsers.GetUserRKey(userid)));
                                        }
                                    }

                                    onlineuser.Ip = ip;
                                    UpdateIP(onlineuser.Olid, ip);
                                }
                            }
                            else
                            {
                                AddUserLoginRecord(userid, "[ExpThru]", onlineuser.Groupid, ip, 1, 1, password, Utils.GetCookie("rkey"));

                                //Rkey����5�����ڣ������ip����
                                PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "RKey_ExpireThru",
                                            string.Format("UID:{0} -OIP:{1} - NIP:{2} -CookieRKEY:{3} -RKEY:{4} -RKEYEX:{5} --PAGE:{6}", userid, onlineuser.Ip, ip, Utils.GetCookie("rkey"), onlineuser.RKey, onlineuser.RkeyExpire, DNTRequest.GetPageName()));

                                if (onlineuser.Ip == ip)
                                {
                                    //���IP��ͬ��Rkey��ͬ��������·�Rkey
                                    System.Web.HttpContext.Current.Response.Cookies["rkey"].Value = onlineuser.RKey;
                                    System.Web.HttpContext.Current.Response.Cookies["rkey"].Expires = DateTime.MaxValue;
                                    System.Web.HttpContext.Current.Response.Cookies["rkey"].HttpOnly = true;
                                }
                            }
                            
                            //���ص�ǰ�û���Ϣ
                            return onlineuser;

                            #endregion
                        }
                        else
                        {
                            #region �����û���Rkey����ȷ��Ҫ�����µ�½

                            //Rkey��ͬ����Ҫ���µ�¼

                            #region CNGI�������

                            if (cngi_login)
                            {
                                // CNGI��¼��IP�ı䣬CNGI���ȣ�����������RKey���û���CNGI��½����������������½�ɵ��´����
                                AddUserLoginRecord(userid, onlineuser.Username, onlineuser.Groupid, ip, 13, 1, password, Utils.GetCookie("rkey"));

                                //����RKey//CNGI��½��RKey�ԡ�CN_����ͷ
                                string rkey = "CN_" + PTTools.GetRandomString(7);
                                PTUsers.SetUserRKey(userid, rkey);

                                if (onlineuser.Ip != ip)
                                {
                                    UpdateIP(onlineuser.Olid, ip);
                                    onlineuser.Ip = ip; 
                                }
                                return onlineuser;
                            }

                            #endregion 

                            //����Rkey�����µĵ�½ʧ�ܣ����������û���Ϣ����������
                            if (DNTRequest.GetPageName() == "sessionajax.aspx")
                            {
                                //���߹�����RKey����
                                AddUserLoginRecord(userid, "[RKEY_ERR]", onlineuser.Groupid, ip, 1, 2, password, Utils.GetCookie("rkey"));

                                PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "Online_RkeyFail",string.Format("UID:{0} -OIP:{1} - NIP:{2} -CookieRKEY:{3} -RKEY:{4}", userid, onlineuser.Ip, ip, Utils.GetCookie("rkey"), PTUsers.GetUserRKey(userid)));

                                //���ؿհ��û���Ϣ
                                return EmptyOlinfo(2048, userid, ip);
                            }
                            else
                            {
                                AddUserLoginRecord(userid, "[RKEY_ERR_C]", onlineuser.Groupid, ip, 1, 2, password, Utils.GetCookie("rkey"));

                                PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Warning, "Online_RKeyECCookies",string.Format("UID:{0} -IP:{1} -ORKEY:{2} -NRKEY:{3}", userid, ip, Utils.GetCookie("rkey"), PTUsers.GetUserRKey(userid)));

                                //RKey������Ϊ�ο�
                                ForumUtils.ClearUserCookie();

                                //�����ο���Ϣ
                                return GetGuestOlinfo(timeout, ip);
                            }

                            #endregion
                        }

                    }
                    else
                    {
                        //�����ܳ��ֵ����
                        //���ؿհ��û���Ϣ
                        AddUserLoginRecord(userid, "[ERR]", -1, ip, 220, 220, password, Utils.GetCookie("rkey"));

                        PTLog.InsertSystemLogDebug(PTLog.LogType.OnlineUser, PTLog.LogStatus.Error, "ERR",  string.Format("UID:{0} -IP:{1} -ORKEY:{2}", userid, ip, Utils.GetCookie("rkey")));

                        return EmptyOlinfo(2048, userid, ip);
                    }
                }
                else
                {
                    #region Cookies�����û���¼���ο�

                    //Cookie�в������û���Ϣ���οͷ���
                    string userrkey = System.Web.HttpContext.Current.Request.Cookies["rkey"] !=null ? System.Web.HttpContext.Current.Request.Cookies["rkey"].Value : "";
                    
                    if (userrkey != null && userrkey.Trim().Length == 10)
                        onlineuser = GetOnlineUserByRkey(-1, userrkey.Trim());
                    else onlineuser = null;

                    //��������ͳ��
                    if (!DNTRequest.GetPageName().EndsWith("ajax.aspx") && GeneralConfigs.GetConfig().Statstatus == 1)
                        Stats.UpdateStatCount(true, onlineuser != null);

                    //�οͷ��ʼ�¼
                    AddUserLoginRecord(0, "NULL", 0, ip, 1, 2, password, Utils.GetCookie("rkey"));

                    //�����ο���Ϣ
                    return GetGuestOlinfo(timeout, ip);

                    #endregion
                }

                //onlineuser.Lastupdatetime = Utils.GetDateTime();  Ϊ�˿ͻ����ܹ���¼ע�ʹ˾䣬�����������޸ġ�
                //return onlineuser;
            //}
        }

        private static OnlineUserInfo GetGuestOlinfo(int timeout, string ip)
        {

            OnlineUserInfo onlineuser = GetOnlineUserByRkey(-1, Utils.GetCookie("rkey"));
            if (onlineuser == null)
            {
                onlineuser = CreateGuestUser(timeout, ip);
                return onlineuser;
            }
            else
                return onlineuser;

        }

        /// <summary>
        /// ��onlineuserinfo�����ڴ��ݴ�����Ϣ
        /// </summary>
        /// <param name="eid"></param>
        /// <param name="uid"></param>
        /// <returns></returns>
        private static OnlineUserInfo EmptyOlinfo(int eid, int uid, string ip)
        {
            OnlineUserInfo onlineuserinfo = new OnlineUserInfo();
            onlineuserinfo.Olid = -eid;
            onlineuserinfo.Userid = uid;
            onlineuserinfo.Username = "[" + eid.ToString() + "]";

            //onlineuserinfo.Username = "�ο�";
            onlineuserinfo.Nickname = "�ο�";
            onlineuserinfo.Password = "";
            onlineuserinfo.Groupid = 7;
            onlineuserinfo.Olimg = GetGroupImg(7);
            onlineuserinfo.Adminid = 0;
            onlineuserinfo.Invisible = 0;
            onlineuserinfo.Lastposttime = "1900-1-1 00:00:00";
            onlineuserinfo.Lastpostpmtime = "1900-1-1 00:00:00";
            onlineuserinfo.Lastsearchtime = "1900-1-1 00:00:00";
            onlineuserinfo.Lastupdatetime = Utils.GetDateTime();
            onlineuserinfo.Action = 0;
            onlineuserinfo.Lastactivity = 0;
            onlineuserinfo.Verifycode = ForumUtils.CreateAuthStr(5, false);

            onlineuserinfo.RKey = PTTools.GetRandomString(10, true);

            if (Utils.StrIsNullOrEmpty(ip))
            {
                onlineuserinfo.Ip = DNTRequest.GetIP();
            }
            else
            {
                onlineuserinfo.Ip = ip;
            }

            return onlineuserinfo;
        }


        //////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////// 
        //��BT�޸ġ����

        /// <summary>
        /// ��ӵ�½��־
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="ip"></param>
        /// <param name="type">1.cookie��2.password��3.CNGI + cookie��4. CNGI��֤��5.cookie + rkey�� 6.CNGI������RKey</param>
        /// <param name="ok">1.pass��2.fail</param>
        /// <returns></returns>
        public static int AddUserLoginRecord(int uid, string ip, int type, int ok, string msg)
        {
            string url = "http://" + System.Web.HttpContext.Current.Request.Url.Host + System.Web.HttpContext.Current.Request.RawUrl;
            string agent = System.Web.HttpContext.Current.Request.UserAgent;
            return PrivateBT.AddUserLoginRecord(uid, ip, type, ok, DateTime.Now, url, agent, msg);
        }
        /// <summary>
        /// ��ӵ�½��־��typeż����Ϊhttps����....���ʷ�ʽ��Cookieά��1��CNGIά��3��Cookie��½11��CNGI��½13��SSO��½15�������½21��CNGI�󶨵�½23��SSO�󶨵�½25����̨��½31������ע���½41��CNGIע��43��SSOע��45
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="ip"></param>
        /// <param name="type">���ʷ�ʽ��Cookieά��1��CNGIά��3��Cookie��½11��CNGI��½13��SSO��½15�������½21��CNGI�󶨵�½23��SSO�󶨵�½25����̨��½31������ע���½41��CNGIע��43��SSOע��45</param>
        /// <param name="result">1.PASSͨ����2.FAILʧ��</param>
        /// <returns></returns>
        public static int AddUserLoginRecord(int uid, string username, int usergroup, string ip, int type, int result, string md5, string rkey)
        {
            if (type < 0) type = 255;
            if (result < 0) result = 255;
            string domain = System.Web.HttpContext.Current.Request.Url.Host;
            string url = System.Web.HttpContext.Current.Request.RawUrl;
            string agent = System.Web.HttpContext.Current.Request.UserAgent;
            if (System.Web.HttpContext.Current.Request.ServerVariables["HTTPS"] == "on")
            {
                type += 1;
                domain = "https://" + domain;
            }
            else
            {
                domain = "http://" + domain;
            }

            if (md5.Length > 5) md5 = md5.Substring(0, 5);
            if (rkey.Length > 5) rkey = rkey.Substring(0, 5);

            //���ڷ��ʹ���Ƶ��������¼�ɹ���/tools/sessionajax.aspx?t=newpmcount��/tools/sessionajax.aspx?t=newnoticecount || url == "/tools/sessionajax.aspx?t=newnoticecount"
            if (result == 1 && url == "/tools/sessionajax.aspx?t=newpmnoticecount")
                return -2;

            return PrivateBT.AddUserAccessLog(uid, username, usergroup, type, result, DateTime.Now, ip, agent, domain, url, md5, rkey, DNTRequest.IsPost());
        }
        //��END BT�޸ġ�
        //////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////


        /// <summary>
        /// ���ip��ַ�Ƿ�Ϸ�
        /// </summary>
        /// <param name="ip"></param>
        private static void CheckIp(string ip)
        {
            string errmsg = "";
            //�ж�IP��ַ�Ƿ�Ϸ�,��Ҫ�ع�
            Discuz.Common.Generic.List<IpInfo> list = Caches.GetBannedIpList();

            foreach (IpInfo ipinfo in list)
            {
                if (ip == (string.Format("{0}.{1}.{2}.{3}", ipinfo.Ip1, ipinfo.Ip2, ipinfo.Ip3, ipinfo.Ip4)))
                {
                    errmsg = "����ip����,��" + ipinfo.Expiration + "����";
                    break;
                }

                if (ipinfo.Ip4.ToString() == "*")
                {
                    if ((TypeConverter.StrToInt(ip.Split('.')[0], -1) == ipinfo.Ip1) && (TypeConverter.StrToInt(ip.Split('.')[1], -1) == ipinfo.Ip2) && (TypeConverter.StrToInt(ip.Split('.')[2], -1) == ipinfo.Ip3))
                    {
                        errmsg = "�����ڵ�ip�α���,��" + ipinfo.Expiration + "����";
                        break;
                    }
                }
            }

            if (errmsg != string.Empty)
                HttpContext.Current.Response.Redirect(BaseConfigs.GetForumPath + "tools/error.htm?forumpath=" + BaseConfigs.GetForumPath + "&templatepath=default&msg=" + Utils.UrlEncode(errmsg));
        }

        #endregion

        #region �����û���Ϣ����

        /// <summary>
        /// �����û��ĵ�ǰ�����������Ϣ
        /// </summary>
        /// <param name="olid">�����б�id</param>
        /// <param name="action">����</param>
        /// <param name="inid">����λ�ô���</param>
        /// <param name="timeout">����ʱ��</param>
        public static void UpdateAction(int olid, int action, int inid, int timeout)
        {
            // ����ϴ�ˢ��cookie���С��5����, ��ˢ�����ݿ����ʱ��
            if ((timeout < 0) && (Environment.TickCount - TypeConverter.StrToInt(Utils.GetCookie("lastolupdate"), Environment.TickCount) < 300000))
                Utils.WriteCookie("lastolupdate", Environment.TickCount.ToString());
            else
                UpdateAction(olid, action, inid);
        }

        /// <summary>
        /// �����û��ĵ�ǰ�����������Ϣ
        /// </summary>
        /// <param name="olid">�����б�id</param>
        /// <param name="action">����</param>
        /// <param name="inid">����λ�ô���</param>
        public static void UpdateAction(int olid, int action, int inid)
        {
            if (GeneralConfigs.GetConfig().Onlineoptimization != 1)
            {
                Discuz.Data.OnlineUsers.UpdateAction(olid, action, inid);
            }
        }


        /// <summary>
        /// �����û��ĵ�ǰ�����������Ϣ
        /// </summary>
        /// <param name="olid">�����б�id</param>
        /// <param name="action">����id</param>
        /// <param name="fid">���id</param>
        /// <param name="forumname">�����</param>
        /// <param name="tid">����id</param>
        /// <param name="topictitle">������</param>
        /// 
        public static void UpdateAction(int olid, int action, int fid, string forumname, int tid, string topictitle)
        {
            bool isupdate = false;
            forumname = forumname.Length > 40 ? forumname.Substring(0, 37) + "..." : forumname;
            topictitle = topictitle.Length > 40 ? topictitle.Substring(0, 37) + "..." : topictitle;
            if (action == UserAction.PostReply.ActionID || action == UserAction.PostTopic.ActionID)
            {
                if (GeneralConfigs.GetConfig().PostTimeStorageMedia == 0 || Utils.GetCookie("lastposttime") == "")//�����⵽�û��ĸ�cookieֵΪ��(���û�����cookie)������Ҫͨ���������ݿ������б���ȷ����ֵ��׼ȷ�ԣ������ֻ�����û�cookie����֤��ֵ����ȷ��
                    isupdate = true;
                else
                    Utils.WriteCookie("lastposttime", Utils.GetDateTime());
            }
            else if (GeneralConfigs.GetConfig().Onlineoptimization != 1)
            {
                if (System.Environment.TickCount - TypeConverter.StrToInt(Utils.GetCookie("lastolupdate"), System.Environment.TickCount) >= 300000) // ����ϴ�ˢ��cookie���С��5����, ��ˢ�����ݿ����ʱ��
                {
                    if (action == UserAction.ShowForum.ActionID || action == UserAction.ShowTopic.ActionID || action == UserAction.ShowTopic.ActionID || action == UserAction.PostReply.ActionID)
                        isupdate = true;
                }
            }
            if (isupdate)
            {
                Discuz.Data.OnlineUsers.UpdateAction(olid, action, fid, forumname, tid, topictitle);
                Utils.WriteCookie("lastolupdate", System.Environment.TickCount.ToString());
                Utils.WriteCookie("lastposttime", Utils.GetDateTime());
            }
        }

        /// <summary>
        /// �����û����ʱ��
        /// </summary>
        /// <param name="olid">����id</param>
        /// <param name="timeout">��ʱʱ��</param>
        private static void UpdateLastTime(int olid, int timeout)
        {
            // ����ϴ�ˢ��cookie���С��5����, ��ˢ�����ݿ����ʱ��
            if ((timeout < 0) && (System.Environment.TickCount - TypeConverter.StrToInt(Utils.GetCookie("lastolupdate"), System.Environment.TickCount) < 300000))
                Utils.WriteCookie("lastolupdate", System.Environment.TickCount.ToString());
            else
                Discuz.Data.OnlineUsers.UpdateLastTime(olid);
        }


        /// <summary>
        /// �����û���󷢶���Ϣʱ��
        /// </summary>
        /// <param name="olid">����id</param>
        public static void UpdatePostPMTime(int olid)
        {
            if (GeneralConfigs.GetConfig().Onlineoptimization != 1)
            {
                Discuz.Data.OnlineUsers.UpdatePostPMTime(olid);
            }
        }

        /// <summary>
        /// �������߱���ָ���û��Ƿ�����
        /// </summary>
        /// <param name="olid">����id</param>
        /// <param name="invisible">�Ƿ�����</param>
        public static void UpdateInvisible(int olid, int invisible)
        {
            if (GeneralConfigs.GetConfig().Onlineoptimization != 1)
            {
                Discuz.Data.OnlineUsers.UpdateInvisible(olid, invisible);
            }
        }

        /// <summary>
        /// �������߱���ָ���û����û�����
        /// </summary>
        /// <param name="olid">����id</param>
        /// <param name="password">�û�����</param>
        public static void UpdatePassword(int olid, string password)
        {
            Discuz.Data.OnlineUsers.UpdatePassword(olid, password);
        }


        /// <summary>
        /// �����û�IP��ַ
        /// </summary>
        /// <param name="olid">����id</param>
        /// <param name="ip">ip��ַ</param>
        public static void UpdateIP(int olid, string ip)
        {
            Discuz.Data.OnlineUsers.UpdateIP(olid, ip);
        }

        /// <summary>
        /// �����û��������ʱ��
        /// </summary>
        /// <param name="olid">����id</param>
        //public static void UpdateSearchTime(int olid)
        //{
        //    if (GeneralConfigs.GetConfig().Onlineoptimization != 1)
        //    {
        //        Discuz.Data.OnlineUsers.UpdateSearchTime(olid);
        //    }
        //}

        #endregion

        /// <summary>
        /// ɾ�����߱���ָ������id����
        /// </summary>
        /// <param name="olid">����id</param>
        /// <returns></returns>
        public static int DeleteRows(int olid)
        {
            return Discuz.Data.OnlineUsers.DeleteRows(olid);
        }

        #region ��������ķ���

        /// <summary>
        /// ���������û��б�
        /// </summary>
        /// <param name="totaluser">ȫ���û���</param>
        /// <param name="guest">�ο���</param>
        /// <param name="user">��¼�û���</param>
        /// <param name="invisibleuser">�����Ա��</param>
        /// <returns></returns>
        public static Discuz.Common.Generic.List<OnlineUserInfo> GetForumOnlineUserCollection(int forumid, out int totaluser, out int guest, out int user, out int invisibleuser)
        {
            Discuz.Common.Generic.List<OnlineUserInfo> coll = Discuz.Data.OnlineUsers.GetForumOnlineUserCollection(forumid);

            //�����ο�
            guest = 0;
            //���������û�
            invisibleuser = 0;
            //��ǰ����������û���
            totaluser = coll.Count;

            foreach (OnlineUserInfo onlineUserInfo in coll)
            {
                if (onlineUserInfo.Userid < 1)
                    guest++;

                if (onlineUserInfo.Invisible == 1)
                    invisibleuser++;
            }

            //ͳ���û�
            user = totaluser - guest;
            //���ص�ǰ���������û���
            return coll;
        }


        /// <summary>
        /// ���������û��б�
        /// </summary>
        /// <param name="totaluser">ȫ���û���</param>
        /// <param name="guest">�ο���</param>
        /// <param name="user">��¼�û���</param>
        /// <param name="invisibleuser">�����Ա��</param>
        /// <returns></returns>
        public static Discuz.Common.Generic.List<OnlineUserInfo> GetOnlineUserCollection(out int totaluser, out int guest, out int user, out int invisibleuser)
        {
            Discuz.Common.Generic.List<OnlineUserInfo> coll = Discuz.Data.OnlineUsers.GetOnlineUserCollection();

            //����ע���û���
            user = 0;
            //���������û���
            invisibleuser = 0;

            //�������б������ο�ʱ,��ζ'GetOnlineUserCollection()'�������������߱������м�¼
            if (GeneralConfigs.GetConfig().Whosonlinecontract == 0)
                totaluser = coll.Count;
            else
                totaluser = OnlineUsers.GetOnlineAllUserCount();//������Ҫ���»�ȡȫ���û���

            foreach (OnlineUserInfo onlineUserInfo in coll)
            {
                if (onlineUserInfo.Userid > 0)
                    user++;

                if (onlineUserInfo.Invisible == 1)
                    invisibleuser++;
            }

            if (totaluser > TypeConverter.StrToInt(Statistics.GetStatisticsRowItem("highestonlineusercount"), 1))
            {
                if (Statistics.UpdateStatistics("highestonlineusercount", totaluser.ToString()) > 0)
                {
                    Statistics.UpdateStatistics("highestonlineusertime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                    Statistics.ReSetStatisticsCache();
                }
            }

            //ͳ���ο�
            guest = totaluser > user ? totaluser - user : 0;

            //���ص�ǰ���������û�����
            return coll;
        }

        /// <summary>
        /// ��������ʱ��
        /// </summary>
        /// <param name="oltimespan">����ʱ����</param>
        /// <param name="uid">��ǰ�û�id</param>
        public static void UpdateOnlineTime(int oltimespan, int uid)
        {
            //Ϊ0����ر�ͳ�ƹ���
            if (oltimespan != 0)
            {
                if (Utils.StrIsNullOrEmpty(Utils.GetCookie("lastactivity", "onlinetime")))
                    Utils.WriteCookie("lastactivity", "onlinetime", System.Environment.TickCount.ToString());

                //���ϴθ������ݿ����û�����ʱ��󵽵�ǰ��ʱ����
                int oltime = System.Environment.TickCount - TypeConverter.StrToInt(Utils.GetCookie("lastactivity", "onlinetime"), System.Environment.TickCount);
                if (oltime <= 0 /*TickCount 49���ϵͳ�����㣬�����ɸ�ֵΪ��*/ 
                    || oltime >= oltimespan * 60 * 1000)
                {
                    Discuz.Data.OnlineUsers.UpdateOnlineTime(oltimespan, uid);
                    Utils.WriteCookie("lastactivity", "onlinetime", System.Environment.TickCount.ToString());

                    oltime = System.Environment.TickCount - TypeConverter.StrToInt(Utils.GetCookie("lastactivity", "oltime"), System.Environment.TickCount);
                    //�ж��Ƿ�ͬ��oltime (��¼��ĵ�һ��onlinetime���µ�ʱ��������߳���oltimespan2��ʱ����)
                    if (Utils.StrIsNullOrEmpty(Utils.GetCookie("lastactivity", "oltime")) ||
                        oltime <= 0 /*TickCount 49��ϵͳ�����㣬�����ɸ�ֵΪ��*/ 
                        || oltime >= (2 * oltimespan * 60 * 1000))
                    {
                        Discuz.Data.OnlineUsers.SynchronizeOnlineTime(uid);
                        Utils.WriteCookie("lastactivity", "oltime", System.Environment.TickCount.ToString());
                    }
                }
            }
        }

        #endregion



        /// <summary>
        /// ����Uid���Olid
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static int GetOlidByUid(int uid)
        {
            return Discuz.Data.OnlineUsers.GetOlidByUid(uid);
        }

        /// <summary>
        /// ɾ�����߱���Uid���û�
        /// </summary>
        /// <param name="uid">Ҫɾ���û���Uid</param>
        /// <returns></returns>
        public static int DeleteUserByUid(int uid)
        {
            return DeleteRows(GetOlidByUid(uid));
        }

        /// <summary>
        /// �����û��¶���Ϣ��
        /// </summary>
        /// <param name="olid">����id</param>
        /// <param name="count">������</param>
        /// <returns></returns>
        public static int UpdateNewPms(int olid, int count)
        {
            return Discuz.Data.OnlineUsers.UpdateNewPms(olid, count);
        }

        /// <summary>
        /// �����û���֪ͨ��
        /// </summary>
        /// <param name="olid">����id</param>
        /// <param name="pluscount">������</param>
        /// <returns></returns>
        public static int UpdateNewNotices(int olid, int pluscount)
        {
            return Discuz.Data.OnlineUsers.UpdateNewNotices(olid, pluscount);
        }

        /// <summary>
        /// ���»�ȡ�û���֪ͨ�����ӱ������²�ѯ
        /// </summary>
        /// <param name="olid">����id</param>
        /// <returns></returns>
        public static int UpdateNewNotices(int olid)
        {
            return Discuz.Data.OnlineUsers.UpdateNewNotices(olid, 0);
        }

        ///// <summary>
        ///// �������߱��к��ѹ�ϵ�������
        ///// </summary>
        ///// <param name="olId">����id</param>
        ///// <param name="count">������</param>
        ///// <returns></returns>
        //public static int UpdateNewFriendsRequest(int olId, int count)
        //{
        //    return Data.OnlineUsers.UpdateNewFriendsRequest(olId, count);
        //}

        ///// <summary>
        ///// �������߱���Ӧ���������
        ///// </summary>
        ///// <param name="olId">����id</param>
        ///// <param name="count">������</param>
        ///// <returns></returns>
        //public static int UpdateNewApplicationRequest(int olId, int count)
        //{
        //    return Data.OnlineUsers.UpdateNewApplicationRequest(olId, count);
        //}

    }//class end
}
