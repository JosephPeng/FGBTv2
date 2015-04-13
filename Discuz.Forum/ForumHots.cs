using System;
using System.Text;
using System.Data;

using Discuz.Cache;
using Discuz.Config;
using Discuz.Common;
using Discuz.Entity;
using System.IO;
using System.Text.RegularExpressions;
using Discuz.Common.Generic;

namespace Discuz.Forum
{
    /// <summary>
    /// �ȵ������
    /// </summary>
    public class ForumHots
    {
        /// <summary>
        /// �Ƴ���Ӧ�������б��棨��ǿ�����¼��أ�
        /// </summary>
        /// <param name="objectname"></param>
        public static void RemoveForumHotTopicsCache()
        {
            DNTCache.GetCacheService().RemoveObject("/Forum");
        }


        /// <summary>
        /// ��������б�
        /// </summary>
        /// <param name="count">����</param>
        /// <param name="views">��С�����</param>
        /// <param name="fid">���ID</param>
        /// <param name="timetype">��������,һ�졢һ�ܡ�һ�¡�������</param>
        /// <param name="ordertype">��������,ʱ�䵹��������������ظ�����</param>
        /// <param name="isdigest">�Ƿ񾫻�</param>
        /// <param name="cachetime">�������Ч��(��λ:����)</param>
        /// <returns></returns>
        public static DataTable GetTopicList(ForumHotItemInfo forumHotItemInfo)
        {
            //��ֹ������Ϊ
            forumHotItemInfo.Cachetimeout = forumHotItemInfo.Cachetimeout == 0 ? 1 : forumHotItemInfo.Cachetimeout;
            forumHotItemInfo.Dataitemcount = forumHotItemInfo.Dataitemcount > 50 ? 50 : (forumHotItemInfo.Dataitemcount < 1 ? 1 : forumHotItemInfo.Dataitemcount);

            DataTable dt = new DataTable();

            if (forumHotItemInfo.Cachetimeout > 0)
                dt = DNTCache.GetCacheService().RetrieveObject("/Forum/ForumHostList-" + forumHotItemInfo.Id) as DataTable;

            if (dt == null)
            {
                //������idlist����Ϊ�գ���Ĭ�϶�ȡ���пɼ�����idlist
                string forumList = string.IsNullOrEmpty(forumHotItemInfo.Forumlist) ? Forums.GetVisibleForum("::1") : forumHotItemInfo.Forumlist;
                string orderFieldName = Focuses.GetFieldName((TopicOrderType)Enum.Parse(typeof(TopicOrderType), forumHotItemInfo.Sorttype));

                //////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////
                //��BT�޸ġ�����ʾ�Ѿ����ڹ��棬���ӷ����ǩ������ʾ�رյ����⣨��PostManage.cs�����˴��޷��޸�~~~~��

                if (forumHotItemInfo.Forumlist == "4")
                {
                    dt = Discuz.Data.Topics.GetTopicList(forumHotItemInfo.Dataitemcount, -1, 0, "0",
                         Focuses.GetStartDate((TopicTimeType)Enum.Parse(typeof(TopicTimeType), forumHotItemInfo.Datatimetype)),
                         orderFieldName, forumList, orderFieldName == "digest", false);
                }
                else if (forumHotItemInfo.Forumlist == "37")
                {
                    dt = Discuz.Data.Topics.GetTopicList(forumHotItemInfo.Dataitemcount, -1, 0, "6,8",
                         Focuses.GetStartDate((TopicTimeType)Enum.Parse(typeof(TopicTimeType), forumHotItemInfo.Datatimetype)),
                         orderFieldName, forumList, orderFieldName == "digest", false);
                }
                else
                {
                    dt = Discuz.Data.Topics.GetTopicList(forumHotItemInfo.Dataitemcount, -1, 0, "",
                        Focuses.GetStartDate((TopicTimeType)Enum.Parse(typeof(TopicTimeType), forumHotItemInfo.Datatimetype)),
                        orderFieldName, forumList, orderFieldName == "digest", false);
                }


                //��END BT�޸ġ�
                //////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////

                if (forumHotItemInfo.Cachetimeout > 0)
                    DNTCache.GetCacheService().AddObject("/Forum/ForumHostList-" + forumHotItemInfo.Id, dt, forumHotItemInfo.Cachetimeout);
            }
            return dt;
        }

        /// <summary>
        /// ��ȡһ�����ӵĻ���
        /// </summary>
        /// <param name="tid">����ID</param>
        /// <param name="cachetime">�������Ч��</param>
        /// <returns></returns>
        public static DataTable GetFirstPostInfo(int tid, int cachetime)
        {
            Discuz.Cache.DNTCache cache = Discuz.Cache.DNTCache.GetCacheService();
            DataTable dt = cache.RetrieveObject("/Forum/HotForumFirst_" + tid) as DataTable;
            if (dt == null)
            {
                dt = Posts.GetPostList(tid.ToString());
                cache.AddObject("/Forum/HotForumFirst_" + tid, dt, cachetime);
            }
            return dt;
        }


        /// <summary>
        /// ��ȡ���Ű��
        /// </summary>
        /// <param name="topNumber">��ȡ������</param>
        /// <param name="orderby">����ʽ</param>
        /// <param name="fid">���ID</param>
        /// <param name="cachetime">����ʱ��</param>
        /// <returns></returns>
        public static List<ForumInfo> GetHotForumList(int topNumber, string orderby, int cachetime, int tabid)
        {
            Discuz.Cache.DNTCache cache = Discuz.Cache.DNTCache.GetCacheService();
            List<ForumInfo> forumList = cache.RetrieveObject("/Aggregation/HotForumList_" + tabid) as List<ForumInfo>;
            if (forumList == null)
            {
                forumList = Stats.GetForumArray(orderby);
                if (forumList.Count > topNumber)
                {
                    List<ForumInfo> list = new List<ForumInfo>();
                    for (int i = 0; i < topNumber; i++)
                        list.Add(forumList[i]);

                    forumList = list;
                }
                cache.AddObject("/Aggregation/HotForumList" + tabid, forumList, cachetime);
            }
            return forumList;
        }

        /// <summary>
        /// ��ȡ�����û�
        /// </summary>
        /// <param name="topNumber">��ȡ������</param>
        /// <param name="orderBy">����ʽ</param>
        /// <param name="cachetime">����ʱ��</param>
        /// <returns></returns>
        public static ShortUserInfo[] GetUserList(int topNumber, string orderBy, int cachetime, int tabid)
        {
            Discuz.Cache.DNTCache cache = Discuz.Cache.DNTCache.GetCacheService();

            ShortUserInfo[] userList = cache.RetrieveObject("/Aggregation/Users_" + tabid + "List") as ShortUserInfo[];
            if (userList == null)
            {
                if (Utils.InArray(orderBy, "lastactivity,joindate"))
                {
                    List<ShortUserInfo> list = new List<ShortUserInfo>();
                    DataTable dt = Users.GetUserList(topNumber, 1, orderBy, "desc");
                    foreach (DataRow dr in dt.Rows)
                    {
                        ShortUserInfo info = new ShortUserInfo();
                        info.Uid = TypeConverter.ObjectToInt(dr["uid"]);
                        info.Username = dr["username"].ToString();
                        info.Lastactivity = dr["lastactivity"].ToString();
                        info.Joindate = dr["joindate"].ToString();
                        list.Add(info);
                    }
                    userList = list.ToArray();
                }
                else
                {
                    userList = Stats.GetUserArray(orderBy);
                    if (userList.Length > topNumber)
                    {
                        List<ShortUserInfo> list = new List<ShortUserInfo>();
                        for (int i = 0; i < topNumber; i++)
                            list.Add(userList[i]);

                        userList = list.ToArray();
                    }
                }
                cache.AddObject("/Aggregation/Users_" + tabid + "List", userList, cachetime);
            }
            return userList;
        }

        /// <summary>
        /// ��̬�������ʶ�ռ��־
        /// </summary>
        private static object SynObject = new object();
        /// <summary>
        /// ��ȡ����ͼƬ
        /// </summary>
        /// <param name="topNumber">��ȡ������</param>
        /// <param name="orderBy">����ʽ</param>
        /// <param name="cachetime">����ʱ��</param>
        /// <returns></returns>
        private static DataTable HotImages(int count, int cachetime, string orderby, int tabid, string fidlist, int continuous)
        {
            Discuz.Cache.DNTCache cache = Discuz.Cache.DNTCache.GetCacheService();

            string fidname = fidlist.Replace(",", "_");

            DataTable imagelist = cache.RetrieveObject("/Aggregation/HotImages_" + tabid + "List_" + fidname) as DataTable;
            if (imagelist == null)
            {
                lock (SynObject)
                {
                    imagelist = cache.RetrieveObject("/Aggregation/HotImages_" + tabid + "List_" + fidname) as DataTable;
                    if (imagelist == null)
                    {
                        imagelist = Discuz.Data.DatabaseProvider.GetInstance().GetWebSiteAggHotImages(count, orderby, fidlist, continuous);
                        cache.AddObject("/Aggregation/HotImages_" + tabid + "List_" + fidname, imagelist, cachetime);
                        PTLog.InsertSystemLog(PTLog.LogType.Aggregation, PTLog.LogStatus.Detail, "HotImage", "���� HotImage ���� COUNT:" + imagelist.Rows.Count);
                    }
                }
            }
            return imagelist;
        }
        /// <summary>
        /// ��ȡ����ͼƬ�ٲ���
        /// </summary>
        /// <param name="topNumber">��ȡ������</param>
        /// <param name="orderBy">����ʽ</param>
        /// <param name="cachetime">����ʱ��</param>
        /// <returns></returns>
        private static DataTable HotImagesWaterFall(int section, int cachetime, string orderby, int tabid, string fidlist, int continuous)
        {
            if (section < 1 || section > 10) return null;

            Discuz.Cache.DNTCache cache = Discuz.Cache.DNTCache.GetCacheService();

            string fidname = fidlist.Replace(",", "_");

            DataTable imagelist = cache.RetrieveObject("/Aggregation/HotImagesWF_" + section.ToString() + "_" + fidname) as DataTable;
            
            if (imagelist == null && section == 1)
            {
                DataTable newimagelist = Discuz.Data.DatabaseProvider.GetInstance().GetWebSiteAggHotImages(300, orderby, fidlist, continuous);

                for (int i = 0; i < 10; i++)
                {
                    DataTable splitlist = newimagelist.Clone();
                    for (int j = 0; j < 30; j++)
                    {
                        DataRow dr = splitlist.NewRow();
                        dr.ItemArray = newimagelist.Rows[i * 30 + j].ItemArray;
                        splitlist.Rows.Add(dr);
                        if (i * 30 + j >= newimagelist.Rows.Count - 1) break;
                    }

                    if (i == section - 1)
                        imagelist = splitlist;

                    cache.AddObject("/Aggregation/HotImagesWF_" + (i + 1).ToString() + "_" + fidname, splitlist, cachetime);
                    if (i * 30 + 30 >= newimagelist.Rows.Count - 1) break;
                }

                PTLog.InsertSystemLog(PTLog.LogType.Aggregation, PTLog.LogStatus.Detail, "HotImage", "���� HotImageWaterFall ���� COUNT:" + newimagelist.Rows.Count);
                 
            }
            return imagelist;
        }



        /// <summary>
        /// ת������ͼƬΪ����
        /// </summary>
        /// <param name="topNumber">��ȡ������</param>
        /// <param name="orderBy">����ʽ</param>
        /// <param name="cachetime">����ʱ��</param>
        /// <returns></returns>
        public static string HotImagesArray(ForumHotItemInfo forumHotItemInfo, int groupid, string ipaddress)
        {
            return HotImagesArray(forumHotItemInfo, groupid, ipaddress, -1, "", 0);
        }
        /// <summary>
        /// ת������ͼƬΪ����
        /// </summary>
        /// <param name="topNumber">��ȡ������</param>
        /// <param name="orderBy">����ʽ</param>
        /// <param name="cachetime">����ʱ��</param>
        /// <returns></returns>
        public static string HotImagesArray(ForumHotItemInfo forumHotItemInfo, int groupid, string ipaddress, decimal ext2)
        {
            return HotImagesArray(forumHotItemInfo, groupid, ipaddress, -1, "", ext2);
        }
                /// <summary>
        /// ת������ͼƬΪ����
        /// </summary>
        /// <param name="topNumber">��ȡ������</param>
        /// <param name="orderBy">����ʽ</param>
        /// <param name="cachetime">����ʱ��</param>
        /// <param name="section">-1Ϊ��ҳ���ԣ�1~10Ϊwarterfall</param>
        /// <returns></returns>
        public static string HotImagesArray(ForumHotItemInfo forumHotItemInfo, int groupid, string ipaddress, int section, string fidlist)
        {
            return HotImagesArray(forumHotItemInfo, groupid, ipaddress, section, fidlist, 0);
        }
        /// <summary>
        /// ת������ͼƬΪ����
        /// </summary>
        /// <param name="topNumber">��ȡ������</param>
        /// <param name="orderBy">����ʽ</param>
        /// <param name="cachetime">����ʱ��</param>
        /// <param name="section">-1Ϊ��ҳ���ԣ�1~10Ϊwarterfall</param>
        /// <returns></returns>
        public static string HotImagesArray(ForumHotItemInfo forumHotItemInfo, int groupid, string ipaddress, int section, string fidlist, decimal ext2)
        {
            string imagesItemTemplate = "title:\"{0}\",img:\"{1}\",url:\"{2}\"";
            string waterfallTemplate = "<div class=\"wf-cld\"><a href=\"{2}\"><img class=\"fgbtf_roundimg\" src=\"{1}\" />{0}</a></div>";
            StringBuilder hotImagesArray = new StringBuilder();

            //���û������ͼĿ¼����ȥ����
            if (!Directory.Exists(Utils.GetMapPath(BaseConfigs.GetForumPath + "cache/rotatethumbnail/")))
                Utils.CreateDir(Utils.GetMapPath(BaseConfigs.GetForumPath + "cache/rotatethumbnail/"));

            //������idlist����Ϊ�գ���Ĭ�϶�ȡ���пɼ�����idlist
            string allforums = Forums.GetVisibleForum(ext2, groupid, ipaddress);
            string forumList = string.IsNullOrEmpty(forumHotItemInfo.Forumlist) ? allforums : forumHotItemInfo.Forumlist;

            //��������ͼƬ�ٲ���ҳ�棬ֻ����Ĭ�ϻ��� 2��ͼ����37������
            if (section > 0)
            {
                if (fidlist != "")
                {
                    if (fidlist == "2" || fidlist == "37")
                    {
                        forumList = fidlist;
                    }
                }
            }

            forumList = "2,37";

            //����ͼƬ�����������Ƽ�
            //if (("," + allforums + ",").IndexOf(",58,") > -1)
            //{
            //    //����������ɼ�����25%����ֻ��ʾ������(58)���ݣ�������ʾ��������
            //    int r = PTTools.GetRandomInt(0, 100);
            //    if (r <= 10 && section == -1)
            //    {
            //        forumList = "2";
            //    }
            //    else if (r <= 40 && section == -1 && ext2 > 50)
            //    {
            //        //D//PTLog.InsertSystemLogDebug(PTLog.LogType.DebugTEST, PTLog.LogStatus.Normal, "DEBUG", "58 ONLY **** " + groupid + "--" + allforums);
            //        forumList = "58";
            //    }
            //    else if (ext2 < 51)
            //    {
            //        //����ʾ����������
            //        forumList = ("," + forumList + ",").Replace(",58,", ",");
            //        forumList = forumList.Substring(1, forumList.Length - 2);
            //    }
            //    //D//PTLog.InsertSystemLogDebug(PTLog.LogType.DebugTEST, PTLog.LogStatus.Normal, "DEBUG", "NORMAL ---- " + groupid + "--" + allforums);
            //}
            //else
            //{
            //    //���������ɼ�������ʾ���з�������ͼƬ
            //    if (forumList.Length > 2)
            //    {
            //        forumList = ("," + forumList + ",").Replace(",58,", ",");
            //        forumList = forumList.Substring(1, forumList.Length - 2);
            //    }
            //    //D//PTLog.InsertSystemLogDebug(PTLog.LogType.DebugTEST, PTLog.LogStatus.Normal, "DEBUG", "HIDDEN #### " + groupid + "--" + allforums);
            //}


            DataTable dt;
            if(section == -1)
                dt = HotImages(forumHotItemInfo.Dataitemcount, forumHotItemInfo.Cachetimeout, forumHotItemInfo.Sorttype, forumHotItemInfo.Id, forumList, forumHotItemInfo.Enabled);
            else
                dt = HotImagesWaterFall(section, forumHotItemInfo.Cachetimeout, forumHotItemInfo.Sorttype, forumHotItemInfo.Id, forumList, forumHotItemInfo.Enabled);

            if (dt == null) return "";

            foreach (DataRow dr in dt.Rows)
            {
                int tid = TypeConverter.ObjectToInt(dr["tid"]);
                string fileName = dr["filename"].ToString().Trim();
                string title = dr["title"].ToString().Trim();

                title = Utils.JsonCharFilter(title).Replace("'", "\\'");

                if (fileName.StartsWith("http://"))
                {
                    DeleteCacheImageFile();
                    Thumbnail.MakeRemoteThumbnailImage(fileName, Utils.GetMapPath(BaseConfigs.GetForumPath + "cache/rotatethumbnail/r_" + Utils.GetFilename(fileName)), 360, 240);
                    hotImagesArray.Append("{");
                    hotImagesArray.AppendFormat(imagesItemTemplate, title, "cache/rotatethumbnail/r_" + Utils.GetFilename(fileName), Urls.ShowTopicAspxRewrite(tid, 0));
                    hotImagesArray.Append("},");
                    continue;
                }
                //ͼƬ�ļ�����
                string fullFileName = BaseConfigs.GetForumPath + "upload/" + fileName.Replace('\\', '/').Trim();
                //ͼƬ���Ժ������
                string thumbnailFileName = "cache/rotatethumbnail/r_" + Utils.GetFilename(fullFileName);

                if (!File.Exists(Utils.GetMapPath(BaseConfigs.GetForumPath + thumbnailFileName)) && File.Exists(Utils.GetMapPath(fullFileName)))
                {
                    DeleteCacheImageFile();
                    Thumbnail.MakeThumbnailImage(Utils.GetMapPath(fullFileName), Utils.GetMapPath(BaseConfigs.GetForumPath + thumbnailFileName), 360, 240);
                }
                if (section == -1)
                {
                    hotImagesArray.Append("{");
                    hotImagesArray.AppendFormat(imagesItemTemplate, title, "cache/rotatethumbnail/r_" + Utils.GetFilename(fullFileName), Urls.ShowTopicAspxRewrite(tid, 0));
                    hotImagesArray.Append("},");
                }
                else
                {
                    hotImagesArray.AppendFormat(waterfallTemplate, title, "cache/rotatethumbnail/r_" + Utils.GetFilename(fullFileName), Urls.ShowTopicAspxRewrite(tid, 0));
                }

            }

            dt.Dispose();

            if (section == -1) return "[" + hotImagesArray.ToString().TrimEnd(',') + "]";
            else return hotImagesArray.ToString();
        }

        /// <summary>
        /// ����ɾ����ͼƬ����
        /// </summary>
        /// <param name="message">��������</param>
        /// <param name="length">��ȡ���ݵĳ���</param>
        /// <returns></returns>
        public static string RemoveUbb(string message, int length)
        {
            message = Regex.Replace(message, @"\[attachimg\](\d+)(\[/attachimg\])*", "{ͼƬ}", RegexOptions.IgnoreCase);
            message = Regex.Replace(message, @"\[img\]\s*([^\[\<\r\n]+?)\s*\[\/img\]", "{ͼƬ}", RegexOptions.IgnoreCase);
            message = Regex.Replace(message, @"\[img=(\d{1,4})[x|\,](\d{1,4})\]\s*([^\[\<\r\n]+?)\s*\[\/img\]", "{ͼƬ}", RegexOptions.IgnoreCase);
            message = Regex.Replace(message, @"\[attach\](\d+)(\[/attach\])*", "{����}", RegexOptions.IgnoreCase);
            //��������������UBB��ʽ��������Ҫ���֣��������򲻻��ͻ
            message = Regex.Replace(message, @"\s*\[hide\][\n\r]*([\s\S]+?)[\n\r]*\[\/hide\]\s*", "{��������}", RegexOptions.IgnoreCase);
            message = Regex.Replace(message, @"\s*\[hide=(\d+?)\][\n\r]*([\s\S]+?)[\n\r]*\[\/hide\]\s*", "{��������}", RegexOptions.IgnoreCase);

            if (message.IndexOf("[free]") > -1)
            {
                Match match = Regex.Match(message, @"\s*\[free\][\n\r]*([\s\S]+?)[\n\r]*\[\/free\]\s*", RegexOptions.IgnoreCase);
                message = match.Groups[0] != null && match.Groups[0].Value != "" ? match.Groups[0].Value : message;
            }
            return Utils.GetSubString(Utils.ClearUBB(Utils.RemoveHtml(message)).Replace("{", "[").Replace("}", "]"), length, "......");
        }
        private static void DeleteCacheImageFile()
        {
            FileInfo[] files = new DirectoryInfo(Utils.GetMapPath(BaseConfigs.GetForumPath + "cache/rotatethumbnail/")).GetFiles();
            //��������ļ���cache/rotatethumbnail �µ��ļ�����100������ɾ�����100��
            if (files.Length > 1200)
            {
                Attachments.QuickSort(files, 0, files.Length - 1);

                for (int i = files.Length - 1; i >= 1100; i--)
                {
                    try
                    {
                        files[i].Delete();
                    }
                    catch
                    { }
                }
            }

        }
    }
}