<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="Discuz.Web.forumindex" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Discuz.Common" %>
<%@ Import namespace="Discuz.Forum" %>
<%@ Import namespace="Discuz.Entity" %>
<%@ Import namespace="Discuz.Config" %>

<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by Discuz!NT Template Engine at 2015/1/7 16:52:25.
		本页面代码由Discuz!NT模板引擎生成于 2015/1/7 16:52:25. 
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



	templateBuilder.Append("\r\n<div class=\"wrap cl pageinfo\">\r\n	<div id=\"nav\">\r\n		");
	if (usergroupinfo.Allowsearch>0)
	{


	templateBuilder.Append("<form method=\"post\" action=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("search.aspx\" target=\"_blank\" onsubmit=\"bind_keyword(this);\" class=\"y\">\r\n	<input type=\"hidden\" name=\"poster\" />\r\n	<input type=\"hidden\" name=\"keyword\" />\r\n	<input type=\"hidden\" name=\"type\" value=\"\" />\r\n	<input id=\"keywordtype\" type=\"hidden\" name=\"keywordtype\" value=\"0\" />\r\n	<a href=\"javascript:void(0);\" class=\"drop s_type\" id=\"quicksearch\" onclick=\"showMenu(this.id, false);\" onmouseover=\"MouseCursor(this);\">快速搜索</a>\r\n	<input type=\"text\" id=\"quicksearch_textinput\" name=\"keywordf\" value=\"输入搜索关键字:种子标题\" onblur=\"bind_inputmessage(false);\" onclick=\"bind_inputmessage(true);\" onkeydown=\"bind_inputmessage(true);\" class=\"txt\"/>\r\n	<input name=\"searchsubmit\" type=\"submit\" value=\"\" class=\"btnsearch\"/>\r\n</form>\r\n<ul id=\"quicksearch_menu\" class=\"p_pop\" style=\"display: none;\">\r\n	<li><a href=\"###\" onclick=\"$('keywordtype').value='0';$('quicksearch').innerHTML='帖子标题';$('quicksearch_menu').style.display='none';bind_inputmessage(false);\" onmouseover=\"MouseCursor(this);\">帖子标题</a></li>\r\n	");
	if (config.Enablespace==1)
	{

	templateBuilder.Append("\r\n	<li><a href=\"###\" onclick=\"$('keywordtype').value='2';$('quicksearch').innerHTML='空间日志';$('quicksearch_menu').style.display='none';bind_inputmessage(false);\" onmouseover=\"MouseCursor(this);\">空间日志</a></li>\r\n	");
	}	//end if


	if (config.Enablealbum==1)
	{

	templateBuilder.Append("\r\n	<li><a href=\"###\" onclick=\"$('keywordtype').value='3';$('quicksearch').innerHTML='相册标题';$('quicksearch_menu').style.display='none';bind_inputmessage(false);\" onmouseover=\"MouseCursor(this);\">相册标题</a></li>\r\n	");
	}	//end if

	templateBuilder.Append("\r\n	<li><a href=\"###\" onclick=\"$('keywordtype').value='8';$('quicksearch').innerHTML='作者';$('quicksearch_menu').style.display='none';bind_inputmessage(false);\" onmouseover=\"MouseCursor(this);\">作者</a></li>\r\n	<li><a href=\"###\" onclick=\"$('keywordtype').value='9';$('quicksearch').innerHTML='版块';$('quicksearch_menu').style.display='none';bind_inputmessage(false);\" onmouseover=\"MouseCursor(this);\">版块</a></li>\r\n</ul>\r\n<script type=\"text/javascript\">\r\n    function bind_inputmessage(click)\r\n    {\r\n\r\n        if(!click)\r\n        {\r\n            var isdefaultvalue = false;\r\n            if($('quicksearch_textinput').value == \"\" ||$('quicksearch_textinput').value == \"输入搜索关键字:种子标题\" ||$('quicksearch_textinput').value == \"输入搜索关键字:帖子标题\" ||$('quicksearch_textinput').value == \"输入搜索关键字:空间日志\" ||$('quicksearch_textinput').value == \"输入搜索关键字:相册标题\" ||$('quicksearch_textinput').value == \"输入搜索关键字:作者名称\" ||$('quicksearch_textinput').value == \"输入搜索关键字:版块名称\" )\r\n            {\r\n                isdefaultvalue = true;\r\n            }\r\n            else if($('quicksearch').innerHTML=='帖子标题' || $('quicksearch').innerHTML=='快速搜索' )\r\n            {\r\n                if(isdefaultvalue) $('quicksearch_textinput').value = \"输入搜索关键字:帖子标题\";\r\n            }\r\n            else if($('quicksearch').innerHTML=='空间日志')\r\n            {\r\n                if(isdefaultvalue) $('quicksearch_textinput').value = \"输入搜索关键字:空间日志\";\r\n            }\r\n            else if($('quicksearch').innerHTML=='相册标题')\r\n            {\r\n                if(isdefaultvalue) $('quicksearch_textinput').value = \"输入搜索关键字:相册标题\";\r\n            }\r\n            else if($('quicksearch').innerHTML=='作者')\r\n            {\r\n                if(isdefaultvalue) $('quicksearch_textinput').value = \"输入搜索关键字:作者名称\";\r\n            }\r\n            else if($('quicksearch').innerHTML=='版块')\r\n            {\r\n                if(isdefaultvalue) $('quicksearch_textinput').value = \"输入搜索关键字:版块名称\";\r\n            }\r\n         }\r\n         else\r\n         {\r\n\r\n            if($('quicksearch').innerHTML=='帖子标题' || $('quicksearch').innerHTML=='快速搜索' )\r\n            {\r\n                if($('quicksearch_textinput').value == \"输入搜索关键字:帖子标题\") $('quicksearch_textinput').value = \"\";\r\n            }\r\n            else if($('quicksearch').innerHTML=='空间日志')\r\n            {\r\n                if($('quicksearch_textinput').value == \"输入搜索关键字:空间日志\") $('quicksearch_textinput').value = \"\";\r\n            }\r\n            else if($('quicksearch').innerHTML=='相册标题')\r\n            {\r\n                if($('quicksearch_textinput').value == \"输入搜索关键字:相册标题\") $('quicksearch_textinput').value = \"\";\r\n            }\r\n            else if($('quicksearch').innerHTML=='作者')\r\n            {\r\n                if($('quicksearch_textinput').value == \"输入搜索关键字:作者名称\") $('quicksearch_textinput').value = \"\";\r\n            }\r\n            else if($('quicksearch').innerHTML=='版块')\r\n            {\r\n                if($('quicksearch_textinput').value == \"输入搜索关键字:版块名称\") $('quicksearch_textinput').value = \"\";\r\n            }\r\n         }\r\n    }\r\n    function bind_keyword(form) \r\n    {\r\n        if (form.keywordtype.value == '20') \r\n        {\r\n            form.action = '");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("showseeds.aspx?keywords=' + escape(form.keywordf.value).replace(/\\+/g, '%2B').replace(/\\\"/g,'%22').replace(/\\'/g, '%27').replace(/\\//g,'%2F');\r\n        } \r\n        else if (form.keywordtype.value == '9')\r\n        {\r\n            form.action = '");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("forumsearch.aspx?q=' + escape(form.keywordf.value).replace(/\\+/g, '%2B').replace(/\\\"/g,'%22').replace(/\\'/g, '%27').replace(/\\//g,'%2F');\r\n        } \r\n        else if (form.keywordtype.value == '8') \r\n        {\r\n            form.action = '");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("search.aspx?advsearch=1';\r\n            form.keyword.value = '';\r\n            form.poster.value = form.keywordf.value != form.keywordf.defaultValue ? form.keywordf.value.replace(/\\+/g, '%2B').replace(/\\\"/g,'%22').replace(/\\'/g, '%27').replace(/\\//g,'%2F') : '';\r\n        } \r\n        else \r\n        {\r\n            form.action = '");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("search.aspx';\r\n            form.poster.value = '';\r\n            form.keyword.value = form.keywordf.value != form.keywordf.defaultValue ? form.keywordf.value.replace(/\\+/g, '%2B').replace(/\\\"/g,'%22').replace(/\\'/g, '%27').replace(/\\//g,'%2F') : '';\r\n            if (form.keywordtype.value == '2')\r\n                form.type.value = 'spacepost';\r\n            else if (form.keywordtype.value == '3')\r\n                form.type.value = 'album';\r\n            else \r\n                form.type.value = 'topic';\r\n        }\r\n    }\r\n</");
	templateBuilder.Append("script>");


	}	//end if


	if (config.Isframeshow!=0)
	{

	templateBuilder.Append("\r\n		<script type=\"text/javascript\">\r\n		if(top == self) {\r\n			document.write('<a href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append("frame.aspx?f=1\" target=\"_top\" class=\"frameswitch\">分栏模式<\\/a>');\r\n		}\r\n		</");
	templateBuilder.Append("script>\r\n		");
	}	//end if

	templateBuilder.Append("\r\n		<a id=\"forumlist\" href=\"");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("\" ");
	if (config.Forumjump==1)
	{

	templateBuilder.Append("onmouseover=\"showMenu(this.id);\" onmouseout=\"showMenu(this.id);\"");
	}	//end if

	templateBuilder.Append(" class=\"title\">");
	templateBuilder.Append(config.Forumtitle.ToString().Trim());
	templateBuilder.Append("</a> &raquo; 首页\r\n	</div>\r\n</div>\r\n<script type=\"text/javascript\">\r\nvar postminchars = parseInt(");
	templateBuilder.Append(config.Minpostsize.ToString().Trim());
	templateBuilder.Append(");\r\nvar postmaxchars = parseInt(");
	templateBuilder.Append(config.Maxpostsize.ToString().Trim());
	templateBuilder.Append(");\r\nvar disablepostctrl = parseInt(");
	templateBuilder.Append(disablepostctrl.ToString());
	templateBuilder.Append(");\r\n</");
	templateBuilder.Append("script>\r\n<div class=\"wrap cl forum\">\r\n<div class=\"y\" id=\"btnfgbtCheckIn\">\r\n  ");
	if (IsHaveCheckIn()==false)
	{

	templateBuilder.Append("\r\n      <a href=\"#\" class=\"fgbtcheckin\" onclick=\"this.innerHTML='签到中，请稍候...';fgbt_do_checkin();\" title=\"点击签到\">&nbsp;&nbsp;签&nbsp;&nbsp;到&nbsp;&nbsp;</a>\r\n  ");
	}
	else
	{

	int checkinrank = PTUsers.GetCheckInRank(userid);
	

	if (checkinrank>0)
	{

	templateBuilder.Append("\r\n      <a href=\"#\" class=\"fgbtcheckintoday\" title=\"已连续签到");
	templateBuilder.Append(oluserinfo.LastCheckInCount.ToString().Trim());
	templateBuilder.Append("天\">今天第");
	templateBuilder.Append(checkinrank.ToString());
	templateBuilder.Append("个签到</a>\r\n    ");
	}
	else
	{

	templateBuilder.Append("\r\n      <a href=\"#\" class=\"fgbtcheckintoday\" title=\"已连续签到");
	templateBuilder.Append(oluserinfo.LastCheckInCount.ToString().Trim());
	templateBuilder.Append("天\">今天已签到</a>\r\n    ");
	}	//end if


	}	//end if

	templateBuilder.Append("\r\n</div>\r\n<div class=\"announcement cl\">\r\n	<div onmouseout=\"annstop = 0\" onmouseover=\"annstop = 1\" id=\"announcement\">\r\n		<span>公告:</span>\r\n		<div id=\"announcementbody\">\r\n			<ul>		\r\n			");
	int announcement__loop__id=0;
	foreach(DataRow announcement in announcementlist.Rows)
	{
		announcement__loop__id++;

	string announcementlastdatetime = ForumUtils.ConvertDateTime(announcement["starttime"].ToString().Trim());
	
	templateBuilder.Append("\r\n				<li><a href=\"announcement.aspx#" + announcement["id"].ToString().Trim() + "\" class=\"xg2\" title=\"" + announcement["title"].ToString().Trim() + "\">" + announcement["title"].ToString().Trim() + "<em>");
	templateBuilder.Append(announcementlastdatetime.ToString());
	templateBuilder.Append("</em></a></li>\r\n			");
	}	//end loop

	templateBuilder.Append("\r\n			</ul>\r\n		</div>\r\n	</div>\r\n	<script type=\"text/javascript\" src=\"");
	templateBuilder.Append(jsdir.ToString());
	templateBuilder.Append("/template_announcement.js\"></");
	templateBuilder.Append("script>\r\n</div>\r\n");

	if (pagewordad.Length>0)
	{

	templateBuilder.Append("\r\n<div id=\"ptnotice_text\" class=\"ptnotice_text sclear\">\r\n	<table cellspacing=\"1\" cellpadding=\"0\" width=\"100%\" summary=\"text ptnotice\">\r\n	<tbody>\r\n		<tr>\r\n		");	int adindex = 0;
	

	int pageword__loop__id=0;
	foreach(string pageword in pagewordad)
	{
		pageword__loop__id++;


	if (adindex<4)
	{

	templateBuilder.Append("\r\n			<td>");
	templateBuilder.Append(pageword.ToString());
	templateBuilder.Append("</td>\r\n				");	 adindex = adindex+1;
	

	}
	else
	{

	templateBuilder.Append("\r\n		</tr><tr>\r\n			<td>");
	templateBuilder.Append(pageword.ToString());
	templateBuilder.Append("</td>\r\n				");	 adindex = 1;
	

	}	//end if


	}	//end loop


	if (pagewordad.Length%4>0)
	{


					for (int j = 0; j < (4 - pagewordad.Length % 4); j++)
					{
				
	templateBuilder.Append("\r\n			<td>&nbsp;</td>\r\n			");
					}
				

	}	//end if

	templateBuilder.Append("\r\n		</tr>\r\n	</tbody>\r\n	</table>\r\n</div>\r\n");
	}	//end if


	if (pagead.Count>0)
	{


	int pageadtext__loop__id=0;
	foreach(string pageadtext in pagead)
	{
		pageadtext__loop__id++;

	templateBuilder.Append("\r\n        <div class=\"ptnotice_text sclear\">\r\n            ");
	templateBuilder.Append(pageadtext.ToString());
	templateBuilder.Append("\r\n        </div>\r\n    ");
	}	//end loop


	}	//end if



	templateBuilder.Append("\r\n<div class=\"topic_num cl\">\r\n	<span class=\"y\">\r\n	  <a href=\"showtopiclist.aspx?type=newimage\" class=\"xg2\">查看新图</a><span class=\"pipe\">|</span>\r\n		<a href=\"showtopiclist.aspx?type=newtopic\" class=\"xg2\">查看新帖</a><span class=\"pipe\">|</span>\r\n		<a href=\"showtopiclist.aspx?type=digest&amp;forums=all\" class=\"xg2\">精华区</a>\r\n	");
	if (config.Rssstatus!=0)
	{

	templateBuilder.Append("	\r\n		<a href=\"tools/rss.aspx\" target=\"_blank\"><img src=\"");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("/icon_feed.gif\" alt=\"rss\"/></a>\r\n	");
	}	//end if


	if (config.Stylejump==1)
	{


	if (userid!=-1 || config.Guestcachepagetimeout<=0)
	{

	templateBuilder.Append("\r\n		<a id=\"styleswitcherhome\" onmouseover=\"showMenu(this.id)\" onclick=\"window.location.href='");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append("showtemplate.aspx'\" style=\"text-decoration:none;\">\r\n		<img src=\"");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("/style.gif\" alt=\"风格切换\"/>\r\n		</a>\r\n	");
	}	//end if


	}	//end if

	templateBuilder.Append("\r\n	</span>\r\n	今日:<em class=\"xg2\">");
	templateBuilder.Append(todayposts.ToString());
	templateBuilder.Append("</em><span class=\"pipe\">|</span>昨日:<em class=\"xg2\">");
	templateBuilder.Append(yesterdayposts.ToString());
	templateBuilder.Append("</em><span class=\"pipe\">|</span>最高:<em title=\"(");
	templateBuilder.Append(highestpostsdate.ToString());
	templateBuilder.Append(")\" class=\"xg2\">");
	templateBuilder.Append(highestposts.ToString());
	templateBuilder.Append("</em><span class=\"pipe\">|</span>主题:<em class=\"xg2\">");
	templateBuilder.Append(totaltopic.ToString());
	templateBuilder.Append("</em><span class=\"pipe\">|</span>帖子:<em class=\"xg2\">");
	templateBuilder.Append(totalpost.ToString());
	templateBuilder.Append("</em><span class=\"pipe\">|</span>会员:<em class=\"xg2\">");
	templateBuilder.Append(totalusers.ToString());
	templateBuilder.Append("</em><span class=\"pipe\">|</span>欢迎新会员:<a href=\"");
	templateBuilder.Append(UserInfoAspxRewrite(lastuserid).ToString());
	templateBuilder.Append("\" class=\"xg2\">");
	templateBuilder.Append(lastusername.ToString());
	templateBuilder.Append("</a>\r\n</div>\r\n");

	if (forumhotconfiginfo.Enable)
	{

	templateBuilder.Append("\r\n<link rel=\"stylesheet\" href=\"");
	templateBuilder.Append(cssdir.ToString());
	templateBuilder.Append("/forumhot.css\" type=\"text/css\" media=\"all\" />\r\n<script type=\"text/javascript\"  src=\"");
	templateBuilder.Append(jsdir.ToString());
	templateBuilder.Append("/slide.js\"></");
	templateBuilder.Append("script>\r\n<script type=\"text/javascript\">\r\n    function tabselect(id) {\r\n        $('hot_layer_' + id).style.display = ''\r\n        $('tab_li_' + id).className = 'current'\r\n        for (var i = 1; i <= 5; i++) {\r\n            if (i != id) {\r\n                if ($('tab_li_' + i)) {\r\n                    $('tab_li_' + i).className = 'switchNavItem'\r\n                    $('hot_layer_' + i).style.display = 'none';\r\n                }\r\n            }\r\n        }\r\n    }\r\n    function hottopicjump(id){\r\n        window.location.href='showforum-' + id + '.aspx';\r\n    }\r\n</");
	templateBuilder.Append("script>\r\n<div class=\"main cl forumhot\">\r\n    <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\">\r\n	    <tbody>\r\n	        <tr>\r\n		        <td width=\"375\">\r\n		            ");
	int forumhotiteminfo__loop__id=0;
	foreach(ForumHotItemInfo forumhotiteminfo in forumhotconfiginfo.ForumHotCollection)
	{
		forumhotiteminfo__loop__id++;


	if (forumhotiteminfo.Datatype=="pictures")
	{

	templateBuilder.Append("\r\n			                <div class=\"title_bar xg2\">\r\n				                 <a href=\"showtopiclist.aspx?type=newimage\"><h2>");
	templateBuilder.Append(forumhotiteminfo.Name.ToString().Trim());
	templateBuilder.Append(" [ 更多.. ]</h2></a>\r\n			                </div>\r\n                            <div id=\"focusViwer\">\r\n                                <div id=\"imgADPlayer\"></div> \r\n                                <script  type=\"text/javascript\">\r\n                                    var hotimagesarray = eval('");
	templateBuilder.Append(ForumHots.HotImagesArray(forumhotiteminfo,usergroupid,ipaddress,btuserinfo.Extcredits2).ToString().Trim());
	templateBuilder.Append("');\r\n                                    for (i = 0; i < hotimagesarray.length; i++) {\r\n                                        var title=");
	templateBuilder.Append(forumhotiteminfo.Topictitlelength.ToString().Trim());
	templateBuilder.Append(">0?hotimagesarray[i].title.substr(0,");
	templateBuilder.Append(forumhotiteminfo.Topictitlelength.ToString().Trim());
	templateBuilder.Append("):'';\r\n                                        PImgPlayer.addItem(\"\" + title + \"\", \"\" + hotimagesarray[i].url + \"\", \"\" + hotimagesarray[i].img + \"\");\r\n                                    }\r\n                                    if(hotimagesarray.length>0)\r\n                                        PImgPlayer.init(\"imgADPlayer\", 360, 240);   \r\n                                </");
	templateBuilder.Append("script>\r\n                            </div>\r\n			            ");
	}	//end if


	}	//end loop

	templateBuilder.Append("\r\n		        </td>\r\n		        <td>\r\n		            <div class=\"title_bar xg2\">\r\n			            <ul id=\"tabswi1_A\" class=\"tab_forumhot\">\r\n			            ");
	int forumhotiteminfo1__loop__id=0;
	foreach(ForumHotItemInfo forumhotiteminfo1 in forumhotconfiginfo.ForumHotCollection)
	{
		forumhotiteminfo1__loop__id++;


	if (forumhotiteminfo1.Id!=6 && forumhotiteminfo1.Enabled==1)
	{

	templateBuilder.Append("\r\n				                <li class=\"switchNavItem\" index=\"2\" id=\"tab_li_");
	templateBuilder.Append(forumhotiteminfo1.Id.ToString().Trim());
	templateBuilder.Append("\"><a href=\"javascript:");
	if ((forumhotiteminfo1.Forumlist.Length>0 && forumhotiteminfo1.Forumlist.IndexOf(",")<0))
	{

	templateBuilder.Append("hottopicjump('");
	templateBuilder.Append(forumhotiteminfo1.Forumlist.ToString().Trim());
	templateBuilder.Append("');");
	}	//end if

	templateBuilder.Append("\"  onmousemove=\"tabselect(");
	templateBuilder.Append(forumhotiteminfo1.Id.ToString().Trim());
	templateBuilder.Append(")\">");
	templateBuilder.Append(forumhotiteminfo1.Name.ToString().Trim());
	templateBuilder.Append("</a></li>\r\n				            ");
	}	//end if


	}	//end loop

	templateBuilder.Append("\r\n			            </ul>\r\n		            </div>\r\n		            <div id=\"tabswi1_B\" class=\"pd cl\">\r\n		            ");
	int forumhotiteminfo2__loop__id=0;
	foreach(ForumHotItemInfo forumhotiteminfo2 in forumhotconfiginfo.ForumHotCollection)
	{
		forumhotiteminfo2__loop__id++;


	if (forumhotiteminfo2.Id!=6 && forumhotiteminfo2.Enabled==1)
	{


	if (forumhotiteminfo2.Datatype=="topics")
	{

	templateBuilder.Append("\r\n			                    <div class=\"newHotB\" name=\"hot_layer_");
	templateBuilder.Append(forumhotiteminfo2.Id.ToString().Trim());
	templateBuilder.Append("\" id=\"hot_layer_");
	templateBuilder.Append(forumhotiteminfo2.Id.ToString().Trim());
	templateBuilder.Append("\"  style=\"display:none\">	\r\n				                    ");
	int hottopic__loop__id=0;
	foreach(DataRow hottopic in ForumHots.GetTopicList(forumhotiteminfo2).Rows)
	{
		hottopic__loop__id++;

	string topicsname2 = Utils.RemoveHtml(hottopic["title"].ToString().Trim());
	
	string topicsname = forumhotiteminfo2.Topictitlelength>0?Utils.GetSubString(Utils.RemoveHtml(hottopic["title"].ToString().Trim()),forumhotiteminfo2.Topictitlelength*2,""):"";
	
	string forumsname = forumhotiteminfo2.Forumnamelength>0?Utils.GetSubString(Utils.RemoveHtml(hottopic["name"].ToString().Trim()),forumhotiteminfo2.Forumnamelength*2,""):"";
	
	 aspxrewriteurl = this.ShowTopicAspxRewrite(hottopic["tid"].ToString().Trim(),0);
	
	string aspxrewriteurl1 = this.ShowForumAspxRewrite(hottopic["fid"].ToString().Trim(),0);
	

	if (hottopic__loop__id==1)
	{

	int tid = TypeConverter.ObjectToInt(hottopic["tid"]);
	

	int firsttopic__loop__id=0;
	foreach(DataRow firsttopic in ForumHots.GetFirstPostInfo(tid,forumhotiteminfo2.Cachetimeout).Rows)
	{
		firsttopic__loop__id++;


	if (firsttopic["layer"].ToString().Trim()=="0")
	{

	string message = ForumHots.RemoveUbb(firsttopic["message"].ToString().Trim(),300);
	
	templateBuilder.Append("\r\n						                        <dl class=\"i_hot\">\r\n							                        <dt class=\"xg2\"><a href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\" target=\"_blank\"  title=\"");
	templateBuilder.Append(topicsname2.ToString());
	templateBuilder.Append("\">");
	templateBuilder.Append(topicsname.ToString());
	templateBuilder.Append("</a></dt>\r\n							                         <dd>");
	templateBuilder.Append(message.ToString());
	templateBuilder.Append("</dd>\r\n						                        </dl>\r\n						                        ");
	}	//end if


	}	//end loop


	}
	else
	{


	if (hottopic__loop__id==8 || hottopic__loop__id==2)
	{

	templateBuilder.Append("\r\n					                        <ul class=\"hotlist\">\r\n					                        ");
	}	//end if

	templateBuilder.Append("					\r\n					                        <li>");
	if (forumhotiteminfo2.Forumnamelength>0)
	{

	templateBuilder.Append("<a href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append(aspxrewriteurl1.ToString());
	templateBuilder.Append("\" target=\"_blank\">[&nbsp;");
	templateBuilder.Append(forumsname.ToString());
	templateBuilder.Append("&nbsp;]</a>&nbsp;");
	}	//end if


	if (hottopic["typeid"].ToString().Trim()!="0")
	{

	templateBuilder.Append("<a href=\"showforum.aspx?forumid=" + hottopic["fid"].ToString().Trim() + "&typeid=" + hottopic["typeid"].ToString().Trim() + "\" >[&nbsp;" + hottopic["typename"].ToString().Trim() + "&nbsp;]</a>&nbsp;");
	}	//end if

	templateBuilder.Append("\r\n					                        <a href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\" target=\"_blank\" class=\"xg2\"  title=\"");
	templateBuilder.Append(topicsname2.ToString());
	templateBuilder.Append("\">");
	templateBuilder.Append(topicsname.ToString());
	templateBuilder.Append("</a></li>\r\n					                        ");
	if (hottopic__loop__id==7 || hottopic__loop__id==13)
	{

	templateBuilder.Append("\r\n					                        </ul>\r\n					                        ");
	}	//end if


	}	//end if


	}	//end loop

	templateBuilder.Append("\r\n				                </div>\r\n			                ");
	}	//end if


	if (forumhotiteminfo2.Datatype=="users")
	{

	templateBuilder.Append("\r\n			                    <div class=\"newHotB\" name=\"hot_layer_");
	templateBuilder.Append(forumhotiteminfo2.Id.ToString().Trim());
	templateBuilder.Append("\" id=\"hot_layer_");
	templateBuilder.Append(forumhotiteminfo2.Id.ToString().Trim());
	templateBuilder.Append("\" style=\"display:none\">	\r\n				                    ");
	int user__loop__id=0;
	foreach(ShortUserInfo user in ForumHots.GetUserList(forumhotiteminfo2.Dataitemcount,forumhotiteminfo2.Sorttype,forumhotiteminfo2.Cachetimeout,forumhotiteminfo2.Id))
	{
		user__loop__id++;

	 aspxrewriteurl = this.UserInfoAspxRewrite(user.Uid);
	

	if (user__loop__id%10==1 || user__loop__id==1)
	{


	if (user__loop__id==1)
	{

	templateBuilder.Append("\r\n							                    <ul class=\"hotlist cl one\">\r\n						                    ");
	}
	else
	{

	templateBuilder.Append("\r\n							                    <ul class=\"hotlist cl two\">\r\n						                    ");
	}	//end if


	}	//end if

	templateBuilder.Append("\r\n					                    <li>\r\n					                        <em>\r\n					                        [\r\n					                        ");
	if (forumhotiteminfo2.Sorttype=="credits")
	{
	templateBuilder.Append(user.Credits.ToString().Trim());
	}	//end if


	if (forumhotiteminfo2.Sorttype=="posts"||forumhotiteminfo2.Sorttype=="today"||forumhotiteminfo2.Sorttype=="thisweek"||forumhotiteminfo2.Sorttype=="thismonth")
	{
	templateBuilder.Append(user.Posts.ToString().Trim());
	}	//end if


	if (forumhotiteminfo2.Sorttype=="digestposts")
	{
	templateBuilder.Append(user.Digestposts.ToString().Trim());
	}	//end if


	if (forumhotiteminfo2.Sorttype=="lastactivity")
	{
	templateBuilder.Append(user.Lastactivity.ToString().Trim());
	}	//end if


	if (forumhotiteminfo2.Sorttype=="joindate")
	{
	templateBuilder.Append(user.Joindate.ToString().Trim());
	}	//end if

	templateBuilder.Append("\r\n					                        ]\r\n					                        </em>\r\n					                        <img onerror=\"this.onerror=null;this.src='");
	templateBuilder.Append(forumpath.ToString());
	templateBuilder.Append("images/common/noavatar_small.gif';\" src=\"");
	templateBuilder.Append(Avatars.GetAvatarUrl(user.Uid,AvatarSize.Small).ToString().Trim());
	templateBuilder.Append("\" width=\"16\" height=\"16\"><a href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\" target=\"_blank\">");
	templateBuilder.Append(user.Username.ToString().Trim());
	templateBuilder.Append("</a>\r\n					                    </li>\r\n					                    ");
	if (user__loop__id%10==0)
	{

	templateBuilder.Append("\r\n					                    </ul>\r\n					                    ");
	}	//end if


	}	//end loop

	templateBuilder.Append("\r\n			                    </div>\r\n			                ");
	}	//end if


	if (forumhotiteminfo2.Datatype=="forums")
	{

	templateBuilder.Append("\r\n			                    <div class=\"newHotB\" name=\"hot_layer_");
	templateBuilder.Append(forumhotiteminfo2.Id.ToString().Trim());
	templateBuilder.Append("\" id=\"hot_layer_");
	templateBuilder.Append(forumhotiteminfo2.Id.ToString().Trim());
	templateBuilder.Append("\" style=\"display:none\">	\r\n				                    ");
	int foruminfo__loop__id=0;
	foreach(ForumInfo foruminfo in ForumHots.GetHotForumList(forumhotiteminfo2.Dataitemcount,forumhotiteminfo2.Sorttype,forumhotiteminfo2.Cachetimeout,forumhotiteminfo2.Id))
	{
		foruminfo__loop__id++;

	 aspxrewriteurl = this.ShowForumAspxRewrite(Utils.StrToInt(foruminfo.Fid, 0),0);
	

	if (foruminfo__loop__id%10==1 || foruminfo__loop__id==1)
	{


	if (foruminfo__loop__id==1)
	{

	templateBuilder.Append("\r\n							                    <ul class=\"hotlist cl one\">\r\n						                    ");
	}
	else
	{

	templateBuilder.Append("\r\n							                    <ul class=\"hotlist cl two\">\r\n						                    ");
	}	//end if


	}	//end if

	templateBuilder.Append("\r\n					                        <li><em>\r\n					                        [\r\n					                        ");
	if (forumhotiteminfo2.Sorttype=="posts"||forumhotiteminfo2.Sorttype=="today"||forumhotiteminfo2.Sorttype=="thismonth")
	{
	templateBuilder.Append(foruminfo.Posts.ToString().Trim());
	}	//end if


	if (forumhotiteminfo2.Sorttype=="topics")
	{
	templateBuilder.Append(foruminfo.Topics.ToString().Trim());
	}	//end if

	templateBuilder.Append("\r\n                                            ]\r\n					                        </em><a href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\" target=\"_blank\">");
	templateBuilder.Append(foruminfo.Name.ToString().Trim());
	templateBuilder.Append("</a>\r\n					                        </li>\r\n					                    ");
	if (foruminfo__loop__id%10==0)
	{

	templateBuilder.Append("\r\n					                    </ul>\r\n					                    ");
	}	//end if


	}	//end loop

	templateBuilder.Append("\r\n			                    </div>\r\n			                ");
	}	//end if


	}	//end if


	}	//end loop

	templateBuilder.Append("\r\n		            </div>\r\n		        </td>\r\n	        </tr>\r\n	    </tbody>\r\n    </table>\r\n</div>\r\n");
	}	//end if

	templateBuilder.Append("\r\n<script type=\"text/javascript\">\r\n    for (var i = 1; i <= 5; i++) {\r\n        try {\r\n            $('hot_layer_' + i).style.display = ''\r\n            $('tab_li_' + i).className = 'current'\r\n            break;\r\n        }\r\n        catch (e) {\r\n            continue;\r\n        }\r\n    }\r\n</");
	templateBuilder.Append("script>");

	templateBuilder.Append("\r\n<!--topic-->\r\n<div class=\"main cl\" id=\"wp\">\r\n");	int lastforumlayer = -1;
	
	int lastcolcount = 1;
	
	int lastforumid = 0;
	
	int subforumcount = 0;
	
	int subcount = 0;
	

	int forum__loop__id=0;
	foreach(IndexPageForumInfo forum in forumlist)
	{
		forum__loop__id++;


	if (forum.Layer==0)
	{

	 subcount = 0;
	

	if (lastforumlayer>-1)
	{


	if (lastcolcount!=1)
	{


	if (subforumcount!=0)
	{

	for (int i = 0; i < lastcolcount-subforumcount; i++)
	{
		templateBuilder.Append("<td>&nbsp;</td>");
	}

	templateBuilder.Append("\r\n		</tr>\r\n			");
	}	//end if

	templateBuilder.Append("\r\n		</table>\r\n		</div>\r\n	</div>\r\n		");
	}
	else
	{

	templateBuilder.Append("\r\n		</table>\r\n		</div>\r\n	</div>	\r\n		");
	}	//end if

	templateBuilder.Append("\r\n	<div id=\"ad_intercat_");
	templateBuilder.Append(lastforumid.ToString());
	templateBuilder.Append("\"></div>\r\n	");
	}	//end if


	if (forum.Colcount!=1)
	{

	 subforumcount = 0;
	

	}	//end if

	templateBuilder.Append("\r\n	<div class=\"mainbox list\">\r\n		<div class=\"titlebar xg2\">\r\n			<span class=\"y\">");
	if (forum.Moderators!="")
	{

	templateBuilder.Append("分区版主: ");
	templateBuilder.Append(forum.Moderators.ToString().Trim());
	}	//end if

	templateBuilder.Append("\r\n				<img id=\"category_");
	templateBuilder.Append(forum.Fid.ToString().Trim());
	templateBuilder.Append("_img\"  \r\n				");
	if (forum.Collapse!="")
	{

	templateBuilder.Append("\r\n				src=\"");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("/collapsed_yes.gif\"\r\n				");
	}
	else
	{

	templateBuilder.Append("\r\n				src=\"");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("/collapsed_no.gif\"\r\n				");
	}	//end if

	templateBuilder.Append("\r\n				 alt=\"展开/收起\" onclick=\"toggle_collapse('category_");
	templateBuilder.Append(forum.Fid.ToString().Trim());
	templateBuilder.Append("');\"/>\r\n			</span>\r\n			<h2>\r\n				");	 aspxrewriteurl = this.ShowForumAspxRewrite(forum.Fid,0,forum.Rewritename);
	
	templateBuilder.Append("\r\n				<a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\">");
	templateBuilder.Append(forum.Name.ToString().Trim());
	templateBuilder.Append("</a>\r\n			</h2>\r\n		</div>\r\n		<div id=\"category_");
	templateBuilder.Append(forum.Fid.ToString().Trim());
	templateBuilder.Append("\" summary=\"category_");
	templateBuilder.Append(forum.Fid.ToString().Trim());
	templateBuilder.Append("\" class=\"fi\" style=\"");
	templateBuilder.Append(forum.Collapse.ToString().Trim());
	templateBuilder.Append("\">\r\n		<table cellspacing=\"0\" cellpadding=\"0\">\r\n		");	 lastforumlayer = 0;
	
	 lastcolcount = forum.Colcount;
	
	 lastforumid = forum.Fid;
	

	}
	else
	{

	 subcount = subcount+1;
	

		    if (maxsubcount > 0)
	        {
	            if (subcount > maxsubcount)
	                continue;
	        }
	        if(forum.Fid == 58 && btuserinfo.Extcredits2 < 51) 
	        {
	            continue;
	        }
	        

	if (forum.Colcount==1)
	{

	templateBuilder.Append("\r\n		<tbody id=\"forum");
	templateBuilder.Append(forum.Fid.ToString().Trim());
	templateBuilder.Append("\">\r\n			<tr>\r\n				");	 aspxrewriteurl = this.ShowTopicAspxRewrite(forum.Lasttid,0);
	
	templateBuilder.Append("\r\n				<th ");
	if (config.Shownewposticon==1)
	{

	templateBuilder.Append("class=\"notopic");
	if (forum.Havenew=="new")
	{

	templateBuilder.Append(" new");
	}	//end if

	templateBuilder.Append("\"");
	}	//end if

	templateBuilder.Append(">\r\n					<h2>\r\n					");
	if (forum.Redirect=="")
	{

	 aspxrewriteurl = this.ShowForumAspxRewrite(forum.Fid,0,forum.Rewritename);
	
	templateBuilder.Append("\r\n						<a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\">\r\n					");
	}
	else
	{

	templateBuilder.Append("\r\n						<a href=\"");
	templateBuilder.Append(forum.Redirect.ToString().Trim());
	templateBuilder.Append("\" target=\"_blank\">\r\n					");
	}	//end if


	if (forum.Icon!="")
	{

	string fname = Utils.RemoveHtml(forum.Name);
	
	templateBuilder.Append("\r\n					    <img src=\"");
	templateBuilder.Append(forum.Icon.ToString().Trim());
	templateBuilder.Append("\" border=\"0\" hspace=\"5\" alt=\"");
	templateBuilder.Append(fname.ToString());
	templateBuilder.Append("\"/>\r\n				    ");
	}	//end if

	templateBuilder.Append("\r\n					");
	templateBuilder.Append(forum.Name.ToString().Trim());
	templateBuilder.Append("</a>");
	if (forum.Todayposts>0)
	{

	templateBuilder.Append("<em>(今日:<strong>");
	templateBuilder.Append(forum.Todayposts.ToString().Trim());
	templateBuilder.Append("</strong>)</em>");
	}	//end if

	templateBuilder.Append("\r\n					</h2>\r\n					");
	if (forum.Description!="")
	{

	templateBuilder.Append("<p>");
	templateBuilder.Append(forum.Description.ToString().Trim());
	templateBuilder.Append("</p>");
	}	//end if


	if (forum.Moderators!="")
	{

	templateBuilder.Append("<p class=\"xg2\">版主: ");
	templateBuilder.Append(forum.Moderators.ToString().Trim());
	templateBuilder.Append("</p>");
	}	//end if

	templateBuilder.Append("\r\n				</th>\r\n				<td class=\"nums\"><em>");
	if (forum.Istrade!=1)
	{
	templateBuilder.Append(forum.Topics.ToString().Trim());
	}
	else
	{

	templateBuilder.Append("&nbsp;");
	}	//end if

	templateBuilder.Append("</em> / ");
	if (forum.Istrade!=1)
	{
	templateBuilder.Append(forum.Posts.ToString().Trim());
	}
	else
	{

	templateBuilder.Append("&nbsp;");
	}	//end if

	templateBuilder.Append("</td>\r\n				<td class=\"lastpost\">\r\n				");
	if (forum.Istrade!=1)
	{


	if (forum.Status==-1)
	{

	templateBuilder.Append("\r\n					<p>私密版块</p>\r\n				");
	}
	else
	{


	if (forum.Lasttid!=0)
	{

	templateBuilder.Append("\r\n					<p>\r\n					   ");	 aspxrewriteurl = this.ShowTopicAspxRewrite(forum.Lasttid,0);
	
	templateBuilder.Append("\r\n						<a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\">");	templateBuilder.Append(Utils.GetUnicodeSubString(forum.Lasttitle,35,"..."));
	templateBuilder.Append("</a>\r\n					</p>\r\n					<div class=\"topicbackwriter\">by\r\n						");
	if (forum.Lastposter!="")
	{


	if (forum.Lastposterid==-1)
	{

	templateBuilder.Append("\r\n								游客\r\n							");
	}
	else
	{

	 aspxrewriteurl = this.UserInfoAspxRewrite(forum.Lastposterid);
	
	templateBuilder.Append("\r\n								<a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\" target=\"_blank\">");
	templateBuilder.Append(forum.Lastposter.ToString().Trim());
	templateBuilder.Append("</a>\r\n							");
	}	//end if


	}
	else
	{

	templateBuilder.Append("\r\n							匿名\r\n						");
	}	//end if

	string lastpost = ForumUtils.ConvertDateTime(forum.Lastpost);
	
	templateBuilder.Append("						\r\n						- <a href=\"showtopic.aspx?topicid=");
	templateBuilder.Append(forum.Lasttid.ToString().Trim());
	templateBuilder.Append("&page=end#lastpost\" title=\"");
	templateBuilder.Append(forum.Lasttitle.ToString().Trim());
	templateBuilder.Append("\"><em>");
	templateBuilder.Append(lastpost.ToString());
	templateBuilder.Append("</em></a>\r\n					</div>\r\n					");
	}
	else
	{

	templateBuilder.Append("\r\n						<p>从未</p>\r\n					");
	}	//end if


	}	//end if


	}
	else
	{

	templateBuilder.Append("\r\n				   <p>");
	templateBuilder.Append(forum.Description.ToString().Trim());
	templateBuilder.Append("</p>\r\n				");
	}	//end if

	templateBuilder.Append("\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	\r\n	");
	}
	else if (forum.Colcount==2)
	{

	 subforumcount = subforumcount+1;
	
	double colwidth = 99.9 / forum.Colcount;
	

	if (subforumcount==1)
	{

	templateBuilder.Append("\r\n		<tbody>\r\n		<tr>\r\n		");
	}	//end if

	templateBuilder.Append("\r\n			<th style=\"width:");
	templateBuilder.Append(colwidth.ToString());
	templateBuilder.Append("%;height:82px;\" ");
	if (config.Shownewposticon==1)
	{

	templateBuilder.Append("class=\"notopic ");
	if (forum.Havenew=="new")
	{

	templateBuilder.Append("new");
	}	//end if

	templateBuilder.Append("\"");
	}	//end if

	templateBuilder.Append(">\r\n        <!-- forum menu -->\r\n        <div class=\"popupmenu_popup userinfopanel\" id=\"");
	templateBuilder.Append(forum.Fid.ToString().Trim());
	templateBuilder.Append("\" style=\"background: none repeat scroll 0 0 #fff;line-height: 1.6em;margin-left: -6px;margin-top: -6px;opacity: 0.99;padding: 0;position: absolute;width: 445px; height:90px;z-index: 99;display:none;  position:absolute;\" initialized ctrlkey=\"userinfo2\">\r\n          <div class=\"popavatar\" style=\"margin:5px;\">\r\n            <div id=\"");
	templateBuilder.Append(forum.Fid.ToString().Trim());
	templateBuilder.Append("_ma\"></div>\r\n            <ul class=\"profile_side\">\r\n            ");
	if (forum.Redirect=="")
	{

	 aspxrewriteurl = this.ShowForumAspxRewrite(forum.Fid,0,forum.Rewritename);
	
	templateBuilder.Append("\r\n              <a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\">\r\n            ");
	}
	else
	{

	templateBuilder.Append("\r\n              <a href=\"");
	templateBuilder.Append(forum.Redirect.ToString().Trim());
	templateBuilder.Append("\" target=\"_blank\">\r\n            ");
	}	//end if


	if (forum.Icon!="")
	{

	string fname = Utils.RemoveHtml(forum.Name);
	
	templateBuilder.Append("\r\n                      <img src=\"");
	templateBuilder.Append(forum.Icon.ToString().Trim());
	templateBuilder.Append("\" style=\"height:80px;width:80px\" border=\"0\" align=\"left\" hspace=\"5\" alt=\"");
	templateBuilder.Append(fname.ToString());
	templateBuilder.Append("\"/>\r\n                ");
	}	//end if

	templateBuilder.Append("	\r\n            </a>				\r\n            </ul>\r\n          </div>\r\n          <div class=\"popuserinfo\" style=\"margin-left:-65px;margin-top:0px;\">\r\n                <h2>\r\n                    ");
	if (forum.Redirect=="")
	{

	 aspxrewriteurl = this.ShowForumAspxRewrite(forum.Fid,0,forum.Rewritename);
	
	templateBuilder.Append("\r\n                      <a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\">\r\n                    ");
	}
	else
	{

	templateBuilder.Append("\r\n                      <a href=\"");
	templateBuilder.Append(forum.Redirect.ToString().Trim());
	templateBuilder.Append("\" target=\"_blank\">\r\n                    ");
	}	//end if

	templateBuilder.Append("\r\n                    ");
	templateBuilder.Append(forum.Name.ToString().Trim());
	templateBuilder.Append("</a>\r\n                    <em>\r\n                      ");
	if (forum.Todayposts>0)
	{

	templateBuilder.Append("(今日:<strong>");
	templateBuilder.Append(forum.Todayposts.ToString().Trim());
	templateBuilder.Append("</strong>)&nbsp;");
	}	//end if


	if (forum.Istrade!=1)
	{

	templateBuilder.Append("主题:");
	templateBuilder.Append(forum.Topics.ToString().Trim());
	templateBuilder.Append(", 帖数:");
	templateBuilder.Append(forum.Posts.ToString().Trim());
	}	//end if

	templateBuilder.Append("\r\n                    </em>\r\n                </h2>\r\n                ");
	if (forum.Moderators!="")
	{

	templateBuilder.Append("<p class=\"xg2\">版主: ");
	templateBuilder.Append(forum.Moderators.ToString().Trim());
	templateBuilder.Append("</p>");
	}	//end if

	templateBuilder.Append("\r\n                <p>");
	templateBuilder.Append(forum.Description.ToString().Trim());
	templateBuilder.Append("</p>\r\n          </div>\r\n        </div>\r\n        <!-- forum menu end -->\r\n				<h2>				\r\n				");
	if (forum.Redirect=="")
	{

	 aspxrewriteurl = this.ShowForumAspxRewrite(forum.Fid,0,forum.Rewritename);
	
	templateBuilder.Append("\r\n					<div style=\"z-index:999;\"><a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\">\r\n				");
	}
	else
	{

	templateBuilder.Append("\r\n					<div style=\"z-index:999;\"><a href=\"");
	templateBuilder.Append(forum.Redirect.ToString().Trim());
	templateBuilder.Append("\" target=\"_blank\">\r\n				");
	}	//end if


	if (forum.Icon!="")
	{

	string fname = Utils.RemoveHtml(forum.Name);
	
	templateBuilder.Append("\r\n					    <img src=\"");
	templateBuilder.Append(forum.Icon.ToString().Trim());
	templateBuilder.Append("\" id=\"forumicon_");
	templateBuilder.Append(forum.Fid.ToString().Trim());
	templateBuilder.Append("\" style=\"height:80px;width:80px\" border=\"0\" align=\"left\" hspace=\"5\" alt=\"");
	templateBuilder.Append(fname.ToString());
	templateBuilder.Append("\" onmouseover=\"showauthor(this,");
	templateBuilder.Append(forum.Fid.ToString().Trim());
	templateBuilder.Append(")\"/>\r\n				");
	}	//end if

	templateBuilder.Append("\r\n				</a></div>\r\n				");
	if (forum.Redirect=="")
	{

	templateBuilder.Append("\r\n					<a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\">\r\n				");
	}
	else
	{

	templateBuilder.Append("\r\n					<a href=\"");
	templateBuilder.Append(forum.Redirect.ToString().Trim());
	templateBuilder.Append("\" target=\"_blank\">\r\n				");
	}	//end if

	templateBuilder.Append("\r\n          <span ");
	if (forum.Icon!="")
	{

	templateBuilder.Append("onmouseover=\"showauthor(this,");
	templateBuilder.Append(forum.Fid.ToString().Trim());
	templateBuilder.Append(")\"");
	}	//end if

	templateBuilder.Append(">");
	templateBuilder.Append(forum.Name.ToString().Trim());
	templateBuilder.Append("</span></a>\r\n				  <em>\r\n            ");
	if (forum.Todayposts>0)
	{

	templateBuilder.Append("(今日:<strong>");
	templateBuilder.Append(forum.Todayposts.ToString().Trim());
	templateBuilder.Append("</strong>)&nbsp;");
	}	//end if


	if (forum.Istrade!=1)
	{

	templateBuilder.Append("主题:");
	templateBuilder.Append(forum.Topics.ToString().Trim());
	templateBuilder.Append(", 帖数:");
	templateBuilder.Append(forum.Posts.ToString().Trim());
	}	//end if

	templateBuilder.Append("\r\n          </em>\r\n				</h2>\r\n				<p></p>\r\n				");
	if (forum.Istrade!=1)
	{


	if (forum.Status==-1)
	{

	templateBuilder.Append("\r\n            <p>私密版块</p>\r\n            ");
	}
	else
	{


	if (forum.Lasttid!=0)
	{

	templateBuilder.Append("\r\n              <p><ul>\r\n                     ");	 aspxrewriteurl = this.ShowTopicAspxRewrite(forum.Lasttid,0);
	
	templateBuilder.Append("\r\n                    <li style=\"list-style-type:disc;margin-left:110px\"><a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\" style=\"color:#555\">");	templateBuilder.Append(Utils.GetUnicodeSubString(forum.Lasttitle,60,"..."));
	templateBuilder.Append("</a></li>\r\n                  ");	int hottopicsshowcount = 1;
	

	int hottopics__loop__id=0;
	foreach(ForumHottopics hottopics in Forums.GetForumHotTopics(forum.Fid).HotTopicList)
	{
		hottopics__loop__id++;


	if (hottopics.Tid!=forum.Lasttid&&hottopicsshowcount<3)
	{

	 aspxrewriteurl = this.ShowTopicAspxRewrite(hottopics.Tid,0);
	
	templateBuilder.Append("\r\n                      <li style=\"list-style-type:disc;margin-left:110px\"><a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\" style=\"color:#555\">");	templateBuilder.Append(Utils.GetUnicodeSubString(hottopics.TopicTitle,60,"..."));
	templateBuilder.Append("</a></li>\r\n                    ");	 hottopicsshowcount = hottopicsshowcount+1;
	

	}	//end if


	}	//end loop

	templateBuilder.Append("\r\n              </ul></p>\r\n              ");
	}	//end if


	}	//end if


	}
	else
	{

	templateBuilder.Append("\r\n				  <p>");
	templateBuilder.Append(forum.Description.ToString().Trim());
	templateBuilder.Append("</p>\r\n				");
	}	//end if

	templateBuilder.Append("\r\n			</th>\r\n      ");
	if (subforumcount==forum.Colcount)
	{

	templateBuilder.Append("\r\n		  </tr>\r\n		  </tbody>\r\n	    ");	 subforumcount = 0;
	

	}	//end if


	}
	else
	{

	 subforumcount = subforumcount+1;
	
	double colwidth = 99.9 / forum.Colcount;
	

	if (subforumcount==1)
	{

	templateBuilder.Append("\r\n		<tbody>\r\n		<tr>\r\n		");
	}	//end if

	templateBuilder.Append("\r\n			<th style=\"width:");
	templateBuilder.Append(colwidth.ToString());
	templateBuilder.Append("%;\" ");
	if (config.Shownewposticon==1)
	{

	templateBuilder.Append("class=\"notopic ");
	if (forum.Havenew=="new")
	{

	templateBuilder.Append("new");
	}	//end if

	templateBuilder.Append("\"");
	}	//end if

	templateBuilder.Append(">\r\n				<h2>				\r\n				");
	if (forum.Redirect=="")
	{

	 aspxrewriteurl = this.ShowForumAspxRewrite(forum.Fid,0,forum.Rewritename);
	
	templateBuilder.Append("\r\n					<a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\">\r\n				");
	}
	else
	{

	templateBuilder.Append("\r\n					<a href=\"");
	templateBuilder.Append(forum.Redirect.ToString().Trim());
	templateBuilder.Append("\" target=\"_blank\">\r\n				");
	}	//end if


	if (forum.Icon!="")
	{

	string fname = Utils.RemoveHtml(forum.Name);
	
	templateBuilder.Append("\r\n					    <img src=\"");
	templateBuilder.Append(forum.Icon.ToString().Trim());
	templateBuilder.Append("\" border=\"0\" align=\"left\" hspace=\"5\" alt=\"");
	templateBuilder.Append(fname.ToString());
	templateBuilder.Append("\"/>\r\n				");
	}	//end if

	templateBuilder.Append("\r\n                ");
	templateBuilder.Append(forum.Name.ToString().Trim());
	templateBuilder.Append("</a>\r\n				");
	if (forum.Todayposts>0)
	{

	templateBuilder.Append("\r\n				<em>(今日:<strong>");
	templateBuilder.Append(forum.Todayposts.ToString().Trim());
	templateBuilder.Append("</strong>)</em>\r\n				");
	}	//end if

	templateBuilder.Append("\r\n				</h2>\r\n				<p>");
	if (forum.Istrade!=1)
	{

	templateBuilder.Append("主题:");
	templateBuilder.Append(forum.Topics.ToString().Trim());
	templateBuilder.Append(", 帖数:");
	templateBuilder.Append(forum.Posts.ToString().Trim());
	}	//end if

	templateBuilder.Append("</p>\r\n				");
	if (forum.Istrade!=1)
	{


	if (forum.Status==-1)
	{

	templateBuilder.Append("\r\n				<p>私密版块</p>\r\n				");
	}
	else
	{


	if (forum.Lasttid!=0)
	{

	string lastpost = ForumUtils.ConvertDateTime(forum.Lastpost);
	
	templateBuilder.Append("	\r\n						<p>最后: <a href=\"showtopic.aspx?topicid=");
	templateBuilder.Append(forum.Lasttid.ToString().Trim());
	templateBuilder.Append("&page=end#lastpost\" title=\"");
	templateBuilder.Append(forum.Lasttitle.ToString().Trim());
	templateBuilder.Append("\"><em>");
	templateBuilder.Append(lastpost.ToString());
	templateBuilder.Append("</em></a> by \r\n							");
	if (forum.Lastposter!="")
	{


	if (forum.Lastposterid==-1)
	{

	templateBuilder.Append("\r\n									游客\r\n								");
	}
	else
	{

	 aspxrewriteurl = this.UserInfoAspxRewrite(forum.Lastposterid);
	
	templateBuilder.Append("\r\n									<a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\" target=\"_blank\">");
	templateBuilder.Append(forum.Lastposter.ToString().Trim());
	templateBuilder.Append("</a>\r\n								");
	}	//end if


	}
	else
	{

	templateBuilder.Append("\r\n								匿名\r\n							");
	}	//end if

	templateBuilder.Append("\r\n						</p>\r\n					");
	}	//end if


	}	//end if


	}
	else
	{

	templateBuilder.Append("\r\n				  <p>");
	templateBuilder.Append(forum.Description.ToString().Trim());
	templateBuilder.Append("</p>\r\n				");
	}	//end if

	templateBuilder.Append("\r\n			</th>\r\n    ");
	if (subforumcount==forum.Colcount)
	{

	templateBuilder.Append("\r\n		</tr>\r\n		</tbody>\r\n	  ");	 subforumcount = 0;
	

	}	//end if


	}	//end if

	 lastforumlayer = 1;
	
	 lastcolcount = forum.Colcount;
	

	}	//end if


	}	//end loop


	if (lastcolcount!=1 && subforumcount!=0)
	{

	for (int i = 0; i < lastcolcount-subforumcount; i++)
	{
		templateBuilder.Append("<td>&nbsp;</td>");
	}

	templateBuilder.Append("\r\n		</tr>\r\n");
	}	//end if

	templateBuilder.Append("\r\n	</table>\r\n	</div>\r\n</div>\r\n</div>\r\n<!--end topic-->\r\n");
	if (forumlinkcount>0)
	{

	templateBuilder.Append("\r\n<div class=\"bm cl\" id=\"forumlink\">\r\n	<div id=\"forumlinks\">\r\n	");	bool forumlinkend = false;
	

	int forumlink__loop__id=0;
	foreach(DataRow forumlink in forumlinklist.Rows)
	{
		forumlink__loop__id++;


	if (forumlink__loop__id==1)
	{

	templateBuilder.Append("\r\n		<ul class=\"forumlinks\">	<span class=\"forumlinkbt\"> 友情链接 </span>\r\n		");
	}	//end if


	if (forumlink["logo"].ToString().Trim()!="")
	{

	templateBuilder.Append("\r\n		<li>\r\n			<a href=\"" + forumlink["url"].ToString().Trim() + "\" target=\"_blank\"><img src=\"" + forumlink["logo"].ToString().Trim() + "\" alt=\"" + forumlink["name"].ToString().Trim() + "\"  class=\"forumlink_logo\"/></a>\r\n			<h5><a href=\"" + forumlink["url"].ToString().Trim() + "\" target=\"_blank\">" + forumlink["name"].ToString().Trim() + "</a></h5>\r\n			<p>" + forumlink["note"].ToString().Trim() + "</p>\r\n		</li>\r\n		");
	}
	else if (forumlink["name"].ToString().Trim()!="$$otherlink$$")
	{

	templateBuilder.Append("\r\n		<li>\r\n			<h5>\r\n				<a href=\"" + forumlink["url"].ToString().Trim() + "\" target=\"_blank\">" + forumlink["name"].ToString().Trim() + "</a>\r\n			</h5>\r\n			<p>" + forumlink["note"].ToString().Trim() + "</p>\r\n		</li>\r\n	");
	}
	else
	{


	if (forumlinkend==false)
	{

	templateBuilder.Append("\r\n		</ul>\r\n		");	 forumlinkend = true;
	

	}	//end if

	templateBuilder.Append("\r\n	<div class=\"" + forumlink["url"].ToString().Trim() + "\">\r\n	    <ul>\r\n		" + forumlink["note"].ToString().Trim() + "\r\n		</ul>\r\n	</div>\r\n	");
	}	//end if


	}	//end loop


	if (forumlinkend==false)
	{

	templateBuilder.Append("\r\n		</ul>\r\n	");
	}	//end if

	templateBuilder.Append("\r\n	</div>\r\n</div>\r\n");
	}	//end if


	if (config.Whosonlinestatus!=0 && config.Whosonlinestatus!=2)
	{

	templateBuilder.Append("\r\n<div class=\"bm cl\" id=\"online\">\r\n	<span class=\"l_action\">\r\n		");
	if (showforumonline)
	{

	templateBuilder.Append("\r\n		<a href=\"?showonline=no#online\"><img src=\"");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("/l_collapsed_no.gif\" alt=\"收起\" /></a>\r\n		");
	}
	else
	{

	templateBuilder.Append("\r\n		<a href=\"?showonline=yes#online\"><img src=\"");
	templateBuilder.Append(imagedir.ToString());
	templateBuilder.Append("/l_collapsed_yes.gif\" alt=\"展开\" /></a>\r\n		");
	}	//end if

	templateBuilder.Append("\r\n	</span>\r\n	<div class=\"bm_h\">\r\n		<h3>\r\n			<strong><a href=\"");
	templateBuilder.Append(forumurl.ToString());
	templateBuilder.Append("onlineuser.aspx\">在线用户</a></strong> - <em>");
	templateBuilder.Append(totalonline.ToString());
	templateBuilder.Append("</em> 人在线 ");
	if (showforumonline)
	{

	templateBuilder.Append("- ");
	templateBuilder.Append(totalonlineuser.ToString());
	templateBuilder.Append(" 会员<span id=\"invisible\"></span>, ");
	templateBuilder.Append(totalonlineguest.ToString());
	templateBuilder.Append(" 游客");
	}	//end if

	templateBuilder.Append("- 最高记录是 <em>");
	templateBuilder.Append(highestonlineusercount.ToString());
	templateBuilder.Append("</em> 于 <em>");
	templateBuilder.Append(highestonlineusertime.ToString());
	templateBuilder.Append("</em>\r\n			<em style=\"padding-left:10px;\">共<cite>");
	templateBuilder.Append(totalusers.ToString());
	templateBuilder.Append("</cite>位会员- 新会员:<a href=\"");
	templateBuilder.Append(UserInfoAspxRewrite(lastuserid).ToString());
	templateBuilder.Append("\" class=\"xg2\">");
	templateBuilder.Append(lastusername.ToString());
	templateBuilder.Append("</a></em>\r\n			");
	if (showforumonline==false)
	{

	templateBuilder.Append("\r\n			<em style=\"padding-left:10px;\"><a href=\"?showonline=yes#online\" class=\"xg2\">点击查看在线列表</a></em>\r\n			");
	}	//end if

	templateBuilder.Append("\r\n		</h3>\r\n	</div>\r\n	");
	if (showforumonline)
	{

	templateBuilder.Append("\r\n	<dl id=\"onlinelist\">\r\n		<dt>");
	templateBuilder.Append(onlineiconlist.ToString());
	templateBuilder.Append("</dt>\r\n		<dd>\r\n			<ul class=\"userlist cl\">\r\n		");	int invisiblecount = 0;
	

	int onlineuser__loop__id=0;
	foreach(OnlineUserInfo onlineuser in onlineuserlist)
	{
		onlineuser__loop__id++;


	if (onlineuser.Invisible==1)
	{

	 invisiblecount = invisiblecount + 1;
	

	if (useradminid==1)
	{

	templateBuilder.Append("\r\n				<li>");
	templateBuilder.Append(onlineuser.Olimg.ToString().Trim());
	templateBuilder.Append(" \r\n				");	 aspxrewriteurl = this.UserInfoAspxRewrite(onlineuser.Userid);
	
	templateBuilder.Append("\r\n					<a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\" target=\"_blank\" \r\n					");
	if (onlineuser.Forumname!="")
	{

	string forumname = Utils.RemoveHtml(onlineuser.Forumname);
	
	templateBuilder.Append("\r\n					title=\"时间: ");
	templateBuilder.Append(onlineuser.Lastupdatetime.ToString().Trim());
	templateBuilder.Append(" 操作: ");
	templateBuilder.Append(onlineuser.Actionname.ToString().Trim());
	templateBuilder.Append(" 版块: ");
	templateBuilder.Append(forumname.ToString());
	templateBuilder.Append("\"\r\n					");
	}
	else if (onlineuser.Actionname!="")
	{

	templateBuilder.Append("\r\n					title=\"时间: ");
	templateBuilder.Append(onlineuser.Lastupdatetime.ToString().Trim());
	templateBuilder.Append(" 操作: ");
	templateBuilder.Append(onlineuser.Actionname.ToString().Trim());
	templateBuilder.Append("\"\r\n					");
	}
	else
	{

	templateBuilder.Append("\r\n					title=\"时间: ");
	templateBuilder.Append(onlineuser.Lastupdatetime.ToString().Trim());
	templateBuilder.Append("\"\r\n					");
	}	//end if

	templateBuilder.Append(">");
	templateBuilder.Append(onlineuser.Username.ToString().Trim());
	templateBuilder.Append("</a>(隐身)\r\n				</li>\r\n				");
	}
	else
	{

	templateBuilder.Append("\r\n				<li>(隐身会员)</li>\r\n				");
	}	//end if


	}
	else
	{

	templateBuilder.Append("\r\n				<li>");
	templateBuilder.Append(onlineuser.Olimg.ToString().Trim());
	templateBuilder.Append("\r\n					");
	if (onlineuser.Userid==-1)
	{

	templateBuilder.Append("\r\n						");
	templateBuilder.Append(onlineuser.Username.ToString().Trim());
	templateBuilder.Append("\r\n					");
	}
	else
	{

	 aspxrewriteurl = this.UserInfoAspxRewrite(onlineuser.Userid);
	
	templateBuilder.Append("\r\n						<a href=\"");
	templateBuilder.Append(aspxrewriteurl.ToString());
	templateBuilder.Append("\" target=\"_blank\" \r\n						");
	if (onlineuser.Forumname!="")
	{

	string forumname = Utils.RemoveHtml(onlineuser.Forumname);
	
	templateBuilder.Append("\r\n						title=\"时间: ");
	templateBuilder.Append(onlineuser.Lastupdatetime.ToString().Trim());
	templateBuilder.Append(" 操作: ");
	templateBuilder.Append(onlineuser.Actionname.ToString().Trim());
	templateBuilder.Append(" 版块: ");
	templateBuilder.Append(forumname.ToString());
	templateBuilder.Append("\"\r\n						");
	}
	else if (onlineuser.Actionname!="")
	{

	templateBuilder.Append("\r\n						title=\"时间: ");
	templateBuilder.Append(onlineuser.Lastupdatetime.ToString().Trim());
	templateBuilder.Append(" 操作: ");
	templateBuilder.Append(onlineuser.Actionname.ToString().Trim());
	templateBuilder.Append("\"\r\n						");
	}
	else
	{

	templateBuilder.Append("\r\n						title=\"时间: ");
	templateBuilder.Append(onlineuser.Lastupdatetime.ToString().Trim());
	templateBuilder.Append("\"\r\n						");
	}	//end if

	templateBuilder.Append(">");
	templateBuilder.Append(onlineuser.Username.ToString().Trim());
	templateBuilder.Append("</a>\r\n					");
	}	//end if

	templateBuilder.Append("\r\n				</li>\r\n			");
	}	//end if


	}	//end loop


	if (invisiblecount>0)
	{

	templateBuilder.Append("\r\n				<script type=\"text/javascript\">$('invisible').innerHTML = '(");
	templateBuilder.Append(invisiblecount.ToString());
	templateBuilder.Append("' + \" 隐身)\";</");
	templateBuilder.Append("script>\r\n			");
	}	//end if

	templateBuilder.Append("\r\n			</ul>\r\n		</dd>\r\n	</dl>\r\n	");
	}	//end if

	templateBuilder.Append("\r\n</div>\r\n");
	}	//end if

	templateBuilder.Append("\r\n</div>\r\n</div>\r\n\r\n<script type=\"text/javascript\">\r\nvar authort;\r\nfunction showauthor(obj, id) {\r\n    authort = setTimeout(\"$('\" + id + \"').style.display = 'block';\", 750);\r\n    if (!$(id).onmouseover) {\r\n        $(id).onmouseover = function() {\r\n            $(id).style.display = 'block';\r\n        }\r\n        $(id).onmouseout = function() {\r\n            $(id).style.display = 'none';\r\n        }\r\n    }\r\n    if (!obj.onmouseout) {\r\n        obj.onmouseout = function() {\r\n            clearTimeout(authort);\r\n        }\r\n    }\r\n}\r\n</");
	templateBuilder.Append("script>\r\n\r\n");
	if (config.Stylejump==1)
	{


	if (userid!=-1 || config.Guestcachepagetimeout<=0)
	{

	templateBuilder.Append("\r\n	<div id=\"styleswitcherhome_menu\" class=\"popupmenu_popup cl skin\" style=\"display: none;\">\r\n		<ul>\r\n		");
	templateBuilder.Append(templatelistboxoptionsforforumindex.ToString());
	templateBuilder.Append("\r\n		</ul>\r\n	</div>\r\n");
	}	//end if


	}	//end if


	if (config.Forumjump==1)
	{

	templateBuilder.Append("\r\n	");
	templateBuilder.Append(navhomemenu.ToString());
	templateBuilder.Append("\r\n");
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





	if (infloat!=1)
	{


	if (floatad!="")
	{

	templateBuilder.Append("\r\n	<script type=\"text/javascript\"  src=\"");
	templateBuilder.Append(jsdir.ToString());
	templateBuilder.Append("/template_floatadv.js\"></");
	templateBuilder.Append("script>\r\n	");
	templateBuilder.Append(floatad.ToString());
	templateBuilder.Append("\r\n	<script type=\"text/javascript\">theFloaters.play();</");
	templateBuilder.Append("script>\r\n");
	}
	else if (doublead!="")
	{

	templateBuilder.Append("\r\n	<script type=\"text/javascript\"  src=\"");
	templateBuilder.Append(jsdir.ToString());
	templateBuilder.Append("/template_floatadv.js\"></");
	templateBuilder.Append("script>\r\n	");
	templateBuilder.Append(doublead.ToString());
	templateBuilder.Append("\r\n	<script type=\"text/javascript\">theFloaters.play();</");
	templateBuilder.Append("script>\r\n");
	}	//end if


	}	//end if



	templateBuilder.Append("\r\n");
	templateBuilder.Append(mediaad.ToString());
	templateBuilder.Append("\r\n");
	templateBuilder.Append(inforumad.ToString());
	templateBuilder.Append("\r\n");
	templateBuilder.Append("</body>\r\n</html>\r\n");
	}
	else
	{

	templateBuilder.Append("\r\n]]></root>\r\n");
	}	//end if




	Response.Write(templateBuilder.ToString());
}
</script>