<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="Discuz.Web.showseedpeer" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Discuz.Common" %>
<%@ Import namespace="Discuz.Forum" %>
<%@ Import namespace="Discuz.Entity" %>
<%@ Import namespace="Discuz.Config" %>

<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by Discuz!NT Template Engine at 2015/1/7 16:52:34.
		本页面代码由Discuz!NT模板引擎生成于 2015/1/7 16:52:34. 
	*/

	base.OnInit(e);

	templateBuilder.Capacity = 220000;



	if (infloat!=1)
	{

	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n    ");
	if (pagetitle=="首页")
	{

	templateBuilder.Append("\r\n        <title>");
	templateBuilder.Append(config.Forumtitle.ToString().Trim());
	templateBuilder.Append(" ");
	templateBuilder.Append(config.Seotitle.ToString().Trim());
	templateBuilder.Append(" - Powered by Discuz!NT</title>\r\n    ");
	}
	else
	{

	templateBuilder.Append("\r\n        <title>");
	templateBuilder.Append(pagetitle.ToString());
	templateBuilder.Append(" - ");
	templateBuilder.Append(config.Forumtitle.ToString().Trim());
	templateBuilder.Append(" ");
	templateBuilder.Append(config.Seotitle.ToString().Trim());
	templateBuilder.Append(" - Powered by Discuz!NT</title>\r\n    ");
	}	//end if

	templateBuilder.Append("\r\n    ");
	templateBuilder.Append(meta.ToString());
	templateBuilder.Append("\r\n    <meta name=\"generator\" content=\"Discuz!NT 3.6.711\" />\r\n    <meta name=\"author\" content=\"Discuz!NT Team and Comsenz UI Team\" />\r\n    <meta name=\"copyright\" content=\"2001-2011 Comsenz Inc.\" />\r\n    <meta http-equiv=\"x-ua-compatible\" content=\"edge\" />\r\n    <link rel=\"stylesheet\" href=\"");
	templateBuilder.Append(cssdir.ToString());
	templateBuilder.Append("/privatebt.css?");
	templateBuilder.Append(CSSJSVersion.ToString());
	templateBuilder.Append("\" type=\"text/css\" media=\"all\"  />\r\n    <link rel=\"icon\" href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append("favicon.ico\" type=\"image/x-icon\" />\r\n    <link rel=\"shortcut icon\" href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append("favicon.ico\" type=\"image/x-icon\" />\r\n    ");
	if (pagename!="website.aspx")
	{

	templateBuilder.Append("\r\n        <link rel=\"stylesheet\" href=\"");
	templateBuilder.Append(cssdir.ToString());
	templateBuilder.Append("/dnt.css?");
	templateBuilder.Append(CSSJSVersion.ToString());
	templateBuilder.Append("\" type=\"text/css\" media=\"all\" />\r\n    ");
	}	//end if

	templateBuilder.Append("\r\n    <link rel=\"stylesheet\" href=\"");
	templateBuilder.Append(cssdir.ToString());
	templateBuilder.Append("/float.css?");
	templateBuilder.Append(CSSJSVersion.ToString());
	templateBuilder.Append("\" type=\"text/css\" />\r\n    ");
	if (isnarrowpage)
	{

	templateBuilder.Append("\r\n        <link type=\"text/css\" rel=\"stylesheet\" href=\"");
	templateBuilder.Append(cssdir.ToString());
	templateBuilder.Append("/widthauto.css?");
	templateBuilder.Append(CSSJSVersion.ToString());
	templateBuilder.Append("\" id=\"css_widthauto\" />\r\n    ");
	}	//end if

	templateBuilder.Append("\r\n    ");
	templateBuilder.Append(link.ToString());
	templateBuilder.Append("\r\n    <script type=\"text/javascript\">\r\n        var creditnotice='");
	templateBuilder.Append(Scoresets.GetValidScoreNameAndId().ToString().Trim());
	templateBuilder.Append("';	\r\n        var forumpath = \"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("\";\r\n    </");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\" src=\"");
	templateBuilder.Append(jsdir.ToString());
	templateBuilder.Append("/futuregarden.js?");
	templateBuilder.Append(CSSJSVersion.ToString());
	templateBuilder.Append("\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\" src=\"");
	templateBuilder.Append(config.Jqueryurl.ToString().Trim());
	templateBuilder.Append("?");
	templateBuilder.Append(CSSJSVersion.ToString());
	templateBuilder.Append("\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\">jQuery.noConflict();</");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\" src=\"");
	templateBuilder.Append(jsdir.ToString());
	templateBuilder.Append("/common.js?");
	templateBuilder.Append(CSSJSVersion.ToString());
	templateBuilder.Append("\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\" src=\"");
	templateBuilder.Append(jsdir.ToString());
	templateBuilder.Append("/template_report.js?");
	templateBuilder.Append(CSSJSVersion.ToString());
	templateBuilder.Append("\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\" src=\"");
	templateBuilder.Append(jsdir.ToString());
	templateBuilder.Append("/template_utils.js?");
	templateBuilder.Append(CSSJSVersion.ToString());
	templateBuilder.Append("\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\" src=\"");
	templateBuilder.Append(jsdir.ToString());
	templateBuilder.Append("/ajax.js?");
	templateBuilder.Append(CSSJSVersion.ToString());
	templateBuilder.Append("\"></");
	templateBuilder.Append("script>\r\n    <script type=\"text/javascript\">\r\n	    var aspxrewrite = ");
	templateBuilder.Append(config.Aspxrewrite.ToString().Trim());
	templateBuilder.Append(";\r\n	    var IMGDIR = '");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("';\r\n        var disallowfloat = '");
	templateBuilder.Append(config.Disallowfloatwin.ToString().Trim());
	templateBuilder.Append("';\r\n	    var rooturl=\"");
	templateBuilder.Append(rooturl.ToString());
	templateBuilder.Append("\";\r\n	    var imagemaxwidth='");
	templateBuilder.Append(Templates.GetTemplateWidth(templatepath).ToString().Trim());
	templateBuilder.Append("';\r\n	    var cssdir='");
	templateBuilder.Append(cssdir.ToString());
	templateBuilder.Append("';\r\n    </");
	templateBuilder.Append("script>\r\n    ");
	templateBuilder.Append(script.ToString());
	templateBuilder.Append("\r\n</head>");

	templateBuilder.Append("\r\n<body onkeydown=\"if(event.keyCode==27) return false;\">\r\n<div id=\"append_parent\"></div><div id=\"ajaxwaitid\"></div>\r\n<div id=\"submenu\">\r\n  ");
	if (userid>0&&pagename!="login.aspx"&&pagename!="logout.aspx"&&pagename!="register.aspx"&&pagename!="cngilogin.aspx")
	{

	templateBuilder.Append("\r\n	<div class=\"wrap s_clear\">\r\n		  <span class=\"submenuright\">\r\n        ");
	templateBuilder.Append(ipaddress_note.ToString());
	templateBuilder.Append("\r\n    </span>\r\n		欢迎 <a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("userinfo.aspx?userid=");
	templateBuilder.Append(userid.ToString());
	templateBuilder.Append("\">");
	templateBuilder.Append(username.ToString());
	templateBuilder.Append("</a>\r\n  </div>\r\n  ");
	}	//end if

	templateBuilder.Append("\r\n</div>\r\n\r\n");
	if (headerad!="")
	{

	templateBuilder.Append("\r\n	<div id=\"ptnotice_headerbanner\">");
	templateBuilder.Append(headerad.ToString());
	templateBuilder.Append("</div>\r\n");
	}	//end if

	templateBuilder.Append("\r\n<div id=\"hd\">\r\n	<div class=\"wrap\">\r\n		<div class=\"head cl\">\r\n			<h2><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("index.aspx\" title=\"");
	templateBuilder.Append(config.Forumtitle.ToString().Trim());
	templateBuilder.Append("\"><img src=\"");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("/logo.png\" alt=\"");
	templateBuilder.Append(config.Forumtitle.ToString().Trim());
	templateBuilder.Append("\"/></a></h2>\r\n			");
	if (userid>0)
	{

	templateBuilder.Append("\r\n			<div id=\"um\">\r\n				<div class=\"avt y\"><a alt=\"用户名称\" target=\"_blank\" href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercp.aspx\"><img src=\"");
	templateBuilder.Append(useravatar.ToString());
	templateBuilder.Append("\" onerror=\"this.onerror=null;this.src='");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("images/common/noavatar_small.gif';\" /></a></div>\r\n				<p>\r\n                    ");	string linktitle = "";
	
	string showoverflow = "";
	

	if (oluserinfo.Newpms>0)
	{


	if (oluserinfo.Newpms>=1000)
	{

	 showoverflow = "大于";
	

	}	//end if

	 linktitle = "您有"+showoverflow+oluserinfo.Newpms+"条新短消息";
	

	}
	else
	{

	 linktitle = "您没有新短消息";
	

	}	//end if

	templateBuilder.Append("\r\n					<a id=\"pm_ntc\" href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercpinbox.aspx\" title=\"");
	templateBuilder.Append(linktitle.ToString());
	templateBuilder.Append("\">短消息\r\n                    ");
	if (oluserinfo.Newpms>0 && oluserinfo.Newpms<=1000)
	{

	templateBuilder.Append("\r\n                                (");
	templateBuilder.Append(oluserinfo.Newpms.ToString().Trim());
	if (oluserinfo.Newpms>=1000)
	{

	templateBuilder.Append("1000+");
	}	//end if

	templateBuilder.Append(")\r\n                    ");
	}	//end if

	templateBuilder.Append("</a>\r\n                    <span class=\"pipe\">|</span>\r\n                    ");	 showoverflow = "";
	

	if (oluserinfo.Newnotices>0)
	{


	if (oluserinfo.Newnotices>=1000)
	{

	 showoverflow = "大于";
	

	}	//end if

	 linktitle = "您有"+showoverflow+oluserinfo.Newnotices+"条新通知";
	

	}
	else
	{

	 linktitle = "您没有新通知";
	

	}	//end if

	templateBuilder.Append("\r\n					<a id=\"notice_ntc\" href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercpnotice.aspx?filter=all\" title=\"");
	templateBuilder.Append(linktitle.ToString());
	templateBuilder.Append("\">\r\n                        通知");
	if (oluserinfo.Newnotices>0)
	{

	templateBuilder.Append("\r\n                                (");
	templateBuilder.Append(oluserinfo.Newnotices.ToString().Trim());
	if (oluserinfo.Newnotices>=1000)
	{

	templateBuilder.Append("+");
	}	//end if

	templateBuilder.Append(")\r\n                            ");
	}	//end if

	templateBuilder.Append("\r\n                    </a>\r\n                    <span class=\"pipe\">|</span>\r\n					<a id=\"usercenter\" class=\"drop\" onmouseover=\"showMenu(this.id);\" href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercp.aspx\">用户中心</a>\r\n					");
	if (cngi_login==true)
	{

	templateBuilder.Append("\r\n              <span class=\"pipe\">|</span><a href=\"javascript:alert('CNGI登陆用户只有关闭浏览器才能退出登录，如果需要退出登录，请关闭浏览器')\">退出</a>\r\n					");
	}
	else
	{

	templateBuilder.Append("\r\n              <span class=\"pipe\">|</span><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("logout.aspx?userkey=");
	templateBuilder.Append(userkey.ToString());
	templateBuilder.Append("\">退出</a>\r\n          ");
	}	//end if

	templateBuilder.Append("\r\n				</p>\r\n				");
	templateBuilder.Append(userinfotips.ToString());
	templateBuilder.Append("\r\n			</div> \r\n			<div id=\"pm_ntc_menu\" class=\"g_up\" style=\"display:none;\">\r\n				<div class=\"mncr\"></div>\r\n				<div class=\"crly\">\r\n					<div style=\"clear:both;font-size:0;\"></div>\r\n					<span class=\"y\"><a onclick=\"javascript:$('pm_ntc_menu').style.display='none';closenotice(");
	templateBuilder.Append(oluserinfo.Newpms.ToString().Trim());
	templateBuilder.Append(");\" href=\"javascript:;\"><img src=\"");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("/delete.gif\" alt=\"关闭\"/></a></span>\r\n					<a id=\"pmcountshow\" href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercpinbox.aspx\">您有");
	if (oluserinfo.Newpms>=1000)
	{

	templateBuilder.Append("大于");
	}	//end if
	templateBuilder.Append(oluserinfo.Newpms.ToString().Trim());
	templateBuilder.Append("条新消息</a>\r\n				</div>\r\n			</div>\r\n			<div id=\"notice_ntc_menu\" class=\"g_up\" style=\"display:none;\">\r\n				<div class=\"mncr\"></div>\r\n				<div class=\"crly\">\r\n					<div style=\"clear:both;font-size:0;\"></div>\r\n					<span class=\"y\"><a onclick=\"javascript:$('notice_ntc_menu').style.display='none';closenotice(");
	templateBuilder.Append(oluserinfo.Newnotices.ToString().Trim());
	templateBuilder.Append(");\" href=\"javascript:;\"><img src=\"");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("/delete.gif\" alt=\"关闭\"/></a></span>\r\n					<a id=\"noticecountshow\" href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercpnotice.aspx?filter=all\">您有");
	if (oluserinfo.Newnotices>=1000)
	{

	templateBuilder.Append("大于");
	}	//end if
	templateBuilder.Append(oluserinfo.Newnotices.ToString().Trim());
	templateBuilder.Append("条新通知</a>\r\n				</div>\r\n			</div>\r\n\r\n            <span id=\"msgsoundplayerspanheader\" style=\"display:hidden\"></span>\r\n            <script type=\"text/javascript\">\r\n                var pmcount = ");
	templateBuilder.Append(oluserinfo.Newpms.ToString().Trim());
	templateBuilder.Append(";\r\n                var noticecount = ");
	templateBuilder.Append(oluserinfo.Newnotices.ToString().Trim());
	templateBuilder.Append(";\r\n                var originalTitle =  document.title;\r\n                var playpmsound = ");
	if (oluserinfo.PMSound>0)
	{

	templateBuilder.Append("true");
	}
	else
	{

	templateBuilder.Append("false");
	}	//end if

	templateBuilder.Append(";\r\n                setnewpmnoticeposion(");
	templateBuilder.Append(oluserinfo.Newnotices.ToString().Trim());
	templateBuilder.Append(", ");
	templateBuilder.Append(oluserinfo.Newpms.ToString().Trim());
	templateBuilder.Append(");\r\n                initpmnoticeupdate();\r\n\r\n            </");
	templateBuilder.Append("script>\r\n            ");
	}	//end if

	templateBuilder.Append("\r\n		</div>\r\n		<div id=\"menubar\">\r\n			<a onMouseOver=\"showMenu(this.id, false);\" href=\"javascript:void(0);\" id=\"mymenu\">我的中心</a>\r\n            <div class=\"popupmenu_popup headermenu_popup\" id=\"mymenu_menu\" style=\"display: none\">\r\n                 ");
	if (userid>0)
	{

	templateBuilder.Append("\r\n                    <ul class=\"sel_my\">\r\n                      <li><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("mytopics.aspx\">我的主题</a></li>\r\n                      <li><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("myposts.aspx\">我的帖子</a></li>\r\n                      <li><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("search.aspx?posterid=current&type=digest&searchsubmit=1\">我的精华</a></li>\r\n                      <li><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("myattachment.aspx\">我的附件</a></li>\r\n                      <li><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercpsubscribe.aspx\">我的收藏</a></li>\r\n                    ");
	if (config.Enablespace==1)
	{

	templateBuilder.Append("\r\n                          <li class=\"myspace\"><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("space/\">我的空间</a></li>\r\n                    ");
	}	//end if


	if (config.Enablealbum==1)
	{

	templateBuilder.Append("\r\n                          <li class=\"myalbum\"><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("showalbumlist.aspx?uid=");
	templateBuilder.Append(userid.ToString());
	templateBuilder.Append("\">我的相册</a></li>\r\n                    ");
	}	//end if

	templateBuilder.Append("\r\n                      </ul>\r\n                 ");
	}
	else
	{


	}	//end if


	if (config.Allowchangewidth==1&&pagename!="website.aspx")
	{

	templateBuilder.Append("\r\n                         <ul class=\"sel_mb\">\r\n                      <li><a href=\"javascript:;\" onclick=\"widthauto(this,'");
	templateBuilder.Append(cssdir.ToString());
	templateBuilder.Append("')\">");
	if (isnarrowpage)
	{

	templateBuilder.Append("切换到宽版");
	}
	else
	{

	templateBuilder.Append("切换到窄版");
	}	//end if

	templateBuilder.Append("</a></li>\r\n                    </ul>\r\n                  ");
	}	//end if

	templateBuilder.Append("\r\n            </div>\r\n            <ul id=\"usercenter_menu\" class=\"p_pop\" style=\"display:none;\">\r\n                <li><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercpprofile.aspx?action=avatar\"><span class=\"PrivateBTNavList\">设置头像</span></a></li>\r\n                <li><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercpprofile.aspx\"><span class=\"PrivateBTNavList\">个人资料</span></a></li>\r\n                <li><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercpnewpassword.aspx\"><span class=\"PrivateBTNavList\">更改密码</span></a></li>\r\n                <li><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercp.aspx\"><span class=\"PrivateBTNavList\">用户组</span></a></li>\r\n                <li><a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("usercpcreaditstransferlog.aspx\"><span class=\"PrivateBTNavList\">积分</span></a></li>\r\n            </ul>\r\n			<ul id=\"menu\" class=\"cl\">\r\n				");
	templateBuilder.Append(mainnavigation.ToString());
	templateBuilder.Append("\r\n			</ul>\r\n		</div>\r\n	</div>\r\n</div>\r\n");
	}
	else
	{


	Response.Clear();
	Response.ContentType = "Text/XML";
	Response.Expires = 0;
	Response.Cache.SetNoStore();
	
	templateBuilder.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?><root><![CDATA[\r\n");
	}	//end if




	if (page_err==0)
	{

	templateBuilder.Append("\r\n	    <div id=\"floatlayout_topicadmin\">\r\n          <h3 class=\"flb\">\r\n            <em id=\"return_emailfriend\">种子节点列表</em>\r\n            <span><a href=\"javascript:;\" class=\"flbc\" onclick=\"hideWindow('showseedpeer");
	templateBuilder.Append(seedid.ToString());
	templateBuilder.Append("')\" title=\"关闭(ESC)\">关闭</a></span>\r\n          </h3>\r\n          <h3 class=\"flb\">\r\n              <em id=\"em1\">\r\n                  <a href=\"showtopic-");
	templateBuilder.Append(seedinfo.TopicId.ToString().Trim());
	templateBuilder.Append(".aspx\">\r\n                  ");
	if (seedinfo.DownloadRatio==0)
	{

	templateBuilder.Append("\r\n                      <font style=\"color:#00F\">");
	templateBuilder.Append(seedinfo.TopicTitle.ToString().Trim());
	templateBuilder.Append("</font>\r\n                  ");
	}
	else
	{

	templateBuilder.Append("\r\n                      ");
	templateBuilder.Append(seedinfo.TopicTitle.ToString().Trim());
	templateBuilder.Append("\r\n                  ");
	}	//end if

	templateBuilder.Append("\r\n                  </a>\r\n              </em>\r\n          </h3>\r\n          <h3 class=\"flb\">\r\n              <em id=\"em1\">\r\n                  <img class=\"PrivateBTInlineIMG\" src=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append("templates/");
	templateBuilder.Append(templatepath.ToString());
	templateBuilder.Append("/images/bt/");
	templateBuilder.Append(seedinfo.Type.ToString().Trim());
	templateBuilder.Append(".png\" title=\"");
	templateBuilder.Append(PrivateBT.Type2Name(seedinfo.Type).ToString().Trim());
	templateBuilder.Append("\" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\r\n                  <a href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("downloadseed.aspx?seedid=");
	templateBuilder.Append(seedinfo.SeedId.ToString().Trim());
	templateBuilder.Append("\">\r\n                      <img class=\"PrivateBTInlineIMG\" src=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append("templates/");
	templateBuilder.Append(templatepath.ToString());
	templateBuilder.Append("/images/bt/download.gif\" title=\"下载种子\"/>\r\n                  </a>\r\n                  ");
	if (rationote!="")
	{

	templateBuilder.Append("&nbsp;&nbsp;&nbsp;&nbsp;");
	templateBuilder.Append(rationote.ToString());
	}	//end if

	templateBuilder.Append("\r\n              </em>\r\n          </h3>\r\n          <div class=\"PrivateBTInfoFileListBorder\" id=\"PrivateBTInfoListBorder_showseedpeer");
	templateBuilder.Append(seedid.ToString());
	templateBuilder.Append("\">\r\n              <div class=\"PrivateBTInfoListBorder2\" id=\"PrivateBTInfoListBorder2_showseedpeer");
	templateBuilder.Append(seedid.ToString());
	templateBuilder.Append("\">\r\n                 <!--  列表开始 -->\r\n                 ");
	if (userid==1)
	{

	templateBuilder.Append("\r\n                   <table class=\"PrivateBTPeerListTable\">\r\n                         <tr class=\"PrivateBTPeerListTitle\">\r\n                                      <td width=\"8%\">用户名</td>\r\n                                      <td width=\"5%\">共享率</td>\r\n                                      <td width=\"25%\">IP地址</td>\r\n                                      <td width=\"8%\">IP</td>\r\n                                      <td width=\"5%\">端口</td>\r\n                                      <td width=\"5%\">进度</td>\r\n                                      <td width=\"7%\">上传</td>\r\n                                      <td width=\"7%\">上传速度</td>\r\n                                      <td width=\"7%\">下载</td>\r\n                                      <td width=\"7%\">下载速度</td>\r\n                                      <td width=\"8%\">活动时间</td>\r\n                                      <td width=\"8%\" class=\"PrivateBTInfoListR\">客户端</td>\r\n                         </tr>\r\n                         ");
	if (peerlist.Rows.Count==0)
	{

	templateBuilder.Append("<tr class=\"PrivateBTPeerList\"><td colspan=\"11\" align=\"left\">该种子没有活动节点</td></tr>");
	}	//end if


	int peer__loop__id=0;
	foreach(DataRow peer in peerlist.Rows)
	{
		peer__loop__id++;

	templateBuilder.Append("\r\n                         <tr class=\"PrivateBTPeerList\">\r\n                            <td width=\"8%\"><a class=\"PrivateBTLink_black\" href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append("userinfo-" + peer["uid"].ToString().Trim() + ".aspx\">" + peer["username"].ToString().Trim() + "</a></td>\r\n                            <td width=\"5%\">" + peer["rat"].ToString().Trim() + "</td>\r\n                            <td width=\"25%\">\r\n                               \r\n                              ");
	if (peer["lastsend"].ToString().Trim()=="-1")
	{

	templateBuilder.Append("\r\n                                  <span title = \"IP优化：[限学院路]\" style=\"color:Red\">\r\n                              ");
	}
	else if (peer["lastsend"].ToString().Trim()=="-2"||peer["lastsend"].ToString().Trim()=="101")
	{

	templateBuilder.Append("\r\n                                  <span title = \"IP优化：[限沙河]\" style=\"color:Blue\">\r\n                              ");
	}
	else if (peer["lastsend"].ToString().Trim()=="0")
	{

	templateBuilder.Append("\r\n                                  <span>\r\n                              ");
	}
	else
	{

	templateBuilder.Append("\r\n                                  <span title = \"IP优化：[限本区:" + peer["lastsend"].ToString().Trim() + "]\" style=\"color:Purple\">\r\n                              ");
	}	//end if

	templateBuilder.Append("\r\n                              " + peer["ip"].ToString().Trim() + "&nbsp;/&nbsp;" + peer["ipv6ip"].ToString().Trim() + "</span>\r\n                            </td>\r\n                            <td width=\"8%\">" + peer["ipstr"].ToString().Trim() + "</td>\r\n                            <td width=\"5%\">" + peer["port"].ToString().Trim() + "</td>\r\n                            <td width=\"5%\">" + peer["per"].ToString().Trim() + "</td>\r\n                            <td width=\"7%\">" + peer["up"].ToString().Trim() + "</td>\r\n                            <td width=\"7%\">" + peer["upspeed"].ToString().Trim() + "</td>\r\n                            <td width=\"7%\">" + peer["down"].ToString().Trim() + "</td>\r\n                            <td width=\"7%\">" + peer["downspeed"].ToString().Trim() + "</td>\r\n                            <td width=\"8%\">" + peer["active"].ToString().Trim() + "</td>\r\n                            <td width=\"8%\" class=\"PrivateBTInfoListR\">" + peer["client"].ToString().Trim() + "</td>\r\n                         </tr>\r\n                         ");
	}	//end loop

	templateBuilder.Append("\r\n                          <tr class=\"PrivateBTPeerListTitle\">\r\n                            <td width=\"8%\">用户名</td>\r\n                            <td width=\"5%\">共享率</td>\r\n                            <td width=\"25%\">IP地址</td>\r\n                            <td width=\"8%\">IP</td>\r\n                            <td width=\"5%\">端口</td>\r\n                            <td width=\"5%\">进度</td>\r\n                            <td width=\"7%\">上传</td>\r\n                            <td width=\"7%\">上传速度</td>\r\n                            <td width=\"7%\">下载</td>\r\n                            <td width=\"7%\">下载速度</td>\r\n                            <td width=\"8%\">活动时间</td>\r\n                            <td width=\"8%\" class=\"PrivateBTInfoListR\">客户端</td>\r\n                         </tr>\r\n                     </table>\r\n                 ");
	}
	else
	{

	templateBuilder.Append("\r\n                     <table class=\"PrivateBTPeerListTable\">\r\n                           <tr class=\"PrivateBTPeerListTitle\">\r\n                                        <td width=\"14%\">用户名</td>\r\n                                        <td width=\"8%\">共享率</td>\r\n                                        <td width=\"10%\">IP</td>\r\n                                        <td width=\"8%\">进度</td>\r\n                                        <td width=\"10%\">上传</td>\r\n                                        <td width=\"10%\">上传速度</td>\r\n                                        <td width=\"10%\">下载</td>\r\n                                        <td width=\"10%\">下载速度</td>\r\n                                        <td width=\"10%\">活动时间</td>\r\n                                        <td width=\"10%\" class=\"PrivateBTInfoListR\">客户端</td>\r\n                           </tr>\r\n                           ");
	if (peerlist.Rows.Count==0)
	{

	templateBuilder.Append("<tr class=\"PrivateBTPeerList\"><td colspan=\"11\" align=\"left\">该种子没有活动节点</td></tr>");
	}	//end if


	int peer__loop__id=0;
	foreach(DataRow peer in peerlist.Rows)
	{
		peer__loop__id++;

	templateBuilder.Append("\r\n                           <tr class=\"PrivateBTPeerList\">\r\n                              <td width=\"14%\"><a class=\"PrivateBTLink_black\" href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append("userinfo-" + peer["uid"].ToString().Trim() + ".aspx\">" + peer["username"].ToString().Trim() + "</a></td>\r\n                              <td width=\"8%\">" + peer["rat"].ToString().Trim() + "</td>\r\n                              <td width=\"10%\">" + peer["ipstr"].ToString().Trim() + "</td>\r\n                              <td width=\"8%\">" + peer["per"].ToString().Trim() + "</td>\r\n                              <td width=\"10%\">" + peer["up"].ToString().Trim() + "</td>\r\n                              <td width=\"10%\">" + peer["upspeed"].ToString().Trim() + "</td>\r\n                              <td width=\"10%\">" + peer["down"].ToString().Trim() + "</td>\r\n                              <td width=\"10%\">" + peer["downspeed"].ToString().Trim() + "</td>\r\n                              <td width=\"10%\">" + peer["active"].ToString().Trim() + "</td>\r\n                              <td width=\"10%\" class=\"PrivateBTInfoListR\">" + peer["client"].ToString().Trim() + "</td>\r\n                           </tr>\r\n                           ");
	}	//end loop

	templateBuilder.Append("\r\n                            <tr class=\"PrivateBTPeerListTitle\">\r\n                                <td width=\"14%\">用户名</td>\r\n                                <td width=\"8%\">共享率</td>\r\n                                <td width=\"10%\">IP</td>\r\n                                <td width=\"8%\">进度</td>\r\n                                <td width=\"10%\">上传</td>\r\n                                <td width=\"10%\">上传速度</td>\r\n                                <td width=\"10%\">下载</td>\r\n                                <td width=\"10%\">下载速度</td>\r\n                                <td width=\"10%\">活动时间</td>\r\n                                <td width=\"10%\" class=\"PrivateBTInfoListR\">客户端</td>\r\n                           </tr>\r\n                       </table>\r\n                 ");
	}	//end if

	templateBuilder.Append("\r\n                 <!--  列表结束 -->\r\n              </div>\r\n          </div>\r\n          \r\n          \r\n          <h3 class=\"PrivateBTInfoListNote\">\r\n              正在上传：");
	templateBuilder.Append(seedinfo.Upload.ToString().Trim());
	templateBuilder.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\r\n              正在下载：");
	templateBuilder.Append(seedinfo.Download.ToString().Trim());
	templateBuilder.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\r\n              累计完成：");
	templateBuilder.Append(seedinfo.Finished.ToString().Trim());
	templateBuilder.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\r\n              累计流量：");
	templateBuilder.Append(PTTools.Upload2Str(seedinfo.Traffic,false).ToString().Trim());
	templateBuilder.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\r\n              存活时间：");
	templateBuilder.Append(PTTools.Minutes2String(seedinfo.Live/60.0).ToString().Trim());
	templateBuilder.Append("\r\n          </h3>\r\n     </div>\r\n    ");
	}
	else
	{

	templateBuilder.Append("\r\n     <div id=\"floatlayout_topicadmin\">\r\n          <h3 class=\"flb\">\r\n              <em id=\"return_emailfriend\">种子节点列表</em>\r\n              <span><a href=\"javascript:;\" class=\"flbc\" onclick=\"hideWindow('showseedpeer");
	templateBuilder.Append(seedid.ToString());
	templateBuilder.Append("')\" title=\"关闭\">关闭</a></span>\r\n          </h3>\r\n          <div id=\"PrivateBTInfoListBorder\">\r\n              <div id=\"PrivateBTInfoListBorder2\">\r\n                  ");
	templateBuilder.Append("<div class=\"wrap cl\">\r\n<div class=\"main\">\r\n	<div class=\"msgbox\">\r\n		<h1>出现了");
	templateBuilder.Append(page_err.ToString());
	templateBuilder.Append("个错误</h1>\r\n		<hr class=\"solidline\"/>\r\n		<div class=\"msg_inner error_msg\">\r\n			<p>");
	templateBuilder.Append(msgbox_text.ToString());
	templateBuilder.Append("</p>\r\n			<p class=\"errorback\"> \r\n				<a href=\"forumindex.aspx\">论坛首页</a>\r\n				");
	if (usergroupid==7)
	{

	templateBuilder.Append("\r\n				 &nbsp; &nbsp;|&nbsp; &nbsp; <a href=\"login.aspx\">登录</a>&nbsp; &nbsp;|&nbsp; &nbsp; <a href=\"register.aspx\">注册</a>\r\n				");
	}	//end if

	templateBuilder.Append("\r\n			</p>\r\n		</div>\r\n	</div>\r\n</div>\r\n</div>");

	templateBuilder.Append("\r\n              </div>\r\n          </div>\r\n    </div>     \r\n    ");
	}	//end if



	if (infloat!=1)
	{


	if (pagename=="website.aspx")
	{

	templateBuilder.Append("    \r\n       <div id=\"websitebottomad\"></div>\r\n");
	}
	else if (footerad!="")
	{

	templateBuilder.Append(" \r\n     <div id=\"ptnotice_footerbanner\">");
	templateBuilder.Append(footerad.ToString());
	templateBuilder.Append("</div>   \r\n");
	}	//end if

	templateBuilder.Append("\r\n<div id=\"footer\">\r\n	<div class=\"wrap\"  id=\"wp\">\r\n  <div id=\"footlinks\">\r\n        <p>推荐屏幕分辨率1366或以上&nbsp;&nbsp;&nbsp;<a href=\"http://bt.buaa6.edu.cn\" target=\"_blank\">北京航空航天大学 未来花园</a>&nbsp; \r\n        </p>\r\n        <a href=\"http://bt.buaa6.edu.cn\" target=\"_blank\">Discuz!NT 3.6</a>&nbsp; \r\n  </div>\r\n		<a title=\"Powered by Discuz!NT\" target=\"_blank\" href=\"http://nt.discuz.net\"><img border=\"0\" alt=\"Discuz!NT\" src=\"");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("/discuznt_logo.gif\"/></a>\r\n		<p id=\"copyright\">\r\n			Powered by <strong><a href=\"http://nt.discuz.net\" target=\"_blank\" title=\"Discuz!NT\">Discuz!NT</a></strong> <em class=\"f_bold\">3.6.711</em>\r\n			");
	if (config.Licensed==1)
	{

	templateBuilder.Append("\r\n				(<a href=\"\" onclick=\"this.href='http://nt.discuz.net/certificate/?host='+location.href.substring(0, location.href.lastIndexOf('/'))\" target=\"_blank\">Licensed</a>)\r\n			");
	}	//end if

	templateBuilder.Append("\r\n				");
	templateBuilder.Append(config.Forumcopyright.ToString().Trim());
	templateBuilder.Append("\r\n		</p>\r\n		<p id=\"debuginfo\" class=\"grayfont\">\r\n		");
	if (config.Debug!=0)
	{

	templateBuilder.Append("\r\n			Processed in ");
	templateBuilder.Append(this.Processtime.ToString().Trim());
	templateBuilder.Append(" second(s)\r\n			");
	if (isguestcachepage==1)
	{

	templateBuilder.Append("\r\n				(Cached).\r\n			");
	}
	else if (querycount>1)
	{

	templateBuilder.Append("\r\n				 , ");
	templateBuilder.Append(querycount.ToString());
	templateBuilder.Append(" queries.\r\n			");
	}
	else
	{

	templateBuilder.Append("\r\n				 , ");
	templateBuilder.Append(querycount.ToString());
	templateBuilder.Append(" query.\r\n			");
	}	//end if


	}	//end if

	templateBuilder.Append("\r\n		</p>\r\n	</div>\r\n</div>\r\n<a id=\"scrolltop\" href=\"javascript:;\" style=\"display:none;\" class=\"scrolltop\" onclick=\"setScrollToTop(this.id);\">TOP</a>\r\n\r\n");
	int prentid__loop__id=0;
	foreach(string prentid in mainnavigationhassub)
	{
		prentid__loop__id++;

	templateBuilder.Append("\r\n<ul class=\"p_pop\" id=\"menu_");
	templateBuilder.Append(prentid.ToString());
	templateBuilder.Append("_menu\" style=\"display: none\">\r\n");
	int subnav__loop__id=0;
	foreach(DataRow subnav in subnavigation.Rows)
	{
		subnav__loop__id++;

	bool isoutput = false;
	

	if (subnav["parentid"].ToString().Trim()==prentid)
	{


	if (subnav["level"].ToString().Trim()=="0")
	{

	 isoutput = true;
	

	}
	else
	{


	if (subnav["level"].ToString().Trim()=="1" && userid>0)
	{

	 isoutput = true;
	

	}
	else
	{

	bool leveluseradmindi = true;
	
	 leveluseradmindi = (useradminid==3 || useradminid==1 || useradminid==2);
	

	if (subnav["level"].ToString().Trim()=="2" &&  leveluseradmindi)
	{

	 isoutput = true;
	

	}	//end if


	if (subnav["level"].ToString().Trim()=="3" && useradminid==1)
	{

	 isoutput = true;
	

	}	//end if


	}	//end if


	}	//end if


	}	//end if


	if (isoutput)
	{


	if (subnav["id"].ToString().Trim()=="11" || subnav["id"].ToString().Trim()=="12")
	{


	if (config.Statstatus==1)
	{

	templateBuilder.Append("\r\n	" + subnav["nav"].ToString().Trim() + "\r\n        ");	continue;


	}
	else
	{

	continue;


	}	//end if


	}	//end if


	if (subnav["id"].ToString().Trim()=="18")
	{


	if (config.Oltimespan>0)
	{

	templateBuilder.Append("\r\n    " + subnav["nav"].ToString().Trim() + "\r\n	");	continue;


	}
	else
	{

	continue;


	}	//end if


	}	//end if


	if (subnav["id"].ToString().Trim()=="24")
	{


	if (config.Enablespace==1)
	{

	templateBuilder.Append("\r\n    " + subnav["nav"].ToString().Trim() + "\r\n 	");	continue;


	}
	else
	{

	continue;


	}	//end if


	}	//end if


	if (subnav["id"].ToString().Trim()=="25")
	{


	if (config.Enablealbum==1)
	{

	templateBuilder.Append("\r\n    " + subnav["nav"].ToString().Trim() + "\r\n 	");	continue;


	}
	else
	{

	continue;


	}	//end if


	}	//end if


	if (subnav["id"].ToString().Trim()=="26")
	{


	if (config.Enablemall>=1)
	{

	templateBuilder.Append("\r\n    " + subnav["nav"].ToString().Trim() + "\r\n   	");	continue;


	}
	else
	{

	continue;


	}	//end if


	}	//end if

	templateBuilder.Append("\r\n    " + subnav["nav"].ToString().Trim() + "\r\n");
	}	//end if


	}	//end loop

	templateBuilder.Append("\r\n</ul>\r\n");
	}	//end loop


	if (config.Stylejump==1)
	{


	if (userid>0 || config.Guestcachepagetimeout<=0)
	{

	templateBuilder.Append("\r\n	<ul id=\"styleswitcher_menu\" class=\"popupmenu_popup s_clear\" style=\"display: none;\">\r\n	");
	templateBuilder.Append(templatelistboxoptions.ToString());
	templateBuilder.Append("\r\n	</ul>\r\n	");
	}	//end if


	}	//end if




	templateBuilder.Append("</body>\r\n</html>\r\n");
	}
	else
	{

	templateBuilder.Append("\r\n]]></root>\r\n");
	}	//end if




	Response.Write(templateBuilder.ToString());
}
</script>
