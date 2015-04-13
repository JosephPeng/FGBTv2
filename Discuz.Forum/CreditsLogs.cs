using System;
using System.Text;
using System.Data;

using Discuz.Common;
using Discuz.Data;

namespace Discuz.Forum
{
    /// <summary>
    /// ����ת����ʷ��¼������
    /// </summary>
    public class CreditsLogs
    {

        /// <summary>
        /// ��ӻ���ת�ʶһ��ͳ�ֵ��¼
        /// </summary>
        /// <param name="uid">�û�id</param>
        /// <param name="fromto">����/��</param>
        /// <param name="sendcredits">������������</param>
        /// <param name="receivecredits">�õ���������</param>
        /// <param name="send">������������</param>
        /// <param name="receive">�õ���������</param>
        /// <param name="paydate">ʱ��</param>
        /// <param name="operation">���ֲ���(1=�һ�, 2=ת��, 3=��������, 4=���ӹ���, 5=ϵͳ����, 6=�����û����� ,7=�����û�����, 8=����ת�ˣ�9=���������11=�������ͣ�12=�������ͣ�13=�޴𰸽������ͣ�14=�������������15����Ͷע��16���ʷ�����17�������ͣ�18���ط�������)</param>
        /// <returns>ִ��Ӱ�����</returns>
        public static int AddCreditsLog(int uid, int fromto, int sendcredits, int receivecredits, float send, float receive, string paydate, int operation)
        {
            return uid > 0 ? Discuz.Data.CreditsLogs.AddCreditsLog(uid, fromto, sendcredits, receivecredits, send, receive, paydate, operation) : 0;
        }

        /// <summary>
        /// ����ָ����Χ�Ļ�����־
        /// </summary>
        /// <param name="pagesize">ҳ��С</param>
        /// <param name="currentpage">��ǰҳ��</param>
        /// <param name="uid">�û�id</param>
        /// <returns>������־</returns>
        public static DataTable GetCreditsLogList(int pagesize, int currentpage, int uid)
        {
            //////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////// 
            //��BT�޸ġ��滻��������������ϸ�ķ���
            //return (uid > 0 && currentpage > 0) ? Discuz.Data.CreditsLogs.GetCreditsLogList(pagesize, currentpage, uid) : new DataTable();

            if(uid > 0 && currentpage > 0)
            {
                DataTable dt = Discuz.Data.CreditsLogs.GetCreditsLogList(pagesize, currentpage, uid);

                string payintype = "";
                string payouttype = "";
                if (dt != null)
                {

                    DataColumn dc = new DataColumn();
                    dc.ColumnName = "operationinfo";
                    dc.DataType = System.Type.GetType("System.String");
                    dc.DefaultValue = "";
                    dc.AllowDBNull = false;
                    dt.Columns.Add(dc);
                    dc = new DataColumn();
                    dc.ColumnName = "sendstr";
                    dc.DataType = System.Type.GetType("System.String");
                    dc.DefaultValue = "";
                    dc.AllowDBNull = false;
                    dt.Columns.Add(dc);
                    dc = new DataColumn();
                    dc.ColumnName = "receivestr";
                    dc.DataType = System.Type.GetType("System.String");
                    dc.DefaultValue = "";
                    dc.AllowDBNull = false;
                    dt.Columns.Add(dc);
                    foreach (DataRow dr in dt.Rows)
                    {
                        //�ж����ڣ���ϵͳ��ϸ��ļ�¼
                        decimal ValueMulti = 1M;
                        if (TypeConverter.ObjectToDateTime(dr["paydate"]) < DateTime.Parse("2012-04-30"))
                        {
                            ValueMulti = 1024 * 1024M;
                        }

                        //���㸶���ͻ����ֵ
                        if (dr["sendcredits"].ToString() == "2")
                        { 
                            payouttype = "���" + dr["send"].ToString();
                        }
                        if (dr["sendcredits"].ToString() == "3")
                        {
                            payouttype = "�ϴ�" + PTTools.Upload2Str(TypeConverter.ObjectToDecimal(dr["send"]) * ValueMulti);
                        }
                        if (dr["receivecredits"].ToString() == "2")
                        {
                            payintype = "���" + dr["receive"].ToString();
                        }
                        if (dr["receivecredits"].ToString() == "3")
                        {
                            payintype = "�ϴ�" + PTTools.Upload2Str(TypeConverter.ObjectToDecimal(dr["receive"]) * ValueMulti);
                        }
                        dr["sendstr"] = payouttype;
                        dr["receivestr"] = payintype;
                        


                        if (dr["operation"].ToString() == "1")
                        {
                            dr["operationinfo"] = string.Format("[�һ�]����{0}�һ�Ϊ{1}", payouttype, payintype);
                        }
                        if (dr["operation"].ToString() == "2")
                        {
                            if (dr["uid"].ToString() == uid.ToString())
                            {
                                dr["operationinfo"] = string.Format("[ת�ˣ�ת��]���û� {0} �յ� {1}", dr["touser"], payouttype);
                                dr["receivestr"] = "-";
                            }
                            else if (dr["fromto"].ToString() == uid.ToString())
                            {
                                dr["operationinfo"] = string.Format("[ת�ˣ�ת��]�����û� {0} ֧�� {1}", dr["fromuser"], payintype);
                                dr["sendstr"] = "-";
                            }

                        }
                        if (dr["operation"].ToString() == "3")
                        {
                            dr["operationinfo"] = string.Format("[��������]��֧��  {0}", payouttype);
                            dr["receivestr"] = "-";
                        }
                        if (dr["operation"].ToString() == "4")
                        {
                            if (dr["fromto"].ToString() == dr["uid"].ToString() && dr["uid"].ToString() == uid.ToString())
                            {
                                if (dr["send"].ToString() == "0")
                                {
                                    dr["operationinfo"] = "[���ӹ���]�������Լ� " + payintype;
                                    dr["sendstr"] = "-";
                                }
                                else if (dr["receive"].ToString() == "0")
                                {
                                    dr["operationinfo"] = "[���ӹ���]���۳��Լ� " + payouttype;
                                    dr["receivestr"] = "-";
                                }
                            }
                            else if (dr["fromto"].ToString() == uid.ToString())
                            {
                                if (dr["send"].ToString() == "0")
                                {
                                    dr["operationinfo"] = "[���ӹ���]�������û� " + dr["fromuser"].ToString() + " " + payintype;
                                    dr["sendstr"] = "-";
                                    dr["receivestr"] = "-";
                                }
                                else if (dr["receive"].ToString() == "0")
                                {
                                    dr["operationinfo"] = "[���ӹ���]���۳��û� " + dr["fromuser"].ToString() + " " + payouttype;
                                    dr["sendstr"] = "-";
                                    dr["receivestr"] = "-";
                                }
                            }
                            else if (dr["uid"].ToString() == uid.ToString())
                            {
                                if (dr["send"].ToString() == "0")
                                {
                                    dr["operationinfo"] = "[�������ӽ���]����ý��� " + payintype;
                                    dr["sendstr"] = "-";
                                }
                                else if (dr["receive"].ToString() == "0")
                                {
                                    dr["operationinfo"] = "[�������Ӵ���]�����۳� " + payouttype;
                                    dr["receivestr"] = "-";
                                }
                            }
                        }
                        if (dr["operation"].ToString() == "5")
                        {
                            dr["operationinfo"] = "[ϵͳ����]�����Զ��۳� " + payouttype;
                            dr["receivestr"] = "-";
                        }
                        if (dr["operation"].ToString() == "6")
                        {
                            dr["operationinfo"] = "[�����û�����]����ý��� " + payintype;
                            dr["sendstr"] = "-";
                        }
                        if (dr["operation"].ToString() == "7")
                        {
                            dr["operationinfo"] = "[�����û�����]�����۳�" + payouttype;
                            dr["receivestr"] = "-";
                        }
                        if (dr["operation"].ToString() == "8")
                        {
                            if (dr["fromto"].ToString() == uid.ToString())
                            {
                                if (dr["receive"].ToString() == "0")
                                {
                                    dr["operationinfo"] = "[����ת��]��֧����Դ";
                                    dr["receivestr"] = "-";
                                    dr["sendstr"] = "-";
                                }
                                else
                                {
                                    dr["operationinfo"] = "[����ת��]���յ����Թ���Ա" + dr["touser"].ToString() + " " + payintype;
                                    dr["sendstr"] = "-";
                                }
                            }
                            else
                            {
                                dr["operationinfo"] = "[����ת��]��ת���û�" + dr["touser"].ToString() + " " + payouttype;
                                if (dr["receive"].ToString() == "0")
                                {
                                    dr["sendstr"] = "-";
                                    dr["receivestr"] = "-";
                                }
                                else
                                {
                                    dr["sendstr"] = "-";
                                    dr["receivestr"] = "-";
                                }
                            }
                        }
                        if (dr["operation"].ToString() == "9")
                        {
                            dr["operationinfo"] = "[�������] ";
                            dr["sendstr"] = "-";
                            dr["receivestr"] = "-";
                        }
                        if (dr["operation"].ToString() == "11")
                        {
                            dr["operationinfo"] = "[��������]��֧�����ͼ�˰��֤�� " + payouttype;
                            dr["receivestr"] = "-";
                        }
                        if (dr["operation"].ToString() == "12")
                        {
                            if (dr["uid"].ToString() == uid.ToString() && dr["fromto"].ToString() == uid.ToString())
                            {
                                dr["operationinfo"] = "[��������]��������֤�� " + payintype;
                                dr["sendstr"] = "-";
                            }
                            else if (dr["uid"].ToString() == uid.ToString() && dr["fromto"].ToString() != uid.ToString())
                            {
                                dr["operationinfo"] = "[��������]��֧���ͽ� " + payouttype;
                                dr["sendstr"] = "-";
                                dr["receivestr"] = "-";
                            }
                            else
                            {
                                dr["operationinfo"] = "[��������]����������" + payintype;
                                dr["sendstr"] = "-";
                            }
                        }
                        if (dr["operation"].ToString() == "13")
                        {
                            if (dr["uid"].ToString() == uid.ToString() && dr["fromto"].ToString() == uid.ToString())
                            {
                                dr["operationinfo"] = "[�޴𰸽�������]��������֤������ " + payintype;
                                dr["sendstr"] = "-";
                            }
                            if (dr["uid"].ToString() != uid.ToString() && dr["fromto"].ToString() == uid.ToString())
                            {
                                dr["operationinfo"] = "[�������]���޴𰸽������ͣ�������֤������" + payintype;
                                dr["sendstr"] = "-";
                                dr["receivestr"] = "-";
                            }
                        }
                        if (dr["operation"].ToString() == "14")
                        {
                            if (dr["uid"].ToString() == uid.ToString() && dr["fromto"].ToString() == uid.ToString())
                            {
                                dr["operationinfo"] = "[ϵͳά��]��ϵͳά������ " + payouttype;
                                dr["receivestr"] = "-";
                            }
                            if (dr["uid"].ToString() == uid.ToString() && dr["fromto"].ToString() != uid.ToString())
                            {
                                dr["operationinfo"] = "[�������]���������� " + payouttype;
                                dr["receivestr"] = "-";
                            }
                            if (dr["uid"].ToString() != uid.ToString() && dr["fromto"].ToString() == uid.ToString())
                            {
                                dr["operationinfo"] = "[�������]�������û����� " + payouttype;
                                dr["sendstr"] = "-";
                                dr["receivestr"] = "-";
                            }
                        }
                        if (dr["operation"].ToString() == "18")
                        {
                            if (dr["fromto"].ToString() == uid.ToString())
                            {
                                dr["operationinfo"] = "[�ļ���������]���յ� " + dr["sendstr"];
                                dr["receivestr"] = dr["sendstr"];
                                dr["sendstr"] = "-";
                            }
                            else
                            {
                                dr["operationinfo"] = "[�ļ���������]��֧�� " + dr["sendstr"];
                                dr["receivestr"] = "-";
                            }
                        }
                    }
                }
                dt.Dispose();

                return dt;
            }
            else return new DataTable();

            
            //��END BT�޸ġ�
            //////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////// 
        }

        /// <summary>
        /// ���ָ���û��Ļ��ֽ�����ʷ��¼������
        /// </summary>
        /// <param name="uid">�û�id</param>
        /// <returns>��ʷ��¼������</returns>
        public static int GetCreditsLogRecordCount(int uid)
        {
            return uid > 0 ? Discuz.Data.CreditsLogs.GetCreditsLogRecordCount(uid) : 0;
        }
    }

}
