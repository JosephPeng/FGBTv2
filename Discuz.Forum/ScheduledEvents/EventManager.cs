using System;
using System.Diagnostics;
using System.Web;
using System.Threading;

using Discuz.Config;
using Discuz.Common.Generic;
using Discuz.Common;

namespace Discuz.Forum.ScheduledEvents
{
	/// <summary>
	/// EventManager is called from the EventHttpModule (or another means of scheduling a Timer). Its sole purpose
	/// is to iterate over an array of Events and deterimine of the Event's IEvent should be processed. All events are
	/// added to the managed threadpool. 
	/// </summary>
	public class EventManager
	{
        public static string RootPath;

		private EventManager()
		{
		}

		public static readonly int TimerMinutesInterval = 5;
        static EventManager()
        {
            if (ScheduleConfigs.GetConfig().TimerMinutesInterval > 0)
            {
                TimerMinutesInterval = ScheduleConfigs.GetConfig().TimerMinutesInterval;
            }
        }

        public static DateTime weblastrun = new DateTime(1970, 1, 1);
		public static void Execute(string ServerName)
        {
            Discuz.Config.Event[] simpleItems = ScheduleConfigs.GetConfig().Events;
            Event[] items;
#if NET1
            ArrayList list = new ArrayList();
#else
            List<Event> list = new List<Event>();
#endif

            foreach (Discuz.Config.Event newEvent in simpleItems)
            {
                if (!newEvent.Enabled)
                {
                    continue;
                }
                Event e = new Event();
                e.Key = newEvent.Key;
                e.Minutes = newEvent.Minutes;
                e.ScheduleType = newEvent.ScheduleType;
                e.TimeOfDay = newEvent.TimeOfDay;

                list.Add(e);
            }


#if NET1
            items = (Event[])list.ToArray(typeof(Event));
#else
            items = list.ToArray();
#endif

            Event item = null;
			
			if(items != null)
			{
				
				for(int i = 0; i < items.Length; i++)
				{
					item = items[i];
                    
					if(item.ShouldExecute || (ServerName == "Web" && (DateTime.Now - weblastrun).TotalHours > 1))
					{
                        bool overtime = false;
                        //����Web��������Tracker��������ִ�мƻ��������
                        if (ServerName == "Web")
                        {
                            //ִֻ��Web���ʻ��������ļƻ����񣬳��ǳ�ʱ����45���ӣ���ΪTracker���������ϣ�
                            if (item.ScheduleType.IndexOf("WebEvent") < 0)
                            {
                                overtime = item.ShouldExecuteOverTime;
                                if (!overtime) continue; 
                            }
                        }
                        else if (ServerName == "Tracker")
                        {
                            //��ִ��Web������ƻ�����
                            if (item.ScheduleType.IndexOf("WebEvent") > -1) continue;
                        }
                        else continue;

                        weblastrun = DateTime.Now;
                        if ((ServerName == "Web" && (DateTime.Now - weblastrun).TotalHours > 1))
                        {
                            PTLog.InsertSystemLog(PTLog.LogType.ScheduledEvent, PTLog.LogStatus.Normal, "Run Event Boot " + ServerName, item.ScheduleType + (overtime ? " -OVERTIME" + item.LastCompleted : ""));
                        }
                        else PTLog.InsertSystemLog(PTLog.LogType.ScheduledEvent, PTLog.LogStatus.Normal, "Run Event " + ServerName, item.ScheduleType + (overtime ? " -OVERTIME" + item.LastCompleted : ""));


                        item.UpdateTime();
						IEvent e = item.IEventInstance;
						ManagedThreadPool.QueueUserWorkItem(new WaitCallback(e.Execute));
                        
					}
				}
			}
		}
	}
}
