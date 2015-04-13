using System;
using System.Data;
using System.Data.Common;
using System.Web;

using Discuz.Forum;
using Discuz.Common;
using System.IO;

namespace Discuz.Web.UI
{
	/// <summary>
	/// ͷ��ҳ����
	/// </summary>
	public class Avatar : PageBase
	{
        public Avatar()
		{
            AvatarSize avatarSize;
            switch (DNTRequest.GetString("size").ToLower())
            {
                case "large":
                    {
                        avatarSize = AvatarSize.Large;
                        break;
                    }
                case "medium":
                    {
                        avatarSize = AvatarSize.Medium;
                        break;
                    }
                case "small":
                    {
                        avatarSize = AvatarSize.Small;
                        break;
                    }
                default:
                    {
                        avatarSize = AvatarSize.Medium;
                        break;
                    }
            }
            string avatarUrl = Avatars.GetAvatarUrl(DNTRequest.GetString("uid"), avatarSize);
            
            try
            {
                //��BT�޸ġ�����redirect����ʱ���������redirectʧ�ܺ���transfer����ʧ���򷵻�
                HttpContext.Current.Response.Redirect(avatarUrl);
            }
            catch
            {
                System.Threading.Thread.Sleep(500);
                try
                {
                    Server.Transfer(avatarUrl);
                }
                catch
                {
                    return;
                }
                
            }
           
		}
	}
}
